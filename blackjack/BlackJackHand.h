//
//  Hand.h
//  blackjack
//
//  Created by Jason Liang on 1/25/14.
//  Copyright (c) 2014 jasonliang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    kResultWinBlackJack,
    kResultWin,
    kResultLose,
    kResultTie
} ResultEvaluation;

@class Card;

@interface BlackJackHand : NSObject
@property (strong, nonatomic) NSMutableArray *cards;
@property (nonatomic) BOOL shouldShowLastCard;


- (NSArray *)currentHandScores;
- (BOOL)is21;
- (BOOL)isBlackJack;
- (BOOL)isBusted;

- (void)addCard:(Card *)card;


- (ResultEvaluation)evaluteAgainstHand:(BlackJackHand *)dealerHand;

@end
