# ADR-0001 — L'apprenant écrit le code de production

- Statut : accepté
- Date : 2026-10-21
- Portée : projet Hwanjile, toutes les tasks

## Contexte et problème
Hwanjile existe pour apprendre Rust ; quand l'apprenant et le joueur
s'opposent, l'apprenant tranche. Le pipeline Teg fait générer le code de
production par Teg après validation du design. Appliqué tel quel, il livrerait
un tarot qui marche à un développeur qui sait relire du Rust, sans savoir en
écrire.

## Décision
J'écris le code de production. Teg tient le design, écrit les tests rouges
issus des critères d'acceptation, et relit mon code. Le volet apprenant du
critère de succès en découle : la relecture ne trouve plus d'erreur d'ownership
ni de modélisation dans ce que j'écris seul.

## Alternatives considérées
- **Teg écrit tout, comme dans le pipeline habituel.** Rejetée : l'effet de
  génération veut qu'on retienne mieux ce qu'on produit que ce qu'on lit ;
  relire ne suffit pas à apprendre à écrire.
- **Partage par couche : moi le moteur, Teg l'interface.** Rejetée : le
  découpage en tranches verticales fait traverser les deux à chaque task, et
  l'interface navigateur (#002) est elle-même un terrain d'apprentissage.

## Conséquences
- Le `tdd-loop` change de mains : Teg écrit le test rouge, je fais passer au
  vert, le refactor se discute ensemble.
- La production est plus lente, et chaque session doit finir sur un état vert
  pour que la reprise reste possible après une longue pause.
- La relecture de Teg devient le principal retour d'apprentissage ; une
  relecture complaisante viderait la décision de son objet.
- Aucun skill `rust-conventions` n'existe : la relecture s'appuie d'abord sur
  les pratiques courantes de l'écosystème, signalées comme telles, et le skill
  s'écrit au fil du projet.

## Sources
Slamecka et Graf, « The generation effect » (1978), pour l'effet de
génération ; son application à l'écriture de code est une inférence.
Arbitrage contextuel pour le reste.
