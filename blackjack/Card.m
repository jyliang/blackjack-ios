//
//  Card.m
//  blackjack
//
//  Created by Jason Liang on 1/25/14.
//  Copyright (c) 2014 jasonliang. All rights reserved.
//

#import "Card.h"

@implementation Card

- (instancetype)initWithSuit:(CardSuit)suit andRank:(CardRank)rank {
    self = [super init];
    if (self) {
        self.suit = suit;
        self.rank = rank;
    }
    return self;
}

- (BOOL)isAce {
    return self.rank == kRank1;
}

- (NSInteger)cardBaseValue {
    if (self.rank > kRank10) {
        return 10;
    } else {
        return self.rank + 1;
    }
}

- (NSInteger)cardHighestValue {
    if ([self isAce]) {
        return 11;
    } else {
        return [self cardBaseValue];
    }
}

@end
