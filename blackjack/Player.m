//
//  Player.m
//  blackjack
//
//  Created by Jason Liang on 1/25/14.
//  Copyright (c) 2014 jasonliang. All rights reserved.
//

#import "Player.h"

#define DEFAULT_BALANCE 500

@interface Player ()

@property (nonatomic) CGFloat balance;

@end

@implementation Player

- (id)init {
    self = [super init];
    if (self) {
        self.currentHand = [[BlackJackHand alloc] init];
        self.currentBetOnTable = 0;
        self.balance = DEFAULT_BALANCE;
    }
    return self;
}

- (void)addCard:(Card *)card {
    [self.currentHand addCard:card];
}

- (void)clearCards {
    [self.currentHand.cards removeAllObjects];
}

- (CGFloat)getBankBalance {
    return self.balance;
}

- (BOOL)canAffordAmount:(CGFloat)amount {
    return self.balance > amount;
}

- (BOOL)depositeMoney:(CGFloat)money {
    self.currentBetOnTable -= money;
    self.balance += money;
    return YES;
}

- (BOOL)betMoney:(CGFloat)money {
    if (self.balance < money) {
        return NO;
    }
    self.currentBetOnTable += money;
    self.balance -= money;
    return YES;
}

@end
