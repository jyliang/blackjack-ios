blackjack-ios
=============

General UX:
Play Screen is presented first. Secondary screens such as settings and about are presented as modals.

General Architecture:

<BlackjackTableViewController.h>
this is the controller class that holds all the card collection VCs and links up the delegate
with the GameManager. The actual game logic is held in GameManager

<GameManager.h>
this class holds all the game state information including:
1. current deck status
2. current player
3. current dealer hand
4. current game play stage

This class was designed to handle all the game logic and should be relatively easy to extend it for game state save/restore.
It contains a game state machine of the current game and determines if the game should proceed to the next stage automatically.
The betting and payout logic is also handled in this class, a better alternative is to handle the logic in a separate class
so that one handles game play and one handles money exchange.


<CardCollectionViewController.h>
This class holds the collection view which displays the cards. It implements the card delegate protocol to update
its hand reference and UI. The use of collection view allows easy expansion to get a different layout of each of the individual cells.
It also allows an easy way to get animation in/out effects as we insert/delete cells from the collectionView.


#expansion:
1. to support card split, the BlackjackTableViewController can contain another CardCollectionViewController for the split hand
2. to support multi player, the GameManager would have an array of players instead of only one reference to the Player class


blackjack game
