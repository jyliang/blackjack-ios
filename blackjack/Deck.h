//
//  Deck.h
//  blackjack
//
//  Created by Jason Liang on 1/25/14.
//  Copyright (c) 2014 jasonliang. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Card;

@interface Deck : NSObject

- (void)createNewDeck;
- (Card *)dealNextCard;

@end
