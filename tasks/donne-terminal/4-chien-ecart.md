# Task 4 — Traiter le chien selon le contrat

> Sujet : [product/donne-terminal.md](../../product/donne-terminal.md)

## Règles métier couvertes
R4, R5, R14 (partie écart).

## Critères d'acceptation
- *Scénario : chien montré en garde*
  - Given je suis preneur en garde
  - When les enchères se terminent
  - Then les 6 cartes du chien sont montrées, puis ajoutées à ma main
- *Scénario : écart interdit*
  - Given je fais mon écart
  - When je choisis le roi de cœur
  - Then le choix est refusé avec la règle enfreinte
- *Scénario : atout écarté par nécessité*
  - Given après le chien, mes seules cartes hors rois et bouts sont 4 cartes
    de couleur et des atouts
  - When j'écarte 4 cartes de couleur et 2 atouts
  - Then l'écart est accepté et les 2 atouts sont montrés à la défense
- *Scénario : atout écarté sans nécessité*
  - Given il me reste des cartes de couleur écartables
  - When je choisis un atout
  - Then le choix est refusé
- *Scénario : garde sans*
  - Given Nord est preneur en garde sans
  - When les enchères se terminent
  - Then le chien n'est montré à personne et le jeu commence
- *Scénario : bot preneur*
  - Given un bot preneur en prise
  - When il fait son écart
  - Then l'écart contient 6 cartes, sans roi ni bout

## Definition of Ready
- Cartes rouges concernées fermées ✓
- Aucune valeur sourcée marquée « provisoire » ✓
- Au moins un scénario concret ✓

## Reporté
Le décompte de l'écart et du chien pour le preneur (task 5).

## Plan technique
Partie domaine :
- **Bounded context** : Tarot (unique).
- **Agrégat** : `Donne`, racine ; ADR-0002. Phases en typestate ; ADR-0003.
- **Domain events** : aucun dans #001 ; le terminal lit la vue du siège après
  chaque action.
- **Introduit** : VO `Écart`. Phase d'écart entre enchères et jeu, sautée en
  garde sans. Hors agrégat : écart du bot (R14).
- **Consomme** : `Carte`, `Main`, `Chien`, `Contrat`.

Partie technique : _(remplie par `technical-plan`)_
