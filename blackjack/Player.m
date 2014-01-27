//
//  Player.m
//  blackjack
//
//  Created by Jason Liang on 1/25/14.
//  Copyright (c) 2014 jasonliang. All rights reserved.
//

#import "Player.h"
#import "UserDefaultManager.h"

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
        [self.currentHand setShouldShowLastCard:YES];
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

- (BOOL)depositePayout:(CGFloat)money {
    self.balance += money;
    return YES;
}

- (BOOL)depositeMoneyFromTable:(CGFloat)money {
    self.currentBetOnTable -= money;
    self.balance += money;
    return YES;
}

- (BOOL)betMoney:(CGFloat)money {
    CGFloat adjustedMoney = money;
    if (self.balance == 0) {
        return NO;
    } else if (self.balance < money) {
        adjustedMoney = self.balance;
    }
    NSInteger maxBet = [[UserDefaultManager sharedInstance] maxBet];
    if (self.currentBetOnTable + adjustedMoney > maxBet) {
        adjustedMoney = maxBet - self.currentBetOnTable;
    }
    
    self.currentBetOnTable += adjustedMoney;
    self.balance -= adjustedMoney;
    return YES;
}

- (void)collectBet {
    self.balance += self.currentBetOnTable;
    self.currentBetOnTable = 0;

}

@end
