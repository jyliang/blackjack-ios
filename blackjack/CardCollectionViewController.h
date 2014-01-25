//
//  CardCollectionViewController.h
//  blackjack
//
//  Created by Jason Liang on 1/25/14.
//  Copyright (c) 2014 jasonliang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Hand.h"



@interface CardCollectionViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) Hand *currentHand;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

- (void)addCard:(Card *)card;

@end
