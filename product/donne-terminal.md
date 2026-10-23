# Donne complète en terminal

## Contexte
Hwanjile est un tarot à quatre joué seul contre trois bots, construit pour
apprendre Rust. Ce premier sujet livre une donne complète, jouée depuis un
terminal. Les règles font foi selon le règlement officiel de la Fédération
française de tarot.

## Utilisateurs
Moi, seul joueur humain, face à trois bots.

## Objectif
Jouer une donne de bout en bout, de la distribution à la marque, sans qu'aucun
coup illégal ne soit accepté.

## Scénario principal
1. Un donneur est tiré au hasard. Le jeu est mélangé puis distribué (R1,
   R15).
2. Les enchères font un tour, à partir de la droite du donneur (R3).
3. En prise ou en garde, le chien est montré à tous, puis le preneur fait son
   écart (R4). En garde sans, le chien reste fermé (R5).
4. Les dix-huit plis se jouent ; le joueur à droite du donneur entame, le
   gagnant d'un pli entame le suivant (R6 à R8, R15, R16).
5. Les points du preneur sont comptés, le contrat est passé ou chuté, puis la
   marque de chaque joueur est affichée (R9 à R12).

Je vois ma main, le pli en cours, et le chien quand il est retourné. Un mode
debug montre en plus les mains des bots.

## Variantes et cas limites
- Tout le monde passe : la donne est redistribuée par le voisin de droite du
  donneur, et je le vois.
- Un joueur a le petit sec : la donne est annulée et redistribuée de même
  (R2), et je le vois.
- Je joue une carte illégale : elle est refusée avec la règle enfreinte, ma
  main ne change pas.
- L'excuse est jouée alors que son camp n'a encore remporté aucun pli : la
  carte d'échange est donnée au premier pli que ce camp remporte.
- Un bot preneur fait son écart lui-même, sous les mêmes interdits que moi.
- Le preneur remporte tous les plis : l'excuse et le petit au bout suivent la
  règle du chelem (R8, R11), sans prime de chelem.
- Le preneur ne remporte aucun pli : il garde l'excuse s'il l'a jouée avant
  le dernier pli (R12).

## Règles métier
- **R1 — Distribution.** Trois cartes par trois, dans le sens inverse des
  aiguilles d'une montre. 18 cartes par joueur, 6 au chien, posées une à une ;
  ni la première ni la dernière carte du paquet ne va au chien.
- **R2 — Petit sec.** Un joueur dont le seul atout est le petit, sans l'excuse,
  fait annuler la donne avant les enchères.
- **R3 — Enchères.** Chacun parle une fois, dans l'ordre du jeu. Une annonce
  dépasse la précédente : prise < garde < garde sans. Si tous passent, on
  redistribue.
- **R4 — Écart.** Le preneur intègre le chien et choisit ses 6 cartes
  d'écart en une fois, ni roi ni bout. Il n'y met d'atouts qu'à hauteur de ce
  qui lui manque en cartes écartables hors atout pour arriver à 6, et ces
  atouts sont montrés. L'écart compte pour le preneur.
- **R5 — Garde sans.** Le chien reste fermé et compte pour le preneur, bouts
  compris.
- **R6 — Fournir.** On joue la couleur demandée, sans obligation de monter.
- **R7 — Couper et monter.** Sans la couleur, on coupe. À l'atout, on monte
  sur le plus fort atout déjà joué, même s'il est au partenaire ; faute de
  pouvoir monter, on pisse. Sans couleur ni atout, on défausse.
- **R8 — Excuse.** Elle dispense de fournir et ne remporte pas le pli. Son camp
  la garde et donne en échange une carte à 0,5 point au camp qui remporte le
  pli. Si elle ouvre un pli, la carte suivante fixe la couleur. Jouée au
  dernier pli, elle va au camp qui remporte ce pli ; sauf si le preneur a
  remporté les dix-sept premiers plis et la joue en dernier : elle remporte
  alors le pli. Si la défense détient l'excuse et que le preneur remporte les
  18 plis, la défense la garde, même jouée au dernier pli, et elle compte
  4 points.
- **R9 — Contrat.** Le preneur doit réaliser 56, 51, 41 ou 36 points selon
  qu'il détient 0, 1, 2 ou 3 bouts.
- **R10 — Marque.** Le total vaut (25 + écart au contrat) × coefficient :
  1 en prise, 2 en garde, 4 en garde sans. Le preneur marque trois fois ce
  total, en positif s'il passe, en négatif s'il chute ; chaque défenseur marque
  le total avec le signe opposé. La somme des quatre marques vaut zéro.
- **R11 — Petit au bout.** Le camp qui remporte le dernier pli contenant le
  petit gagne une prime de 10 × coefficient, quel que soit le résultat. Si le
  preneur a remporté les dix-sept premiers plis et joue l'excuse au dernier,
  le petit compte au bout quand il est joué à l'avant-dernier pli.
- **R12 — Preneur sans pli.** Si le preneur joue l'excuse avant le dernier pli
  et ne remporte aucun pli, il la garde sans carte d'échange, et elle compte
  4 points. Extrapolé de la règle de la défense sans pli (R8).
- **R13 — Enchère d'un bot.** Un bot dit prise s'il a au moins 2 bouts ou au
  moins 8 atouts, sinon il passe. Il ne surenchérit jamais.
- **R14 — Jeu d'un bot.** Un bot joue une carte légale au hasard, et écarte au
  hasard parmi les cartes autorisées.
- **R15 — Table.** Je suis Sud. Le jeu tourne de Sud à Est, Nord puis Ouest.
  Le joueur qui suit le donneur parle et entame le premier. Après une
  redistribution, ce même joueur devient donneur.
- **R16 — Pli.** Le pli revient au plus fort atout joué, ou à défaut à la plus
  forte carte de la couleur demandée. Son gagnant entame le pli suivant.

Exemples :
- R3 et R15 : Nord donne ; Ouest dit prise, je dis garde ; Est ne peut plus
  que dire garde sans ou passer.
- R7 : l'atout est demandé, le 15 est le plus fort atout du pli, j'ai le 12 et
  le 18 et pas l'excuse ; je dois jouer le 18.
- R9 et R10 : garde, 49 points avec 2 bouts ; le contrat passe de 8, soit
  (25 + 8) × 2 = 66 ; le preneur marque +198, chaque défenseur −66.
- R11 : garde sans passée de 4, petit mené au bout par la défense ;
  (25 + 4) × 4 − 40 = 76.
- R8 : en garde, le preneur remporte les 18 plis avec 2 bouts, la défense
  garde l'excuse, qui compte 4 points ; il réalise 87 points, le contrat passe
  de 46.
- R12 : en prise, le preneur joue l'excuse au cinquième pli et ne remporte
  aucun pli ; avec un écart de 12 points, il réalise 16 points et 1 bout ; le
  contrat chute de 35, soit 25 + 35 = 60.

## Hors-scope
- Garde contre, poignées, primes de chelem : écartées au cadrage du projet.
  Seules les règles de l'excuse et du petit au bout en cas de chelem
  s'appliquent (R8, R11).
- Plusieurs donnes enchaînées et l'ordre des donneurs : sujet ultérieur.
- Bots plus malins : sujet ultérieur.
- Rituels physiques du règlement (tirage du donneur, coupe, arbitre, fautes de
  distribution) : sans objet pour une machine.
- Interface navigateur : sujet #002.

## Critère de succès
Côté joueur : je joue une donne complète en terminal, et la marque affichée
correspond au calcul à la main. Côté apprenant : j'ai écrit seul le code de
production, et la relecture n'y trouve plus d'erreur d'ownership ni de
modélisation.

## Tasks
Découpage en tranches verticales. Détail dans `tasks/donne-terminal/`.

1. [Task 1 — Voir sa main après la distribution](../tasks/donne-terminal/1-distribution.md) — distribution, ma main affichée, mode debug.
2. [Task 2 — Désigner le preneur par les enchères](../tasks/donne-terminal/2-encheres.md) — enchères, redistribution, petit sec.
3. [Task 3 — Jouer les dix-huit plis](../tasks/donne-terminal/3-plis.md) — jeu de la carte, chien laissé de côté.
4. [Task 4 — Traiter le chien selon le contrat](../tasks/donne-terminal/4-chien-ecart.md) — chien montré, écart, garde sans.
5. [Task 5 — Afficher le résultat et la marque de la donne](../tasks/donne-terminal/5-marque.md) — décompte, contrat, marque.
6. [Task 6 — Primer le petit au bout](../tasks/donne-terminal/6-petit-au-bout.md) — prime du dernier pli.
