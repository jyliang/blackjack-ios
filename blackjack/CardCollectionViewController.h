//
//  CardCollectionViewController.h
//  blackjack
//
//  Created by Jason Liang on 1/25/14.
//  Copyright (c) 2014 jasonliang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BlackJackHand.h"
#import "CardDealDelegate.h"

@interface CardCollectionViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, CardDealDelegate>

@property (strong, nonatomic) BlackJackHand *currentHand;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end
