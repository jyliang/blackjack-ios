//
//  UIImage+BlackJackCards.h
//  blackjack
//
//  Created by Jason Liang on 1/25/14.
//  Copyright (c) 2014 jasonliang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Card;

@interface UIImage (BlackJackCards)

+ (UIImage *)imageForCardBack;
+ (UIImage *)imageWithCard:(Card *)card;

@end
