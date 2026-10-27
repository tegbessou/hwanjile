# ADR-0007 — Les ports vivent dans le domaine

- Statut : accepté ; vérification `public-api` et dépendance de
  l'infrastructure remplacées par ADR-0008
- Date : 2026-10-27
- Portée : projet Hwanjile, tout le code ; remplace ADR-0005 sur la couche
  qui définit le port de dépôt, et ADR-0006 sur la dépendance de
  l'infrastructure vers l'application

## Contexte et problème
ADR-0005 faisait définir le port de dépôt par l'application, et le plan de la
task 1 y plaçait aussi `Shuffler` et `DealerDraw`. Ces ports parlent le
langage du domaine : ils reçoivent ou rendent des `Card`, un `Deal`. Rangés
dans un module à part de l'application, ils formaient une couche dans la
couche, à côté de l'organisation par opération. Il faut décider où ils
vivent.

## Décision
- Un port qui sert un concept du domaine est un trait du domaine, défini à
  côté de ce concept : `DealRepository` avec la donne, `Shuffler` avec les
  cartes, `DealerDraw` avec les sièges. L'infrastructure les implémente,
  l'application les consomme.
- Les handlers de l'application reçoivent les ports par paramètre générique.
  Un trait de port apparaît donc dans l'API publique de l'application, en
  contrainte de générique et nulle part ailleurs. La règle d'ADR-0005 porte
  sur ce qui circule à travers la frontière (commandes, requêtes, modèles de
  lecture, erreurs) ; un trait de port n'y circule pas.
- L'infrastructure dépend du domaine seul. Elle ne dépend de l'application
  que pour implémenter un port purement applicatif, qui ne porte aucun type
  du domaine et reste dans l'application.

## Alternatives considérées
- **Un module `port` dans l'application.** Rejetée : un module isolé du reste
  de l'organisation par opération.
- **Un package dédié aux ports.** Rejetée : un package ajouté pour satisfaire
  l'outillage, non pour un besoin du domaine.
- **Injection par `Box<dyn Trait>`.** Sans effet : le trait apparaît aussi
  dans la signature du constructeur.

## Conséquences
- Le domaine porte des contrats qui existent pour l'extérieur (stockage,
  hasard) ; leurs implémentations restent hors du domaine.
- La vérification `public-api` retire de la sortie de `cargo-public-api` les
  traits de port en contrainte de générique d'une structure ou d'un `impl`,
  d'après une liste tenue dans le Makefile, avant de chercher le domaine.
  Chaque nouveau port s'ajoute à cette liste. Elle refuse tout `pub use` dans
  l'application, dont l'outil masque l'origine.
- La vérification attrape l'erreur accidentelle, pas le contournement
  délibéré. Restent à la relecture : un élément caché à l'outil
  (`#[doc(hidden)]`, `#[cfg(not(doc))]`), et une fonction publique de
  l'infrastructure qui rendrait un type du domaine au binaire.
- Le binaire ne déclare toujours pas le domaine : il passe aux handlers les
  adaptateurs de l'infrastructure sans nommer les traits qu'ils implémentent.

## Sources
- Eric Evans, _Domain-Driven Design_, chapitre 6, section « Repositories » ; Vaughn
  Vernon, _Implementing Domain-Driven Design_, chapitre 12 : l'interface du
  repository dans la couche domaine, son implémentation dans
  l'infrastructure. L'extension à `Shuffler` et `DealerDraw` est un choix du
  projet.
- `php-structure` du dispositif Teg : l'interface de repository dans le
  dossier de son agrégat.
- Sortie de `cargo-public-api` 0.52.0 sur `nightly-2026-10-25`, éprouvée sur
  un workspace minimal : une contrainte `S: Shuffler` s'affiche sur la
  structure et sur son `impl`.
