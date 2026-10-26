# Task 6 — Primer le petit au bout

> Sujet : [product/donne-terminal.md](../../product/donne-terminal.md)

## Règles métier couvertes
R11.

## Critères d'acceptation
- *Scénario : petit au bout par la défense*
  - Given une garde sans passée de 4, la défense remporte le dernier pli qui
    contient le petit
  - When la donne se termine
  - Then le total vaut (25 + 4) × 4 − 40 = 76 ; le preneur marque +228,
    chaque défenseur −76
- *Scénario : petit au bout par le preneur*
  - Given une garde passée de 8, le preneur remporte le dernier pli qui
    contient le petit
  - When la donne se termine
  - Then le total vaut 66 + 20 = 86
- *Scénario : petit au bout du preneur sur un contrat chuté*
  - Given une prise chutée de 7, le preneur remporte le dernier pli qui
    contient le petit
  - When la donne se termine
  - Then le total vaut 25 + 7 − 10 = 22 ; le preneur marque −66, chaque
    défenseur +22
- *Scénario : petit au bout en chelem*
  - Given une garde où le preneur a remporté les dix-sept premiers plis, dont
    l'avant-dernier qui contient le petit
  - When il joue l'excuse au dernier pli
  - Then il réalise 91 points avec 3 bouts et la prime lui est comptée :
    (25 + 55) × 2 + 20 = 180
- *Scénario : petit joué avant le dernier pli*
  - Given le petit tombe au dixième pli
  - When la donne se termine
  - Then aucune prime n'est comptée

## Definition of Ready
- Cartes rouges concernées fermées ✓
- Aucune valeur sourcée marquée « provisoire » ✓
- Au moins un scénario concret ✓

## Reporté
Rien.

## Plan technique
Partie domaine :
- **Bounded context** : Tarot (unique).
- **Agrégat** : `Deal`, racine ; ADR-0002. Phases en typestate ; ADR-0003.
- **Domain events** : aucun dans #001 ; le terminal lit la vue du siège après
  chaque action.
- **Introduit** : rien de nouveau ; la prime s'ajoute au calcul de `Score`.
- **Consomme** : `Trick`, `Side`, `Score`.

Partie technique : _(remplie par `technical-plan`)_
