# Hwanjile

Tarot à quatre, joué seul contre trois bots, construit pour apprendre Rust.
Les règles font foi selon le règlement officiel de la FFT.

## État
Cadrage du sujet #001 (donne complète en terminal) fait : spec, six tasks,
modèle du domaine, plan technique de la task 1. Package amorcé : couches
vides sous `src/tarot/`, outillage qualité et CI. Aucun code métier encore. Le
navigateur viendra en #002.

## Rôles
L'utilisateur écrit le code de production. Teg tient le design, écrit les tests
rouges et relit (ADR-0001). Teg n'écrit jamais le code de production à sa place.

## Repères
- Suivi : `tracking/hwanjile.md`
- Spec : `product/donne-terminal.md`, tasks dans `tasks/donne-terminal/`
- Décisions : `docs/adr/`
- Glossaire : `docs/glossary.md` ; le code est en anglais (ADR-0004)
- Structure : un package, couches en modules sous `src/tarot/` (ADR-0008),
  conventions dans les skills `rust-structure` et `rust-conventions`

## Commandes
- `make install` : compilateurs (stable de `rust-toolchain.toml`, nightly
  datée pour cargo-pup) et outils Cargo
- `make unit-test`, `make integration-test`
- `make quality` : formatage, Clippy en `-D warnings`, sens des couches
  (`make architecture`, cargo-pup et `pup.ron`, ADR-0008), dépendances
  (`cargo-deny`, `cargo-machete`)
- Lancer le jeu : `cargo run`
