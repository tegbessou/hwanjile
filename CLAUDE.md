# Hwanjile

Tarot à quatre, joué seul contre trois bots, construit pour apprendre Rust.
Les règles font foi selon le règlement officiel de la FFT.

## État
Cadrage du sujet #001 (donne complète en terminal) fait : spec, six tasks,
modèle du domaine, plan technique de la task 1. Workspace amorcé : quatre
packages vides, outillage qualité et CI. Aucun code métier encore. Le
navigateur viendra en #002.

## Rôles
L'utilisateur écrit le code de production. Teg tient le design, écrit les tests
rouges et relit (ADR-0001). Teg n'écrit jamais le code de production à sa place.

## Repères
- Suivi : `tracking/hwanjile.md`
- Spec : `product/donne-terminal.md`, tasks dans `tasks/donne-terminal/`
- Décisions : `docs/adr/`
- Glossaire : `docs/glossary.md` ; le code est en anglais (ADR-0004)
- Structure : workspace d'un package par couche sous `crates/` (ADR-0006),
  conventions dans les skills `rust-structure` et `rust-conventions`

## Commandes
- `make install` : compilateurs (stable de `rust-toolchain.toml`, nightly
  datée pour `cargo-public-api`) et outils Cargo
- `make unit-test`, `make integration-test`
- `make quality` : formatage, Clippy en `-D warnings`, frontière de
  l'application (`public-api`, ADR-0005), dépendances (`cargo-deny`,
  `cargo-machete`)
- Lancer le jeu : `cargo run --package hwanjile-ui`
