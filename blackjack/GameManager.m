//
//  CurrentGame.m
//  blackjack
//
//  Created by Jason Liang on 1/25/14.
//  Copyright (c) 2014 jasonliang. All rights reserved.
//

#import "GameManager.h"
#import "Deck.h"

@interface GameManager ()

@property (strong, nonatomic) Deck *deck;
@property (nonatomic) ResultEvaluation result;

@end

@implementation GameManager


- (id)init {
    self = [super init];
    if (self) {
        self.gameStage = kStageBegin;
        
        self.deck = [[Deck alloc] init];
        [self.deck createNewDeck];
        
        self.dealerHand = [[BlackJackHand alloc] init];
        
        [self initPlayer];
    }
    return self;
}

- (void)initPlayer {
    //possiblity of loadering other players
    self.currentPlayer = [[Player alloc] init];
}

#pragma mark - Public Methods
- (void)clearCards {
    [self.dealderCardDealDelegate clearCards];
    [self.playerCardDealDelegate clearCards];
    [self.currentPlayer clearCards];
    [self.dealerHand.cards removeAllObjects];
}

- (void)dealCardToDealer {
    Card *card = [self.deck dealNextCard];
    [self.dealderCardDealDelegate addCard:card];
    [self.dealerHand addCard:card];
}

- (void)dealCardToPlayer {
    Card *card = [self.deck dealNextCard];
    [self.playerCardDealDelegate addCard:card];
    [self.currentPlayer addCard:card];
}

- (void)dealInitialCards {
    [self clearCards];
    [self dealCardToPlayer];
    [self dealCardToDealer];
    [self dealCardToPlayer];
    [self dealCardToDealer];
    [self updateStageStatus:kStagePlayerTurn];
    if ([self shouldEndPlayerTurn]) {
        [self playerTurnComplete];
    }
}

- (void)playerDoubleDown {
    if ([self playerCanDoubleDown]) {
        [self dealCardToPlayer];
        [self playerTurnComplete];
    }
}

- (void)playerHit {
    [self dealCardToPlayer];
    if ([self shouldEndPlayerTurn]) {
        [self playerTurnComplete];
    }
}

- (void)playerStand {
    [self playerTurnComplete];
}

- (void)playerSurrender {
    [Utility showAlertWithMessage:@"not yet"];
}

- (BOOL)playerCanDoubleDown {
    if ([self playerCanHit] && [self.currentPlayer canAffordAmount:self.currentPlayer.currentBetOnTable]) {
        return YES;
    }
    return NO;
}

- (BOOL)playerCanHit {
    return self.gameStage == kStagePlayerTurn;
}

- (BOOL)playerCanStand {
    return self.gameStage == kStagePlayerTurn;
}

- (BOOL)playerCanDeal {
    return self.gameStage == kStageBegin || self.gameStage == kStageEnd;
}

- (BOOL)playerCanSurrender {
    return self.gameStage == kStagePlayerTurn && self.currentPlayer.currentHand.cards.count == 2;
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
    shouldEndTurn |= [self.dealerHand isBlackJack];
    shouldEndTurn |= [self.dealerHand is21];
    shouldEndTurn |= [self.dealerHand isBusted];
    shouldEndTurn |= [[[self.dealerHand currentHandScores] firstObject] integerValue] >= 17; //TODO: dealer stand limit
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
    [self updateStageStatus:kStageDealerTurn];
    [self startDealerAutoDeal];
}

- (void)startDealerAutoDeal {
    if (![self shouldEndDealerturn]) {
        [self dealCardToDealer];
        [self performSelector:@selector(startDealerAutoDeal) withObject:nil afterDelay:0.25f];
        return;
    }
    
    [self dealerTurnComplete];
}

- (void)dealerTurnComplete {

    //evaluate and pay out
    self.result = [self.currentPlayer.currentHand evaluteAgainstHand:self.dealerHand];
    [self updateStageStatus:kStageEnd];
//    NSString *resultString = [NSString stringWithFormat:@" result is %d", result];
//    [Utility showAlertWithMessage:resultString];
}

- (void)updateStageStatus:(GameStage)stage {
    self.gameStage = stage;
    switch (stage) {
        case kStageBegin:
            self.gameStatusString = @"Press 'Deal' to start the game";
            break;
            
        case kStagePlayerTurn: {
            NSArray *scores = [self.currentPlayer.currentHand currentHandScores];
            if (scores.count == 2) {
                self.gameStatusString = [NSString stringWithFormat:@"%@/%@", [scores firstObject],[scores lastObject]];
            } else {
                self.gameStatusString = [NSString stringWithFormat:@"%@", [scores firstObject]];
            }
            break;
        }
        case kStageDealerTurn:
            break;
        case kStageEnd:
            break;
        default:
            break;
    }
    
    if (stage == kStageEnd) {
        switch (self.result) {
            case kResultWinBlackJack:
                self.gameStatusString = @"BlackJack Hand Win";
                break;
            case kResultWin:
                self.gameStatusString = @"You win!";
                break;
            case kResultLose:
                self.gameStatusString = @"Dealer win.";
                break;
            case kResultTie:
                self.gameStatusString = @"Push";
                break;
            default:
                break;
        }
    }
    [self.delegate updateStatus];
}

- (void)gameComplete {
    [self clearCards];
}


@end
