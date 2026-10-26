# ADR-0002 — La donne, agrégat unique

- Statut : accepté
- Date : 2026-10-21
- Portée : contexte Tarot, sujet #001

## Contexte et problème
Les règles d'une donne lient ses parties entre elles : la légalité d'une carte
(R6 à R8) dépend de la main et du pli en cours, l'écart (R4) de la main et du
chien, la marque (R9 à R12) des plis, de l'écart et du contrat. Il faut décider
où passe la frontière de cohérence.

## Décision
`Deal` est l'unique agrégat du sujet, et sa racine. Il porte enchères, chien,
écart, plis et marque. Les bots restent hors de l'agrégat : ils décident à
partir de la vue de leur siège et des coups légaux qu'elle expose.

## Alternatives considérées
- **Enchères dans un agrégat séparé, reliées à la donne par le fait « preneur
  désigné ».** Rejetée : Vernon recommande des agrégats petits pour limiter la
  contention et la portée transactionnelle ; avec un seul joueur humain, sans
  persistance ni concurrence, la séparation coûte sans rien protéger.
- **Un agrégat par pli.** Rejetée : R7 et R8 (excuse au dernier pli) et la
  marque traversent les plis.

## Conséquences
- Un seul point d'entrée garantit toutes les règles ; aucune coordination
  entre agrégats.
- L'agrégat est gros. Si l'enchaînement de plusieurs donnes ou un mode réseau
  introduit de la concurrence, la frontière est à rouvrir.
- La vue par siège devient une responsabilité de l'agrégat : un joueur ne voit
  que sa main, et un bot ne peut pas tricher par construction.

## Sources
Vernon, _Effective Aggregate Design_ (règles de frontière et de taille), via
`knowledge/ddd/aggregates.md`.
