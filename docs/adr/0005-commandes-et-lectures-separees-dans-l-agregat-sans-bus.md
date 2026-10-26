# ADR-0005 — Commandes et lectures séparées dans l'agrégat, sans bus

- Statut : proposé
- Date : 2026-10-26
- Portée : projet Hwanjile, sujet #001

## Contexte et problème
La posture de référence retient CQRS au niveau moyen : commandes et requêtes
séparées, traitées par des handlers distincts sur des bus. Hwanjile tourne dans
un seul processus, sans persistance ni concurrence, et l'état d'une donne tient
dans un seul agrégat (ADR-0002). Il faut décider ce qu'on garde de CQRS.

## Décision
La séparation commandes / lectures est tenue dans l'agrégat : une action
consomme la phase et rend la suivante (ADR-0003), une lecture
(`Observation`, `DebugObservation`) ne modifie rien. La couche application
expose des services appelés directement, sans bus ni handlers, et il n'y a
pas de read model distinct.

## Alternatives considérées
- **CQRS de la posture, avec bus et handlers.** Rejetée : un bus sert à
  découpler l'émetteur du traitement et à porter des préoccupations
  transverses (transaction, asynchronisme) ; aucune n'existe ici.
- **Aucune séparation.** Rejetée : une lecture qui modifierait la donne
  rendrait l'`Observation` d'un bot capable d'altérer la partie, ce que
  ADR-0002 exclut.

## Conséquences
- Le code s'écarte de la posture : un lecteur habitué aux projets Symfony n'y
  trouvera ni commande ni handler.
- Le jour où #002 introduit un serveur ou plusieurs parties en parallèle, la
  question du bus se repose.
- La séparation repose sur les signatures (consommer `self` ou l'emprunter)
  et non sur une structure dédiée.

## Sources
- `knowledge/posture-architecturale.md` du dispositif Teg, section CQRS.
- Bertrand Meyer, _Object-Oriented Software Construction_ : séparation
  commande / requête au niveau des méthodes ; Greg Young, sur CQRS, via
  `knowledge/architecture/cqrs.md`.
