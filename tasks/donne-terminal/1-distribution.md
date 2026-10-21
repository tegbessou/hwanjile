# Task 1 — Voir sa main après la distribution

> Sujet : [product/donne-terminal.md](../../product/donne-terminal.md)

## Règles métier couvertes
R1.

## Critères d'acceptation
- *Scénario : ma main est distribuée*
  - Given une nouvelle donne
  - When le jeu est distribué
  - Then je vois mes 18 cartes, rangées par couleur puis par force, et le
    donneur tiré au hasard
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
- **Agrégat** : `Donne`, racine ; ADR-0002. Phases en typestate ; ADR-0003.
- **Domain events** : aucun dans #001 ; le terminal lit la vue du siège après
  chaque action.
- **Introduit** : VO `Carte` (couleur et rang, atout 1 à 21, excuse ; valeur,
  bout), `Siège` (ordre du jeu), `Main`, `Chien`. Première phase de `Donne`,
  construite depuis un paquet déjà mélangé et les positions du chien reçus de
  l'extérieur (le hasard reste hors du domaine). Vue par siège, et vue debug.

Partie technique : _(remplie par `technical-plan`)_
