# Task 2 — Désigner le preneur par les enchères

> Sujet : [product/donne-terminal.md](../../product/donne-terminal.md)

## Règles métier couvertes
R2, R3, R13.

## Critères d'acceptation
- *Scénario : surenchère*
  - Given Est, à droite du donneur, dit prise
  - When je dis garde
  - Then Ouest ne peut que dire garde sans ou passer
- *Scénario : annonce trop basse refusée*
  - Given Est a dit garde
  - When je dis prise
  - Then l'annonce est refusée avec la règle enfreinte, et je reparle
- *Scénario : tout le monde passe*
  - Given les trois bots passent
  - When je passe
  - Then la donne est redistribuée, et je le vois
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
  - Then la donne est annulée et redistribuée avant les enchères, et je le vois

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
- **Agrégat** : `Donne`, racine ; ADR-0002. Phases en typestate ; ADR-0003.
- **Domain events** : aucun dans #001 ; le terminal lit la vue du siège après
  chaque action.
- **Introduit** : VO `Annonce`, `Contrat` (avec coefficient). Phase des
  enchères, dont l'issue est un enum : donne annulée, ou preneur désigné.
  Hors agrégat : politique d'enchère du bot (R13), à partir de la vue de son
  siège.
- **Consomme** : `Carte`, `Siège`, `Main`.

Partie technique : _(remplie par `technical-plan`)_
