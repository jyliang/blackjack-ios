//
//  Hand.h
//  blackjack
//
//  Created by Jason Liang on 1/25/14.
//  Copyright (c) 2014 jasonliang. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Card;

@interface Hand : NSObject
@property (strong, nonatomic) NSMutableArray *cards;


- (void)addCard:(Card *)card;

- (NSArray *)currentHandValues;

@end
