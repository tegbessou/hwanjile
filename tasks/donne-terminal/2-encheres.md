# Task 2 — Désigner le preneur par les enchères

> Sujet : [product/donne-terminal.md](../../product/donne-terminal.md)

## Règles métier couvertes
R2, R3, R13, R15 (ordre de parole, donneur après redistribution).

## Critères d'acceptation
- *Scénario : ordre de parole*
  - Given Nord donne
  - When les enchères commencent
  - Then Ouest parle le premier, puis moi, puis Est, puis Nord
- *Scénario : surenchère*
  - Given Nord donne et Ouest dit prise
  - When je dis garde
  - Then Est ne peut que dire garde sans ou passer
- *Scénario : annonce trop basse refusée*
  - Given Nord donne et Ouest a dit garde
  - When je dis prise
  - Then l'annonce est refusée avec la règle enfreinte, et je reparle
- *Scénario : tout le monde passe*
  - Given Nord donne, et Ouest, moi puis Est avons passé
  - When Nord passe
  - Then la donne est redistribuée par Ouest, et je le vois
- *Scénario : bot preneur*
  - Given un bot avec 2 bouts et 5 atouts, à qui la parole arrive avant
    toute annonce
  - When il parle
  - Then il dit prise
- *Scénario : bot sans surenchère*
  - Given un bot avec 3 bouts et 12 atouts, après une prise
  - When il parle
  - Then il passe
- *Scénario : petit sec*
  - Given une main dont le seul atout est le petit, sans l'excuse
  - When la distribution se termine
  - Then la donne est annulée avant les enchères et redistribuée par le
    voisin de droite du donneur, et je le vois

## Definition of Ready
- Cartes rouges concernées fermées ✓
- Aucune valeur sourcée marquée « provisoire » ✓
- Au moins un scénario concret ✓

## Reporté
Chien et écart (task 4) ; le preneur désigné ici n'a encore aucun effet sur le
jeu.

## Plan technique
Partie domaine :
- **Bounded context** : Tarot (unique).
- **Agrégat** : `Deal`, racine ; ADR-0002. Phases en typestate ; ADR-0003.
- **Domain events** : aucun dans #001 ; après chaque action, le terminal
  demande la vue du siège par une requête (ADR-0005).
- **Introduit** : VO `Bid`, `Contract` (avec coefficient). Phase des
  enchères, dont l'issue est un enum : donne annulée, ou preneur désigné.
  Hors agrégat : politique d'enchère du bot (R13), à partir de la vue de son
  siège.
- **Consomme** : `Card`, `Seat`, `Hand`.

- **À reprendre au plan technique** : une action refusée (annonce trop basse)
  rend la phase avec le refus, pour que je reparle sur la même donne
  (conséquence d'ADR-0003).

Partie technique : _(remplie par `technical-plan`)_
