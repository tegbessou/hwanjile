# ADR-0008 — Un seul package, couches gardées par cargo-pup

- Statut : proposé
- Date : 2026-10-27
- Portée : projet Hwanjile, tout le code ; remplace ADR-0006, et ADR-0007
  sur la vérification `public-api` et la dépendance de l'infrastructure

## Contexte et problème
ADR-0006 a posé un package par couche pour que le compilateur garde le sens
des dépendances. Le bootstrap en a montré le coût : quatre manifestes, des
noms préfixés, et une vérification de l'API publique de l'application qui a
demandé trois tours de revue sans se fermer. La disposition vient de projets
de 10 000 lignes et plus ; les références d'une application de la taille de
Hwanjile tiennent en un package découpé en modules. Il faut décider de la
structure, et de ce qui garde le sens des couches.

## Décision
- Un seul package `hwanjile`, une bibliothèque et un binaire. Les couches
  sont des modules sous le bounded context : `src/tarot/domain`,
  `src/tarot/application`, `src/tarot/infrastructure`, `src/tarot/ui`. Le
  niveau `tarot` anticipe un second contexte, comme `php-structure`.
- cargo-pup garde le sens des couches par des règles d'import, dans
  `pup.ron` : le domaine n'importe aucune autre couche, l'application et
  l'infrastructure n'importent que le domaine, l'interface n'importe pas le
  domaine. La cible `make architecture` le lance, dans `make quality`.
- La règle d'ADR-0005 sur ce qui circule à travers la frontière reste ; un
  type du domaine reçu par une signature de l'application se vérifie en
  relecture.

## Alternatives considérées
- **Garder le workspace d'ADR-0006.** Rejetée : la garantie du compilateur
  couvre tous les imports, mais au prix d'une structure dimensionnée pour un
  projet bien plus gros, et l'analyse du code mort ne voit plus un élément
  `pub` inutilisé d'un autre package.
- **Un seul package gardé par la relecture seule**, comme les références.
  Rejetée : l'utilisateur débute en Rust et veut un filet en plus.
- **mille.** Rejetée : à l'essai, il manque les imports entre accolades,
  `super::` et l'import d'un module entier.

## Conséquences
- cargo-pup ne lit que les `use` : un chemin complet écrit dans le code sans
  `use` lui échappe, et reste à la relecture.
- Une seconde nightly figée (`nightly-2026-01-22`, Rust 1.95) avec les
  composants internes du compilateur, lancée avec `--ignore-rust-version`.
  Le code doit compiler en 1.95 : une fonctionnalité stabilisée après fait
  échouer `make architecture`.
- cargo-pup est jeune (0.1.8) ; ses règles comparent des motifs aux chemins
  importés.
- Les cibles `public-api` et la règle `wrappers` de `cargo-deny`
  disparaissent.

## Sources
- Fil « Modern Rust Project Layouts », users.rust-lang.org : « Don't split
  for purely organizational purposes — use modules for organization ».
- Luca Palmieri, _Zero To Production in Rust_, dépôt `zero-to-production` :
  un package, couches en modules.
- How To Code It, « Master hexagonal architecture in Rust » : un package,
  `domain`, `inbound`, `outbound`.
- Aleksey Kladov (matklad), « Large Rust Workspaces », 2021-08-22 : la
  disposition en workspace, pour 10 000 à 1 000 000 de lignes.
- cargo-pup, https://github.com/DataDog/cargo-pup ; essai sur un projet
  jetable le 2026-10-27, huit violations, comparé à mille 0.0.14.
