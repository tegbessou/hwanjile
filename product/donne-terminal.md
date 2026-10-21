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
1. Un donneur est tiré au hasard. Le jeu est mélangé puis distribué (R1).
2. Les enchères font un tour, à partir de la droite du donneur (R3).
3. En prise ou en garde, le chien est montré à tous, puis le preneur fait son
   écart (R4). En garde sans, le chien reste fermé (R5).
4. Les dix-huit plis se jouent ; le joueur à droite du donneur entame, le
   gagnant d'un pli entame le suivant (R6 à R8).
5. Les points du preneur sont comptés, le contrat est passé ou chuté, puis la
   marque de chaque joueur est affichée (R9 à R12).

Je vois ma main, le pli en cours, et le chien quand il est retourné. Un mode
debug montre en plus les mains des bots.

## Variantes et cas limites
- Tout le monde passe : la donne est redistribuée, et je le vois.
- Un joueur a le petit sec : la donne est annulée et redistribuée (R2), et je
  le vois.
- Je joue une carte illégale : elle est refusée avec la règle enfreinte, ma
  main ne change pas.
- L'excuse est jouée alors que son camp n'a encore remporté aucun pli : la
  carte d'échange est donnée au premier pli que ce camp remporte.
- Un bot preneur fait son écart lui-même, sous les mêmes interdits que moi.

## Règles métier
- **R1 — Distribution.** Trois cartes par trois, dans le sens inverse des
  aiguilles d'une montre. 18 cartes par joueur, 6 au chien, posées une à une ;
  ni la première ni la dernière carte du paquet ne va au chien.
- **R2 — Petit sec.** Un joueur dont le seul atout est le petit, sans l'excuse,
  fait annuler la donne avant les enchères.
- **R3 — Enchères.** Chacun parle une fois, dans l'ordre du jeu. Une annonce
  dépasse la précédente : prise < garde < garde sans. Si tous passent, on
  redistribue.
- **R4 — Écart.** Le preneur intègre le chien et écarte 6 cartes, ni roi ni
  bout. Un atout ne s'écarte que s'il n'a pas d'autre choix, et il est montré.
  L'écart compte pour le preneur.
- **R5 — Garde sans.** Le chien reste fermé et compte pour le preneur, bouts
  compris.
- **R6 — Fournir.** On joue la couleur demandée, sans obligation de monter.
- **R7 — Couper et monter.** Sans la couleur, on coupe. À l'atout, on monte
  sur le plus fort atout déjà joué, même s'il est au partenaire ; faute de
  pouvoir monter, on pisse. Sans couleur ni atout, on défausse.
- **R8 — Excuse.** Elle dispense de fournir et ne remporte pas le pli. Son camp
  la garde et donne en échange une carte à 0,5 point au camp qui remporte le
  pli. Si elle ouvre un pli, la carte suivante fixe la couleur. Jouée au
  dernier pli, elle change de camp.
- **R9 — Contrat.** Le preneur doit réaliser 56, 51, 41 ou 36 points selon
  qu'il détient 0, 1, 2 ou 3 bouts.
- **R10 — Marque.** (25 + écart au contrat) × coefficient : 1 en prise, 2 en
  garde, 4 en garde sans. Chaque défenseur marque ce total, le preneur le
  triple, avec le signe inverse. La somme des quatre marques vaut zéro.
- **R11 — Petit au bout.** Le camp qui remporte le dernier pli contenant le
  petit gagne une prime de 10 × coefficient, quel que soit le résultat.
- **R12 — Demi-point.** Il va au camp gagnant. Extrapolé de la règle FFT à
  trois et cinq joueurs, le règlement ne disant rien à quatre.
- **R13 — Enchère d'un bot.** Un bot dit prise s'il a au moins 2 bouts ou au
  moins 8 atouts, sinon il passe. Il ne surenchérit jamais.
- **R14 — Jeu d'un bot.** Un bot joue une carte légale au hasard, et écarte au
  hasard parmi les cartes autorisées.

Exemples :
- R3 : Est dit prise, je dis garde ; Ouest ne peut plus que dire garde sans ou
  passer.
- R7 : le 15 d'atout est sur la table, j'ai le 12 et le 18 ; je dois jouer le 18.
- R9 et R10 : garde, 49 points avec 2 bouts ; le contrat passe de 8, soit
  (25 + 8) × 2 = 66 ; le preneur marque +198, chaque défenseur −66.
- R11 : garde sans passée de 4, petit mené au bout par la défense ;
  (25 + 4) × 4 − 40 = 76.
- R12 : avec 2 bouts, 40,5 points chutent de 1 ; 41,5 points passent de 1.

## Hors-scope
- Garde contre, poignées, chelem : écartés au cadrage du projet.
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
_(rempli en phase 4)_
