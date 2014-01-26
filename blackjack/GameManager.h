//
//  CurrentGame.h
//  blackjack
//
//  Created by Jason Liang on 1/25/14.
//  Copyright (c) 2014 jasonliang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BlackJackHand.h"
#import "Player.h"
#import "CardDealDelegate.h"

typedef enum {
    kStageBegin,
    kStageDealing,
    kStagePlayerTurn,
    kStageDealerTurn,
    kStageEnd
} GameStage;

@protocol GameManagerDelegate <NSObject>

- (void)updateStatus;

@end

@interface GameManager : NSObject

@property (weak, nonatomic) id<CardDealDelegate> dealderCardDealDelegate;
@property (weak, nonatomic) id<CardDealDelegate> playerCardDealDelegate;

@property (weak, nonatomic) id<GameManagerDelegate> delegate;

@property (nonatomic) GameStage gameStage;
@property (strong, nonatomic) BlackJackHand *dealerHand;
@property (strong, nonatomic) Player *currentPlayer;

@property (strong, nonatomic) NSString *gameStatusString;

- (void)dealInitialCards;
//- (void)clearCards;
- (void)dealCardToDealer;
- (void)dealCardToPlayer;

- (void)playerDoubleDown;
- (void)playerHit;
- (void)playerStand;
- (void)playerSurrender;

- (void)increaseBet:(NSInteger)betAmount;
- (void)resetBet;

- (BOOL)playerCanAdjustBet;
- (BOOL)playerCanDoubleDown;
- (BOOL)playerCanHit;
- (BOOL)playerCanStand;
- (BOOL)playerCanDeal;
- (BOOL)playerCanSurrender; //TODO: not linked;

- (NSArray *)getBetIncreaseValues;



@end
