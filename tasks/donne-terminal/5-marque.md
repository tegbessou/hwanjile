# Task 5 — Afficher le résultat et la marque de la donne

> Sujet : [product/donne-terminal.md](../../product/donne-terminal.md)

## Règles métier couvertes
R8 (partie décompte et dernier pli), R9, R10, R12.

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
- *Scénario : demi-point, défense sans pli*
  - Given une garde où le preneur remporte les 18 plis avec 2 bouts, la
    défense ayant joué l'excuse
  - When la donne se termine
  - Then le preneur réalise 86,5 points arrondis à 87, le contrat passe de 46
- *Scénario : excuse jouée avant tout pli de son camp*
  - Given le preneur joue l'excuse au premier pli, remporté par Est
  - When le preneur remporte ensuite son premier pli
  - Then l'excuse compte pour le preneur et une carte à 0,5 point de ce pli
    passe à la défense
- *Scénario : échange de l'excuse*
  - Given le preneur joue l'excuse sur un pli remporté par la défense
  - When la donne se termine
  - Then l'excuse compte pour le preneur et la défense reçoit une carte à
    0,5 point prise dans les plis du preneur
- *Scénario : excuse au dernier pli*
  - Given le preneur joue l'excuse au dernier pli, remporté par la défense
  - When la donne se termine
  - Then l'excuse compte pour la défense
- *Scénario : excuse au dernier pli, preneur maître de tous les plis*
  - Given le preneur a remporté les dix-sept premiers plis
  - When il joue l'excuse au dernier pli
  - Then il remporte ce pli, sans prime de chelem

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
