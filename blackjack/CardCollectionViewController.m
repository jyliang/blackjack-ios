//
//  CardCollectionViewController.m
//  blackjack
//
//  Created by Jason Liang on 1/25/14.
//  Copyright (c) 2014 jasonliang. All rights reserved.
//

#import "CardCollectionViewController.h"
#import "CardCollectionViewCell.h"
#import "Card.h"

@interface CardCollectionViewController ()

@end

@implementation CardCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"CardCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:NSStringFromClass([CardCollectionViewCell class])];
    
    
    self.currentHand = [[BlackJackHand alloc] init];
}

#pragma mark - Collection View Data Source and Delegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger) section {
    return self.currentHand.cards.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CardCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([CardCollectionViewCell class]) forIndexPath:indexPath];
    Card *card = [self.currentHand.cards objectAtIndex:indexPath.item];
    [cell configureWithCard:card];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(40, 62);
}

#pragma mark - 

- (void)addCard:(Card *)card {
    [self.collectionView performBatchUpdates:^{
        [self.currentHand.cards addObject:card];
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:self.currentHand.cards.count -1 inSection:0];

        [self.collectionView insertItemsAtIndexPaths:@[indexPath]];
    } completion:^(BOOL finished) {
        
    }];
}

- (void)clearCards {
    [self.collectionView performBatchUpdates:^{
        [self.currentHand.cards removeAllObjects];
        [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:0]];
    } completion:^(BOOL finished) {
        
    }];
}

@end
