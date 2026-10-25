# ADR-0003 — Cycle de vie de la donne en typestate

- Statut : accepté
- Date : 2026-10-23
- Portée : contexte Tarot, agrégat `Donne`

## Contexte et problème
Une donne traverse des phases dont chacune autorise des actions différentes :
annoncer pendant les enchères, écarter après une prise ou une garde, jouer une
carte pendant les plis. Il faut décider si le respect de ces phases est vérifié
à la compilation ou à l'exécution.

## Décision
Chaque phase est un type distinct, par exemple `DonneEnEnchères`,
`DonneEnÉcart`, `DonneEnJeu`. Une action consomme la phase courante et rend la
suivante. Jouer une carte pendant les enchères ne compile pas.

## Alternatives considérées
- **Un seul type avec un état interne, contrôlé à l'exécution.** Rejetée : plus
  simple, mais elle laisse au test ce que le compilateur peut garantir, et
  l'apprenant y perd le travail de l'ownership par valeur.

## Conséquences
- Les transitions illégales disparaissent du domaine de test.
- L'issue d'une transition n'est connue qu'à l'exécution (redistribuer, écarter
  ou jouer après les enchères) : ces transitions rendent un enum des phases
  possibles, et la boucle du terminal tient cet enum.
- Une action refusée (carte illégale, annonce trop basse, écart interdit) ne
  peut pas perdre la phase qu'elle a consommée : elle la rend avec le refus,
  pour que le joueur rejoue sur la même donne.
- Consommer `self` à chaque action impose de penser la propriété des cartes
  dès la task 2 : c'est voulu, et c'est aussi une marche de plus pour un
  apprenant qui reprend Rust.

## Sources
Cliff L. Biffle, « The Typestate Pattern in Rust », 2019-06-05,
https://cliffle.com/blog/rust-typestate/.
