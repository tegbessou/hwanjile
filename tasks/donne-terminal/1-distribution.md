# Task 1 — Voir sa main après la distribution

> Sujet : [product/donne-terminal.md](../../product/donne-terminal.md)

## Règles métier couvertes
R1, R15 (place et donneur).

## Critères d'acceptation
- *Scénario : ma main est distribuée*
  - Given une nouvelle donne
  - When le jeu est distribué
  - Then je vois mes 18 cartes, ma place (Sud) et le donneur tiré au hasard ;
    les cartes sont rangées atouts du 21 au 1, puis l'excuse, puis pique,
    cœur, carreau et trèfle, chaque couleur du roi à l'as
- *Scénario : le jeu est complet*
  - Given une donne distribuée
  - When on réunit les quatre mains et le chien
  - Then on retrouve les 78 cartes, chacune une seule fois, et 6 au chien
- *Scénario : extrémités du paquet hors du chien*
  - Given un paquet mélangé dont la première carte est le roi de cœur et la
    dernière le 3 de trèfle
  - When le jeu est distribué
  - Then ni le roi de cœur ni le 3 de trèfle ne sont au chien
- *Scénario : mode debug*
  - Given le mode debug activé
  - When le jeu est distribué
  - Then je vois aussi les mains des trois bots et le chien

## Definition of Ready
- Cartes rouges concernées fermées ✓
- Aucune valeur sourcée marquée « provisoire » ✓
- Au moins un scénario concret ✓

## Reporté
Petit sec et enchères (task 2).

## Plan technique
Partie domaine :
- **Bounded context** : Tarot (unique).
- **Agrégat** : `Deal`, racine ; ADR-0002. Phases en typestate ; ADR-0003.
- **Domain events** : aucun dans #001 ; après chaque action, le terminal
  demande l'`Observation` du siège par une requête (ADR-0005).
- **Introduit** : VO `Card` (couleur et rang, atout 1 à 21, excuse ; valeur,
  bout), `Seat` (ordre du jeu), `Hand`, `Kitty`. Le domaine fournit le jeu
  complet. `DealInBidding`, première phase de `Deal`, est construite depuis
  ce jeu réordonné, les positions du chien et le donneur reçus de
  l'extérieur (le hasard reste hors du domaine). Une position du chien
  désigne un intervalle entre deux des 24 paquets de trois (1 à 23) ; six
  positions distinctes, une carte par intervalle (R1 dit « une à une » ;
  une seule carte par intervalle est un choix du projet, appuyé sur
  regles-du-jeu.net, le règlement FFT n'ayant pas pu être relu). La construction
  refuse un paquet qui n'est pas le jeu complet (78 cartes, chacune une
  fois) et des positions hors de ces bornes ou répétées.
- **Ports** (ADR-0007) : `DealRepository` dans le module de la donne,
  `Shuffler` dans celui des cartes, `DealerDraw` dans celui des sièges.
- **Lecture** : `Observation`, ce qu'un siège connaît de la donne ;
  `DebugObservation`, les quatre mains et le chien. Les actions consomment la
  phase, les lectures ne la modifient pas. `Deal` est l'enum des phases
  (ADR-0003), ce que range le dépôt.

Partie technique :
- **Structure** : un package `hwanjile`, bibliothèque et binaire, couches
  en modules sous `src/tarot/` (ADR-0008, `rust-structure`). L'interface
  n'importe pas le domaine ; l'infrastructure n'importe que le domaine ;
  gardé par `make architecture`.
- **Application** (ADR-0005) :
  - Un module par opération (`start_game`, `observe_seat`,
    `observe_table`), qui regroupe le message, son handler et son modèle de
    lecture ; `open_deal` en `pub(crate)`.
  - Commande `StartGame` et son handler : tire le premier donneur par
    `DealerDraw`, ouvre la donne par `OpenDeal`, range le `Deal` par le
    dépôt.
  - `OpenDeal`, générique sur `S: Shuffler`, partagé entre handlers et
    absent de l'API publique : `StartGame::new` le construit à partir du
    `Shuffler` reçu. Il reçoit le donneur, fait réordonner le jeu complet par le port, obtient les
    positions du chien et construit `DealInBidding` ; il rend une erreur si
    la construction refuse. La redistribution de la task 2 le rappellera
    avec le donneur connu (R15).
  - Requête `ObserveSeat` et son handler : charge le `Deal`, demande
    l'`Observation` du siège, la traduit en modèle de lecture
    `SeatObservation`.
  - Requête `ObserveTable` et son handler : même chemin pour la
    `DebugObservation`, traduite en `TableObservation`.
  - Commandes, requêtes, modèles de lecture et erreurs rendues au terminal
    sont des types définis par l'application, jamais des types du domaine
    (ADR-0005) ; les traits de port n'y apparaissent qu'en contrainte de
    générique (ADR-0007). Vérifié en relecture.
  - Pas de bus : le terminal appelle les handlers.
- **Ports & adaptateurs** :
  - `Shuffler` (réordonne le jeu reçu, tire les positions du chien) et
    `DealerDraw` (premier donneur), traits du domaine (ADR-0007) ←
    `RandChance` (`infrastructure`) implémente les deux, sur la crate `rand`
    0.10.3 (crates.io, publiée le 2026-09-20 ; docs.rs : `rand::rng`,
    `rand::seq::SliceRandom`, `rand::seq::index::sample`,
    `rand::random_range`).
  - `DealRepository` (trait du domaine, ADR-0007) ← `InMemoryDealRepository`
    (`infrastructure`). Un handler de commande reprend la donne en cours en
    pleine propriété, pour en consommer la phase, puis range la suivante ; un
    handler de lecture l'emprunte. Sans donne en cours, une requête rend une
    erreur de l'application.
- **Interface terminal** : `println!`, autorisé par
  `#![allow(clippy::print_stdout)]` en tête de `main.rs`, le lint étant actif
  dans tout le package. Appelle `StartGame`, puis
  `ObserveSeat` pour Sud ; range la main dans l'ordre du critère
  d'acceptation, règle d'affichage portée par l'interface ; affiche l'erreur
  et s'arrête si l'ouverture échoue. `--debug`, lu par `std::env::args`,
  appelle en plus `ObserveTable`.
- **Forme de la tranche** : le binaire construit les adaptateurs et les
  handlers → handler `StartGame` → `DealerDraw`, `OpenDeal` → `Shuffler` →
  `DealInBidding` → `DealRepository` ; puis handler `ObserveSeat` →
  `DealRepository` → `Observation` → `SeatObservation` rendue par le
  terminal.
- **Tests** :
  - `tests/distribution.rs` : scénarios 1 (main, place,
    donneur), 2 (jeu complet) et 3 (extrémités hors du chien, avec une
    doublure qui ordonne le jeu et place le chien au plus près des
    extrémités), par les handlers, avec des doublures de `Shuffler`,
    `DealerDraw` et `DealRepository` écrites à la main.
  - Domaine, tests de module : refus d'un paquet incomplet, refus de positions
    contraires à R1, tests propres à `Card` et `Seat`.
  - Infrastructure, tests de module : `RandChance` rend le jeu reçu, réordonné,
    et des positions conformes à R1 ; `InMemoryDealRepository` rend ce
    qu'on y a rangé.
  - Interface : rangement de la main dans ses modules ; scénario 4 dans
    `tests/`, qui lance l'exécutable avec `--debug`
    (`CARGO_BIN_EXE_<name>`).
- **Contrats externes** : aucun, hors la crate `rand`, confrontée à docs.rs.
- **Contact avec le noyau** : introduit `Card`, `Seat`, `Hand`, `Kitty`,
  `Deal`, `DealInBidding`, `Observation`, `DebugObservation`, `Shuffler`,
  `DealerDraw`, `DealRepository`, `OpenDeal`, `StartGame`, `ObserveSeat`,
  `ObserveTable`, `SeatObservation`, `TableObservation`, `RandChance`,
  `InMemoryDealRepository` ; consomme rien.
