//
//  UIImage+BlackJackCards.m
//  blackjack
//
//  Created by Jason Liang on 1/25/14.
//  Copyright (c) 2014 jasonliang. All rights reserved.
//

#import "UIImage+BlackJackCards.h"
#import "Card.h"

#define CARD_WIDTH 79
#define CARD_HEIGHT 123

@implementation UIImage (BlackJackCards)

+ (UIImage *)imageWithCard:(Card *)card {
    UIImage *baseImage = [UIImage imageNamed:@"cards"];
    CGRect croppingRect = CGRectMake(card.rank*CARD_WIDTH, card.suit*CARD_HEIGHT, CARD_WIDTH, CARD_HEIGHT);
    return [UIImage getCroppedImage:baseImage toRect:croppingRect];
    
}

+ (UIImage *)imageForCardBack {
    UIImage *baseImage = [UIImage imageNamed:@"cards"];
    CGRect croppingRect = CGRectMake(2*CARD_WIDTH, 4*CARD_HEIGHT, CARD_WIDTH, CARD_HEIGHT);
    return [UIImage getCroppedImage:baseImage toRect:croppingRect];
}

+ (UIImage *)getCroppedImage:(UIImage *)sourceImage toRect:(CGRect)rect{
    CGImageRef imageRef = CGImageCreateWithImageInRect([sourceImage CGImage], rect);
    UIImage *image = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    return image;
}

@end
