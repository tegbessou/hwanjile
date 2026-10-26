# ADR-0005 — Commandes et lectures par handlers, sans bus

- Statut : accepté
- Date : 2026-10-26
- Portée : projet Hwanjile, tout le code ; remplace la conséquence
  d'ADR-0003 sur la boucle du terminal

## Contexte et problème
La posture de référence retient CQRS au niveau moyen : commandes et requêtes
distinctes, traitées par des handlers distincts orchestrés par la couche
application, sans que la séparation soit infrastructurelle. ADR-0003 laissait
la boucle du terminal tenir la phase courante de la donne : l'interface lisait
alors le domaine sans passer par l'application. Il faut décider qui détient la
donne et par où passent commandes et lectures.

## Décision
- Toute entrée de l'interface est une commande ou une requête, traitée par
  son handler dans l'application. Pas de bus : l'interface appelle le handler.
- Les handlers ne gardent pas d'état. Ils chargent et rangent la phase
  courante de la donne par un port de dépôt, défini par l'application et
  implémenté en mémoire par l'infrastructure.
- Commandes, requêtes, modèles de lecture et erreurs rendues à l'interface
  sont des types définis par l'application, jamais des types du domaine. Le
  handler de commande reconstruit les valeurs du domaine ; le handler de
  lecture traduit l'`Observation` en modèle de lecture.
- Un handler de lecture passe par l'agrégat, ce qui s'écarte de la position
  par défaut de `cqrs.md` (les requêtes ne passent pas par les agrégats).

## Alternatives considérées
- **Le terminal tient la phase et la lit directement.** Rejetée : l'interface
  franchit la frontière de l'application, et #002 devrait réécrire ce que le
  terminal orchestre.
- **Bus de commandes et de requêtes.** Rejetée : un bus découple l'émetteur du
  traitement et porte des préoccupations transverses (transaction,
  asynchronisme) ; aucune n'existe ici.
- **Requêtes qui lisent le stockage sans passer par l'agrégat.** Rejetée : ce
  qu'un siège a le droit de voir est une règle du domaine (ADR-0002), qu'une
  lecture directe contournerait.
- **Requêtes qui rendent l'`Observation` du domaine.** Rejetée : l'interface
  manipulerait des types du domaine. Cargo empêche le terminal de nommer un
  type du domaine (ADR-0006), pas d'en recevoir un par une signature de
  l'application : cette absence se vérifie en relecture.

## Conséquences
- La garantie de compilation du typestate s'arrête à l'application : une
  commande hors de sa phase revient à l'interface comme une erreur à
  l'exécution.
- Une carte, un siège ont deux représentations, dans le domaine et dans
  l'application, et une traduction à maintenir.
- Le dépôt en mémoire prépare le stockage qu'exigera un serveur en #002.

## Sources
- `knowledge/posture-architecturale.md` du dispositif Teg, sections sur les
  couches et sur CQRS ; Greg Young, sur CQRS, via
  `knowledge/architecture/cqrs.md`.
- Alistair Cockburn, _Hexagonal Architecture_ : l'interface est un adaptateur
  qui pilote l'application par ses ports, via `knowledge/architecture/hexagonal.md`.
- Martin Fowler, « LocalDTO » (bliki) : le coût d'une traduction à
  l'intérieur d'un même processus, pesé ici contre la garantie de frontière.
