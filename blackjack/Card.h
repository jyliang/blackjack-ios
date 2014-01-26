//
//  Card.h
//  blackjack
//
//  Created by Jason Liang on 1/25/14.
//  Copyright (c) 2014 jasonliang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    kSuitClub,
    kSuitDiamond,
    kSuitHeart,
    kSuitSpade,
    kSuitCount
} CardSuit;

typedef enum {
    kRank1,
    kRank2,
    kRank3,
    kRank4,
    kRank5,
    kRank6,
    kRank7,
    kRank8,
    kRank9,
    kRank10,
    kRankJack,
    kRankQueen,
    kRankKing,
    kRankCount
} CardRank;

@interface Card : NSObject

- (instancetype)initWithSuit:(CardSuit)suit andRank:(CardRank)rank;

@property (nonatomic) CardSuit suit;
@property (nonatomic) CardRank rank;

- (BOOL)isAce;
- (NSInteger)cardBaseValue;
- (NSInteger)cardHighestValue;

@end
