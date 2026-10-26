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
- **Domain events** : aucun dans #001 ; le terminal lit l'`Observation` du
  siège après chaque action.
- **Introduit** : VO `Card` (couleur et rang, atout 1 à 21, excuse ; valeur,
  bout), `Seat` (ordre du jeu), `Hand`, `Kitty`. `DealInBidding`, première
  phase de `Deal`, construite depuis un paquet déjà mélangé, les positions du
  chien et le donneur reçus de l'extérieur (le hasard reste hors du
  domaine). Sa construction refuse un paquet qui n'est pas le jeu complet
  (78 cartes, chacune une fois) et des positions de chien contraires à R1.
- **Lecture** : `Observation`, ce qu'un siège connaît de la donne ;
  `DebugObservation`, les quatre mains et le chien. Les actions consomment la
  phase, les lectures ne la modifient pas ; ADR-0005.

Partie technique :
- **Packages** : workspace d'un package par couche ; ADR-0006,
  `rust-structure`. `hwanjile-domain`, `hwanjile-application`,
  `hwanjile-infrastructure`, et le binaire `hwanjile-terminal`, composition
  root.
- **Application** :
  - `OpenDeal`, générique sur `S: Shuffler`, reçoit le donneur, obtient le
    tirage du port et construit `DealInBidding`. La redistribution de la
    task 2 le rappellera avec le donneur connu (R15).
  - `StartGame`, générique sur `D: DealerDraw`, tire le premier donneur et
    ouvre la donne par `OpenDeal`.
  - Pas de bus ni de handlers ; ADR-0005.
- **Ports & adaptateurs** : `Shuffler` (paquet mélangé et positions du
  chien) et `DealerDraw` (premier donneur), définis par `application` ←
  `RandShuffler` (`infrastructure`) implémente les deux, sur la crate `rand`
  0.10.3 (crates.io, publiée le 2026-09-20 ; docs.rs : `rand::rng`,
  `rand::seq::SliceRandom`, `rand::seq::index::sample`,
  `rand::random_range`).
- **Interface terminal** : `println!`, affiche l'`Observation` de Sud et
  range la main dans l'ordre du critère d'acceptation, règle d'affichage
  portée par l'interface ; `--debug`, lu par `std::env::args`, affiche en
  plus la `DebugObservation`.
- **Forme de la tranche** : le binaire construit `RandShuffler` et
  `StartGame` → `StartGame` → `DealerDraw`, puis `OpenDeal` → `Shuffler` →
  `DealInBidding` → `Observation` rendue par le terminal.
- **Tests** :
  - `hwanjile-application/tests/distribution.rs` : scénarios 1 (main, place,
    donneur), 2 (jeu complet) et 3 (extrémités hors du chien, avec une
    doublure qui place le chien au plus près des extrémités), par des
    doublures de `Shuffler` et `DealerDraw` écrites à la main.
  - `hwanjile-domain` : refus d'un paquet incomplet, refus de positions
    contraires à R1, tests propres à `Card` et `Seat`.
  - `hwanjile-infrastructure` : `RandShuffler` rend le jeu complet et des
    positions conformes à R1.
  - Binaire, dans ses modules : rangement de la main, scénario 4 (`--debug`).
- **Contrats externes** : aucun, hors la crate `rand`, confrontée à docs.rs.
- **Contact avec le noyau** : introduit `Card`, `Seat`, `Hand`, `Kitty`,
  `DealInBidding`, `Observation`, `DebugObservation`, `Shuffler`,
  `DealerDraw`, `OpenDeal`, `StartGame`, `RandShuffler` ; consomme rien.
