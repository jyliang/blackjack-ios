//
//  BlackJackTableViewController.m
//  blackjack
//
//  Created by Jason Liang on 1/25/14.
//  Copyright (c) 2014 jasonliang. All rights reserved.
//

#import "BlackJackTableViewController.h"
#import "SettingsViewController.h"
#import "AboutViewController.h"
#import "CardCollectionViewController.h"

#import "Deck.h"
#import "Player.h"

@interface BlackJackTableViewController ()

@property (strong, nonatomic) Deck *deck;

@property (weak, nonatomic) CardCollectionViewController *dealerHandVC;
@property (weak, nonatomic) CardCollectionViewController *playerHandVC;
@property (weak, nonatomic) IBOutlet UILabel *bankBalanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *betAmountLabel;
@property (strong, nonatomic) Player *currentPlayer;

@end

@implementation BlackJackTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.deck = [[Deck alloc] init];
    [self.deck createNewDeck];
    
    self.currentPlayer = [[Player alloc] init];
}

#pragma mark - Actions

- (IBAction)aboutButtonTapped {
    AboutViewController *settingsVC = [[UIStoryboard storyboardWithName:@"AboutStoryboard" bundle:[NSBundle mainBundle]] instantiateInitialViewController];
    [self presentViewController:settingsVC animated:YES completion:nil];
}
- (IBAction)settingsButtonTapped {
    SettingsViewController *settingsVC = [[UIStoryboard storyboardWithName:@"SettingsStoryboard" bundle:[NSBundle mainBundle]] instantiateInitialViewController];
    
    [self presentViewController:settingsVC animated:YES completion:nil];
}

- (IBAction)dealButtonPressed {
    //TODO: clear hands;

    [self clearCards];
    
    [self dealCardtoPlayer];
    [self dealCardToDealer];
    [self dealCardtoPlayer];
    [self dealCardToDealer];
    
}

- (void)clearCards {
    [self.playerHandVC clearCards];
    [self.dealerHandVC clearCards];
    [self.currentPlayer clearCards];
}

- (void)dealCardToDealer {
    Card *card = [self.deck dealNextCard];
    [self.dealerHandVC addCard:card];
}

- (void)dealCardtoPlayer {
    Card *card = [self.deck dealNextCard];
    [self.playerHandVC addCard:card];
    [self.currentPlayer addCard:card];
}

- (IBAction)doubleDownButtonTapped {
    [self dealCardtoPlayer];
    [self playerTurnComplete];
    
}

- (IBAction)hitButtonTapped {
    [self dealCardtoPlayer];
    if ([self shouldEndPlayerTurn]) {
        [self playerTurnComplete];
    }
}

- (IBAction)standButtonTapped {
    [self playerTurnComplete];
}

- (IBAction)clearBetButtonTapped {
    
}

#pragma mark - Game Play Logic

- (BOOL)shouldEndPlayerTurn {
    BOOL shouldEndTurn = NO;
    shouldEndTurn |= [self.currentPlayer.currentHand isBlackJack];
    shouldEndTurn |= [self.currentPlayer.currentHand isBusted];
    shouldEndTurn |= [self.currentPlayer.currentHand is21];
    return shouldEndTurn;
}

- (BOOL)shouldEndDealerturn {
    if ([self.currentPlayer.currentHand isBusted]) {
        return YES;
    }
    BOOL shouldEndTurn = NO;
    shouldEndTurn |= [self.dealerHandVC.currentHand isBlackJack];
    shouldEndTurn |= [self.dealerHandVC.currentHand is21];
    shouldEndTurn |= [self.dealerHandVC.currentHand isBusted];
    shouldEndTurn |= [[[self.dealerHandVC.currentHand currentHandScores] firstObject] integerValue] >= 17; //TODO: dealer stand limit
    return shouldEndTurn;
}




#pragma mark - Game State

- (void)evaluatePlayerHand:(BlackJackHand *)hand {
    
}

- (void)playerTurnComplete {
//    [Utility showAlertWithMessage:@"player turn finished"];
//    if ([self.currentPlayer.currentHand isBlackJack]) {
//        [Utility showAlertWithMessage:@"player got black jack"];
//    } else if ([self.currentPlayer.currentHand isBusted]) {
//        [Utility showAlertWithMessage:@"busted"];
//    } else if ([self.currentPlayer.currentHand is21]) {
//        [Utility showAlertWithMessage:@"got 21"];
//    }
    
    [self startDealerAutoDeal];
    
}

- (void)startDealerAutoDeal {
    while (![self shouldEndDealerturn]) {
        [self dealCardToDealer];
    }
    
    [self dealerTurnComplete];
}

- (void)dealerTurnComplete {
    //evaluate and pay out
    ResultEvaluation result = [self.currentPlayer.currentHand evaluteAgainstHand:self.dealerHandVC.currentHand];
    NSString *resultString = [NSString stringWithFormat:@" result is %d", result];
    [Utility showAlertWithMessage:resultString];
}

- (void)gameComplete {
    [self clearCards];
}

#pragma mark - segue prep

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"dealerHand"]) {
        self.dealerHandVC = segue.destinationViewController;
    } else if ([segue.identifier isEqualToString:@"playerHand"]) {
        self.playerHandVC = segue.destinationViewController;
    }
}

@end
