# Glossaire

Le code est en anglais (ADR-0004). Ce glossaire fixe la traduction de chaque
terme du métier ; un terme absent s'y ajoute avant d'entrer dans le code.

Source : pagat.com, « French Tarot », sauf mention « choisi ».

| Français | Code | Source |
| --- | --- | --- |
| donne | `Deal` | pagat |
| donneur | dealer | pagat |
| paquet | deck | pagat |
| carte | `Card` | pagat |
| main | `Hand` | pagat |
| chien | `Kitty` | pagat |
| siège | `Seat` | choisi |
| Sud, Est, Nord, Ouest | `South`, `East`, `North`, `West` | choisi |
| couleur | `Suit` | pagat |
| pique, cœur, carreau, trèfle | `Spades`, `Hearts`, `Diamonds`, `Clubs` | pagat |
| roi, dame, cavalier, valet | `King`, `Queen`, `Knight`, `Jack` | pagat |
| atout | `Trump` | pagat |
| excuse | `Excuse` | pagat |
| petit | `Petit` | pagat |
| bout | `Oudler` | pagat |
| annonce | `Bid` | pagat |
| contrat | `Contract` | choisi |
| prise, garde, garde sans | `Take`, `Guard`, `GuardWithout` | pagat |
| preneur | taker | pagat |
| défense | defence | choisi |
| camp | `Side` | pagat |
| écart | `Discard` | pagat |
| pli | `Trick` | pagat |
| marque | `Score` | pagat |
| chelem | slam | pagat |
| petit au bout | petit au bout | pagat |
| phases de la donne | `DealInBidding`, `DealInDiscard`, `DealInPlay` | choisi |
| vue du siège (ce qu'un siège connaît de la donne) | `Observation` | choisi |
| vue debug | `DebugObservation` | choisi |
| positions du chien | kitty positions (intervalles entre paquets) | choisi |
| mélange du paquet et positions du chien | `Shuffler` | choisi |
| hasard fourni par la crate `rand` | `RandChance` | choisi |
| tirage du premier donneur | `DealerDraw` | choisi |
