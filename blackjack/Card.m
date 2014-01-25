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

@end
