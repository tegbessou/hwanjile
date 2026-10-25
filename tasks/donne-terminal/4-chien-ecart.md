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
  - When je propose un écart qui contient le roi de cœur
  - Then l'écart est refusé avec la règle enfreinte, et je le refais
- *Scénario : atout écarté par nécessité*
  - Given après le chien, mes seules cartes écartables hors atout sont 4
    cartes de couleur
  - When je propose un écart de ces 4 cartes et de 2 atouts
  - Then l'écart est accepté et les 2 atouts sont montrés à la défense
- *Scénario : atout écarté au plus juste*
  - Given après le chien, j'ai 5 cartes écartables hors atout
  - When je propose un écart de ces 5 cartes et de 1 atout
  - Then l'écart est accepté et l'atout est montré à la défense
- *Scénario : atout écarté sans nécessité*
  - Given après le chien, j'ai 5 cartes écartables hors atout
  - When je propose un écart de 4 d'entre elles et de 2 atouts
  - Then l'écart est refusé avec la règle enfreinte, et je le refais
- *Scénario : garde sans*
  - Given Nord est preneur en garde sans
  - When les enchères se terminent
  - Then le chien n'est montré à personne et le jeu commence
- *Scénario : bot preneur*
  - Given un bot preneur en prise
  - When il fait son écart
  - Then l'écart contient 6 cartes, sans roi ni bout, et pas plus d'atouts
    que R4 n'en autorise

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

- **Note** : l'écart se valide d'un bloc ; la règle d'atout ne se juge que
  sur les 6 cartes proposées ensemble.

Partie technique : _(remplie par `technical-plan`)_
