//
//  CardCell.h
//  blackjack
//
//  Created by Jason Liang on 1/25/14.
//  Copyright (c) 2014 jasonliang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Card;

@interface CardCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) Card *card;
@property (nonatomic) BOOL shouldShowCard;

- (void)configureWithCard:(Card *)card shouldShowCard:(BOOL)showCard;

@end
