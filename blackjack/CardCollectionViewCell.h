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
@property (strong, nonatomic) Card *card;
@property (nonatomic) BOOL shouldShowCard;

@end
