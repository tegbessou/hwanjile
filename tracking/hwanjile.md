# Suivi des sujets produit — Hwanjile

## #001 — Donne complète en terminal
- **Ouvert le** : 2026-10-20
- **Dernière touche** : 2026-10-23
- **Échéance** : —
- **Contexte** : Projet d'apprentissage de Rust par curiosité : un tarot à
  quatre, moi contre trois bots, contrats prise / garde / garde sans, sans
  poignées ni primes de chelem. Ce premier sujet couvre une donne complète jouée depuis
  un terminal. Le navigateur viendra en #002. Quand l'apprenant et le joueur
  s'opposent, l'apprenant tranche.
- **Critère de succès** : côté joueur, je joue une donne complète en
  terminal et la marque affichée correspond au calcul à la main (le
  navigateur, critère du projet, viendra en #002). Côté apprenant, j'écris
  seul le code de production, et la relecture n'y trouve plus d'erreur
  d'ownership ni de modélisation.
- **Rôles** : j'écris le code de production ; Teg tient le design, les tests
  rouges et la relecture (ADR-0001).
- **Prochaine action** : `tdd-loop` de la task 1
- **Spec** : `product/donne-terminal.md`
- **Notes** :
  - 2026-10-20 — problème validé en phase 1
  - 2026-10-20 — risque principal : l'abandon, sessions intensives espacées
    sans pression extérieure ; chaque session doit finir sur un état vert
  - 2026-10-21 — phase 2 close, référence : règlement FFT « Donnes libres » ;
    spec rédigée
  - 2026-10-21 — spec validée, découpée en 6 tasks, toutes produit-prêtes
  - 2026-10-21 — domaine modélisé : `Deal` agrégat unique en typestate, pas
    de domain event ; ADR-0001 à 0003 acceptés
  - 2026-10-22 — revue PR #1 : R12 réécrite (défense ou preneur sans pli),
    R15 table et R16 pli ajoutées, écart validé d'un bloc, excuse du chelem
    retenue sans prime ; ADR-0003 repassé en proposé
  - 2026-10-23 — ADR-0003 accepté avec sa conséquence sur les actions refusées
  - 2026-10-23 — seconde revue PR #1 : R8 reprend l'excuse de la défense en
    chelem (FFT p. 8), R12 réduite au preneur sans pli, petit au bout en
    chelem ajouté à R11 (FFT p. 6)
  - 2026-10-23 — troisième et quatrième revues : la défense garde l'excuse en
    chelem même jouée au dernier pli, à condition que le preneur remporte les
    18 plis (R8)
  - 2026-10-26 — PR #1 mergée sans cinquième revue ; code en anglais
    (ADR-0004, glossaire) ; plan technique de la task 1 posé
