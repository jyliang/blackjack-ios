//
//  CardDealDelegate.h
//  blackjack
//
//  Created by Jason Liang on 1/25/14.
//  Copyright (c) 2014 jasonliang. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CardDealDelegate <NSObject>

- (void)addCard:(Card *)card;
- (void)clearCards;

- (void)updateShouldShowLastCard:(BOOL)shouldShow;

@optional
- (void)removeCard:(Card *)card; //might be used for split hand

@end
