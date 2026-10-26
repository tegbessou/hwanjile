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
- **Domain events** : aucun dans #001 ; le terminal lit la vue du siège après
  chaque action.
- **Introduit** : VO `Card` (couleur et rang, atout 1 à 21, excuse ; valeur,
  bout), `Seat` (ordre du jeu), `Hand`, `Kitty`. Première phase de `Deal`,
  construite depuis un paquet déjà mélangé, les positions du chien et le
  donneur reçus de l'extérieur (le hasard reste hors du domaine). Vue par siège, et vue debug.

Partie technique :
- **Package** : une bibliothèque (`domain`, `application`, `infrastructure`)
  et un binaire (`ui`, composition root dans `main`) ; `rust-structure`.
- **Domaine** : `DealInBidding` est la première phase de `Deal`. Sa
  construction refuse des positions de chien contraires à R1. Le rangement de
  la main pour l'affichage est porté par `SeatView`, pour que #002 le
  réutilise.
- **Application** : service `OpenDeal`, générique sur `S: Shuffler`. Il
  obtient le tirage du port et construit `DealInBidding`. Pas de bus ni de
  CQRS : un seul processus, sans persistance ni concurrence.
- **Ports & adaptateurs** : port `Shuffler` (défini par `application`), qui
  rend le paquet mélangé, les positions du chien et le donneur ←
  adaptateur `RandShuffler` (`infrastructure`), sur la crate `rand` 0.10.3
  (crates.io, 2026-10-25 ; docs.rs : `rand::rng`,
  `rand::seq::SliceRandom`, `rand::seq::index::sample`,
  `rand::random_range`).
- **UI** : terminal en `println!`, qui affiche la `SeatView` de Sud ;
  `--debug` lu par `std::env::args` affiche en plus les mains des bots et le
  chien.
- **Forme de la tranche** : `main` construit `RandShuffler` et `OpenDeal` →
  `ui` demande l'ouverture → `OpenDeal` → `Shuffler` → `DealInBidding` →
  `SeatView` rendue par `ui`.
- **Tests** : les quatre scénarios dans `tests/distribution.rs`, par l'API
  publique ; une doublure de `Shuffler` écrite à la main fixe le tirage. Les
  tests propres à `Card` et `Seat` vivent dans leur module.
- **Contrats externes** : aucun, hors la crate `rand`, confrontée à docs.rs.
- **Contact avec le noyau** : introduit `Card`, `Seat`, `Hand`, `Kitty`,
  `DealInBidding`, `SeatView`, `Shuffler`, `OpenDeal`, `RandShuffler` ;
  consomme rien.
