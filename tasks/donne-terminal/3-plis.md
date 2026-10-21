# Task 3 — Jouer les dix-huit plis

> Sujet : [product/donne-terminal.md](../../product/donne-terminal.md)

## Règles métier couvertes
R6, R7, R8 (partie jeu : dispense de fournir, pli non remporté, couleur fixée
par la carte suivante), R14 (partie jeu).

## Critères d'acceptation
- *Scénario : fournir sans monter*
  - Given le 10 de pique est demandé et j'ai l'as et la dame de pique
  - When je joue l'as de pique
  - Then la carte est acceptée
- *Scénario : obligation de fournir*
  - Given le 10 de pique est demandé et j'ai l'as de pique
  - When je joue le 5 de cœur
  - Then la carte est refusée avec la règle enfreinte, ma main ne change pas
- *Scénario : monter à l'atout*
  - Given le 15 d'atout est le plus fort atout du pli, j'ai le 12 et le 18
  - When je joue le 12
  - Then la carte est refusée ; seul le 18 est accepté
- *Scénario : pisser*
  - Given le 19 d'atout est sur la table, j'ai le 4 et le 9 et aucun atout
    plus fort
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
- **Agrégat** : `Donne`, racine ; ADR-0002. Phases en typestate ; ADR-0003.
- **Domain events** : aucun dans #001 ; le terminal lit la vue du siège après
  chaque action.
- **Introduit** : VO `Pli`. Phase de jeu ; la donne expose les coups légaux du
  siège qui doit jouer. Hors agrégat : politique de jeu du bot (R14).
- **Consomme** : `Carte`, `Siège`, `Main`, `Contrat`.

Partie technique : _(remplie par `technical-plan`)_
