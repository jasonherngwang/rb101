# Twenty-One Game

## Understand the Problem
---

### Rules of Twenty-One

**Win Conditions**

"Bust" means that the hand value exceeds 21.

1. Opponent busts, OR
2. If nobody busts, have a higher hand value than your opponent.

**Setup**

Standard card deck has 52 cards: 4 suits with 13 ranks each. Ace can have value 1 or 11.
1. Deck is shuffled.
2. Player and dealer are each dealt 2 cards.

**Gameplay**

*Player takes a turn.*

1. Player chooses to hit or stay.
2. *Hit:* Player draws a card. If bust, player's turn ends. If not, go to step 1.
3. *Stay:* Player's turn ends.

*If player busts, or player's hand has lower value than dealer's hand, game ends.*

*Dealer takes a turn*

1. If dealer's hand value is >= 17, dealer chooses to stay.
2. Otherwise, dealer draws a card. If bust, dealer's turn ends. If not, dealer repeats this step.

**Game End**

- Examine bust status and hand values to evaluate endgame condition.
- Player may decide whether to play another round.

### Explicit Requirements

- 

### Implicit Requirements

- 

### Questions

- How do we properly calculate the value of an Ace?

## Examples and Test Cases
---

**1. Player should hit**

- Dealer: Ace and 1 unknown card
- Player: 2 and 8

**2. Player should stay**

- Dealer: 7 and 1 unknown card
- Player: 10 and 7

**3. Player should stay**

- Dealer: 5 and 1 unknown card
- Player: Jack and 6


## Data Structure
---

### Storing the Deck

Deck has 52 unique cards with unique names but non-unique values.
- Set up a 52-element nested array in the form [[suit, card_name],...]
  - suit: (H)eart, (D)iamond, (C)lub, (S)pade
  - card_name: 2, 3, 4, 5, 6, 7, 8, 9, 10, (J)ack, (Q)ueen, (K)ing, (A)ce
    - Represent as strings, not a mix of integers and strings.
- Set up a hash to lookup the numeric value of each card.
  - Should ace be 1 or 11? Can use 1 as a placeholder.

### Storing Hands of Cards

Use a nested array similar to the deck, so cards can be easily added.

### Storing Hand Values

Use a hash in the main loop to cache hand values, to reduce computation.


## Algorithm
---

### High-Level Pseudocode

1. Initialize deck.
2. Deal cards to player and dealer.
3. Player turn: hit or stay.
  - Repeat until bust or "stay"
4. If player bust, dealer wins.
5. Dealer turn: hit or stay.
  - Repeat until total >= 17.
6. If dealer bust, player wins.
7. Compare cards and declare winner

### Calculating Aces

- Sum all card values, assuming Aces are equal 1.
- If sum <= 10:
  - Add 10 to the sum. This effectively sets one Ace to 11.
  - There cannot be multiple Aces with value 11 because that would exceed 21.

### Player Turn

Set up a loop to query user for valid input. Ask player to hot or stay.
  - If hit:
    - Deal new card.
    - Update hand values cache.
    - If not bust, ask player for input again.
  - If stay, break loop.

### Dealer Turn

Create a conditional statement:
- If player is not bust, and player is winning, dealer takes a turn.

Set up a loop:
  - If hand value >= 17, dealer choose to stay. Break loop.
  - Else:
    - Deal new card.
    - Update hand values cache.
    - If not bust, restart this loop.

### Endgame Processes

1. Print game result and winner/tie.
2. Ask player if they want to play again.