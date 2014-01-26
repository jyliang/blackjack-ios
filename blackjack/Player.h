//
//  Player.h
//  blackjack
//
//  Created by Jason Liang on 1/25/14.
//  Copyright (c) 2014 jasonliang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BlackJackHand.h"

@interface Player : NSObject


@property (nonatomic) CGFloat currentBetOnTable;
@property (strong, nonatomic) BlackJackHand *currentHand;

- (CGFloat)getBankBalance;

- (void)addCard:(Card *)card;
- (void)clearCards;

- (BOOL)canAffordAmount:(CGFloat)amount;
- (BOOL)depositeMoney:(CGFloat)money;
- (BOOL)betMoney:(CGFloat)money;

@end
