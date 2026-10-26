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
- *Scénario : excuse de la défense sans pli*
  - Given une garde où le preneur remporte les 18 plis avec 2 bouts, Est
    ayant joué l'excuse au dernier pli
  - When la donne se termine
  - Then l'excuse compte 4 points pour la défense ; le preneur réalise
    87 points, le contrat passe de 46
- *Scénario : preneur sans pli*
  - Given une prise où le preneur joue l'excuse au cinquième pli, ne remporte
    aucun pli, et a un écart de 12 points
  - When la donne se termine
  - Then l'excuse compte 4 points pour le preneur ; il réalise 16 points avec
    1 bout, le contrat chute de 35 ; le preneur marque −180, chaque
    défenseur +60
- *Scénario : excuse jouée avant tout pli de son camp*
  - Given le preneur joue l'excuse au premier pli, remporté par Est
  - When le preneur remporte ensuite son premier pli
  - Then l'excuse compte pour le preneur, et une carte à 0,5 point passe à
    la défense dès que les plis du preneur en contiennent une
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
- **Agrégat** : `Deal`, racine ; ADR-0002. Phases en typestate ; ADR-0003.
- **Domain events** : aucun dans #001 ; après chaque action, le terminal
  demande la vue du siège par une requête (ADR-0005).
- **Introduit** : VO `Side`, `Points` (au demi-point près ; l'excuse vaut
  4 dans les cas de R8 et R12),
  `Score`. Fin de donne.
- **Consomme** : `Trick`, `Discard`, `Kitty`, `Contract`.

Partie technique : _(remplie par `technical-plan`)_
