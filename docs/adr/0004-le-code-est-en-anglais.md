# ADR-0004 — Le code est en anglais

- Statut : accepté
- Date : 2026-10-26
- Portée : projet Hwanjile, tout le code

## Contexte et problème
Le règlement de référence (FFT) et la spec sont en français, et l'ubiquitous
language s'est formé en français pendant le cadrage. Il faut décider dans
quelle langue s'écrivent les identifiants et l'architecture du code.

## Décision
Le code est en anglais : types, fonctions, modules, couches, messages de
commit. La traduction de chaque terme du métier est fixée dans
`docs/glossary.md`, avant son entrée dans le code. La spec, les tasks et les
ADR restent en français.

## Alternatives considérées
- **Code en français avec accents** (`DonneEnÉcart`). Rejetée : Rust l'accepte
  pour les types, mais refuse un nom de module non-ASCII adossé à un fichier
  (E0754), ce qui force deux graphies d'un même terme ; et la documentation,
  les crates et les exemples de l'écosystème sont en anglais.
- **Code en français sans accents** (`DonneEnEcart`). Rejetée : une graphie
  qui n'est ni le français du métier ni l'anglais de l'écosystème.

## Conséquences
- La spec et le code ne parlent plus la même langue : le glossaire devient le
  pont obligatoire, et un terme traduit deux fois différemment est un défaut.
- Certains termes n'ont pas d'équivalent établi (contrat, siège, défense) : leur
  traduction est un choix du projet, signalé comme tel dans le glossaire.
- Les noms de code cités dans les ADR et les plans des tasks sont en anglais.

## Sources
- pagat.com, « French Tarot » : terminologie anglaise du tarot.
- `rustc --explain E0754`.
