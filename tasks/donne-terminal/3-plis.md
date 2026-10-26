# Task 3 — Jouer les dix-huit plis

> Sujet : [product/donne-terminal.md](../../product/donne-terminal.md)

## Règles métier couvertes
R6, R7, R8 (partie jeu : dispense de fournir, pli non remporté, couleur fixée
par la carte suivante), R14 (partie jeu), R15 (première entame), R16.

## Critères d'acceptation
- *Scénario : première entame*
  - Given Nord a donné
  - When le jeu commence
  - Then Ouest entame le premier pli
- *Scénario : pli remporté à l'atout*
  - Given le roi de cœur est demandé, Est coupe du 3 d'atout, les autres
    fournissent à cœur
  - When le pli est complet
  - Then Est remporte le pli
- *Scénario : pli remporté à la couleur*
  - Given le 7 de cœur est demandé, les autres jouent le roi de cœur, le 9 de
    cœur et le roi de pique, sans atout
  - When le pli est complet
  - Then le joueur du roi de cœur remporte le pli
- *Scénario : fournir sans monter*
  - Given le 10 de pique est demandé et j'ai l'as et la dame de pique
  - When je joue l'as de pique
  - Then la carte est acceptée
- *Scénario : obligation de fournir*
  - Given le 10 de pique est demandé et j'ai l'as de pique
  - When je joue le 5 de cœur
  - Then la carte est refusée avec la règle enfreinte, ma main ne change pas
- *Scénario : monter à l'atout*
  - Given l'atout est demandé, le 15 est le plus fort atout du pli, j'ai le 12
    et le 18 et pas l'excuse
  - When je joue le 12
  - Then la carte est refusée ; seul le 18 est accepté
- *Scénario : pisser*
  - Given l'atout est demandé, le 19 est le plus fort atout du pli, j'ai le 4
    et le 9 et aucun atout plus fort
  - When je joue le 4
  - Then la carte est acceptée
- *Scénario : défausse*
  - Given le roi de carreau est demandé, je n'ai ni carreau ni atout
  - When je joue le 7 de trèfle
  - Then la carte est acceptée
- *Scénario : excuse en ouverture*
  - Given j'entame de l'excuse
  - When Est joue le 8 de cœur
  - Then les joueurs suivants doivent fournir à cœur
- *Scénario : enchaînement des plis*
  - Given Ouest remporte le pli
  - When le pli suivant commence
  - Then Ouest entame
- *Scénario : bot légal*
  - Given un bot qui doit jouer
  - When il joue
  - Then sa carte respecte R6 à R8

## Definition of Ready
- Cartes rouges concernées fermées ✓
- Aucune valeur sourcée marquée « provisoire » ✓
- Au moins un scénario concret ✓

## Reporté
Le chien reste de côté, sans écart, quel que soit le contrat (task 4).
L'échange de l'excuse et l'excuse au dernier pli comptent pour le décompte
(task 5).

## Plan technique
Partie domaine :
- **Bounded context** : Tarot (unique).
- **Agrégat** : `Deal`, racine ; ADR-0002. Phases en typestate ; ADR-0003.
- **Domain events** : aucun dans #001 ; le terminal lit la vue du siège après
  chaque action.
- **Introduit** : VO `Trick`. Phase de jeu ; la donne expose les coups légaux du
  siège qui doit jouer. Hors agrégat : politique de jeu du bot (R14).
- **Consomme** : `Card`, `Seat`, `Hand`, `Contract`.

Partie technique : _(remplie par `technical-plan`)_
