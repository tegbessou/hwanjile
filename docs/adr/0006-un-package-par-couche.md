# ADR-0006 — Un package par couche

- Statut : accepté
- Date : 2026-10-26
- Portée : projet Hwanjile, tout le code

## Contexte et problème
Le domaine ne doit dépendre ni de l'application ni de l'infrastructure. Dans
un package Rust unique, les modules s'importent librement : `pub(crate)` ne
sépare pas une couche d'une autre, ce que la revue de la PR #13 du dispositif
Teg a montré en compilant le contre-exemple. Il faut décider ce qui garde le
sens des dépendances.

## Décision
Un workspace Cargo, un package par couche, à plat sous `crates/` :
`hwanjile-domain` sans dépendance vers une autre couche,
`hwanjile-application` qui dépend du domaine, `hwanjile-infrastructure` qui
dépend des deux, et le binaire `hwanjile-ui`, qui dépend de
l'application et de l'infrastructure mais pas du domaine (ADR-0005). Un
import contraire au sens des couches ne compile pas ; un type reçu par une
signature, lui, n'est pas arrêté par Cargo (ADR-0005).

## Alternatives considérées
- **Un package bibliothèque + binaire, sens gardé par la relecture.**
  Rejetée : la garantie ne tient qu'à la vigilance de la revue, et #002
  demandera de toute façon de partager le cœur entre deux interfaces.
- **Un package par bounded context.** Sans objet : le projet n'a qu'un
  contexte.

## Conséquences
- Quatre `Cargo.toml` à tenir, et `pub` sur tout ce qu'une couche expose à
  la suivante.
- Les tests d'intégration se répartissent par package.
- Un second bounded context rouvre la décision : un package par contexte et
  par couche, ou un package par contexte avec ses couches en modules.
- La disposition reprend celle de matklad, conçue pour des projets bien plus
  gros : elle est ici surdimensionnée en volume, choisie pour la garantie.

## Sources
- Cargo Book, « Workspaces ».
- Aleksey Kladov (matklad), « Large Rust Workspaces », 2021-08-22.
