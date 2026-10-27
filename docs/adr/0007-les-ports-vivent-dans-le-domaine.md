# ADR-0007 — Les ports vivent dans le domaine

- Statut : accepté
- Date : 2026-10-27
- Portée : projet Hwanjile, tout le code ; remplace ADR-0005 sur la couche
  qui définit le port de dépôt

## Contexte et problème
ADR-0005 faisait définir le port de dépôt par l'application, et le plan de la
task 1 y plaçait aussi `Shuffler` et `DealerDraw`. Ces ports parlent le
langage du domaine (ils reçoivent ou rendent des `Card`, un `Deal`) et doivent
être publics pour que l'infrastructure les implémente. Dans l'application, ils
entreraient dans son API publique, où ADR-0005 interdit tout type du domaine,
et la vérification `public-api` échouerait. Il faut décider où ils vivent.

## Décision
Un port qui sert un concept du domaine est un trait du domaine, défini à côté
de ce concept : `DealRepository` avec la donne, `Shuffler` avec les cartes,
`DealerDraw` avec les sièges. L'infrastructure les implémente, l'application
les consomme. L'API publique de l'application ne contient que ses opérations.

## Alternatives considérées
- **Un module `port` dans l'application, exclu de la vérification.** Rejetée :
  un module isolé du reste de l'organisation par opération, et une exception
  à maintenir dans la vérification.
- **Un package dédié aux ports.** Rejetée : un package ajouté pour satisfaire
  l'outillage, non pour un besoin du domaine.

## Conséquences
- Le domaine porte des contrats qui existent pour l'extérieur (stockage,
  hasard) ; leurs implémentations restent hors du domaine.
- La vérification `public-api` s'applique à toute l'API de l'application,
  sans exception.
- Un port purement applicatif, qui ne porte aucun type du domaine, resterait
  dans l'application.

## Sources
- Eric Evans, _Domain-Driven Design_, chapitre « Repositories » ; Vaughn
  Vernon, _Implementing Domain-Driven Design_, chapitre 12 : l'interface du
  repository dans la couche domaine, son implémentation dans
  l'infrastructure.
- `php-structure` du dispositif Teg : l'interface de repository dans le
  dossier de son agrégat.
