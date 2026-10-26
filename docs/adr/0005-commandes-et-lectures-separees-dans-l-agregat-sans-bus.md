# ADR-0005 — Commandes et lectures séparées dans l'agrégat, sans bus

- Statut : proposé
- Date : 2026-10-26
- Portée : projet Hwanjile, sujet #001

## Contexte et problème
La posture de référence retient CQRS au niveau moyen : commandes et requêtes
distinctes, orchestrées par la couche application, sans que la séparation
soit infrastructurelle. Dans Hwanjile, la boucle du terminal tient la phase
courante de la donne (ADR-0003), et il n'existe ni stockage ni read model
d'où lire. Il faut décider où passe la séparation.

## Décision
La séparation commandes / lectures est tenue dans l'agrégat : une action
consomme la phase et rend la suivante (ADR-0003), une lecture
(`Observation`, `DebugObservation`) ne modifie rien. La couche application
expose les cas d'usage qui ouvrent ou font avancer une donne ; les lectures se
font sur la phase que tient le terminal, sans service de lecture. Pas de bus.

## Alternatives considérées
- **Services de commande et de lecture distincts dans l'application.**
  Rejetée pour les lectures : sans stockage, un service de lecture ne ferait
  que relayer l'appel à la phase que le terminal tient déjà.
- **Bus de commandes et de requêtes.** Rejetée : un bus découple l'émetteur du
  traitement et porte des préoccupations transverses (transaction,
  asynchronisme) ; aucune n'existe ici.
- **Aucune séparation.** Rejetée : une lecture qui modifierait la donne
  rendrait l'`Observation` d'un bot capable d'altérer la partie, ce que
  ADR-0002 exclut.

## Conséquences
- Le terminal lit directement le domaine, sans passer par l'application.
- Le jour où #002 introduit un serveur ou plusieurs parties en parallèle, la
  donne devra être stockée et la question d'un service de lecture se repose.
- La séparation repose sur les signatures (consommer `self` ou l'emprunter)
  et non sur une structure dédiée : c'est le niveau CQS.

## Sources
- `knowledge/posture-architecturale.md` du dispositif Teg, section CQRS.
- Bertrand Meyer, _Object-Oriented Software Construction_ : séparation
  commande / requête au niveau des méthodes ; Greg Young, sur CQRS, via
  `knowledge/architecture/cqrs.md`.
