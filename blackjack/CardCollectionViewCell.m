//
//  CardCell.m
//  blackjack
//
//  Created by Jason Liang on 1/25/14.
//  Copyright (c) 2014 jasonliang. All rights reserved.
//

#import "CardCollectionViewCell.h"
#import "Card.h"
#import "UIImage+BlackJackCards.h"

@implementation CardCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)configureWithCard:(Card *)card {
    self.card = card;
    
    self.label.text = [NSString stringWithFormat:@"S%d R%d", card.suit, card.rank];
    
    UIImage *cardImage = [UIImage imageWithCard:card];
    [self.imageView setImage:cardImage];
}

@end
