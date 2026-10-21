# Task 5 — Afficher le résultat et la marque de la donne

> Sujet : [product/donne-terminal.md](../../product/donne-terminal.md)

## Règles métier couvertes
R8 (partie décompte), R9, R10, R12.

## Critères d'acceptation
- *Scénario : contrat passé*
  - Given une garde où le preneur réalise 49 points avec 2 bouts
  - When la donne se termine
  - Then le contrat passe de 8 ; le preneur marque +198, chaque défenseur −66
- *Scénario : contrat chuté*
  - Given une prise où le preneur réalise 44 points avec 1 bout
  - When la donne se termine
  - Then le contrat chute de 7 ; le preneur marque −96, chaque défenseur +32
- *Scénario : garde sans, chien au preneur*
  - Given une garde sans dont le chien contient le 21
  - When la donne se termine
  - Then le 21 et les points du chien comptent pour le preneur
- *Scénario : demi-point au camp gagnant*
  - Given le preneur réalise 41,5 points avec 2 bouts
  - When la donne se termine
  - Then le contrat passe de 1
- *Scénario : demi-point au camp gagnant, chute*
  - Given le preneur réalise 40,5 points avec 2 bouts
  - When la donne se termine
  - Then le contrat chute de 1
- *Scénario : échange de l'excuse*
  - Given le preneur joue l'excuse sur un pli remporté par la défense
  - When la donne se termine
  - Then l'excuse compte pour le preneur et la défense reçoit une carte à
    0,5 point de ses plis
- *Scénario : excuse au dernier pli*
  - Given le preneur joue l'excuse au dernier pli, remporté par la défense
  - When la donne se termine
  - Then l'excuse compte pour la défense

## Definition of Ready
- Cartes rouges concernées fermées ✓
- Aucune valeur sourcée marquée « provisoire » ✓
- Au moins un scénario concret ✓

## Reporté
Petit au bout (task 6).

## Plan technique
Partie domaine :
- **Bounded context** : Tarot (unique).
- **Agrégat** : `Donne`, racine ; ADR-0002. Phases en typestate ; ADR-0003.
- **Domain events** : aucun dans #001 ; le terminal lit la vue du siège après
  chaque action.
- **Introduit** : VO `Camp`, `Points` (représente le demi-point de R12),
  `Marque`. Fin de donne.
- **Consomme** : `Pli`, `Écart`, `Chien`, `Contrat`.

Partie technique : _(remplie par `technical-plan`)_
