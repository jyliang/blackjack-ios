//
//  Deck.m
//  blackjack
//
//  Created by Jason Liang on 1/25/14.
//  Copyright (c) 2014 jasonliang. All rights reserved.
//

#import "Deck.h"
#import "Card.h"
#include <stdlib.h>

#define DECK_COUNT 8

@interface Deck()

@property (strong, nonatomic) NSMutableArray *cards;
@property (nonatomic) NSInteger shuffleLimit;

@end

@implementation Deck

- (void)createNewDeck {
    self.cards = [NSMutableArray array];
    
    for (int deck = 0; deck < DECK_COUNT; deck++) {
        [self.cards addObjectsFromArray:[self getFreshDeckOfCards]];
    }
    self.cards = [self shuffleCards:self.cards];
    
}

- (NSArray *)getFreshDeckOfCards {
    NSMutableArray *cards = [NSMutableArray array];
    Card *card;
    for (int suit = 0; suit < kSuitCount; suit++) {
        for (int rank = 0; rank < kRankCount; rank++) {
            card = [[Card alloc] initWithSuit:suit andRank:rank];
            [cards addObject:card];
        }
    }
    return cards;
}

- (NSMutableArray *)shuffleCards:(NSMutableArray *)cards {
    NSMutableArray *shuffledCards = [NSMutableArray arrayWithCapacity:cards.count];
    NSMutableArray *cardCopy = [NSMutableArray arrayWithArray:cards];
    
    for (int i = cards.count; i > 1; i--) {
        int randomIndex = arc4random() % i;
        Card *card = [cardCopy objectAtIndex:randomIndex];
        [cardCopy removeObjectAtIndex:randomIndex];
        [shuffledCards addObject:card];
    }
    if (cardCopy.count == 1) {
        [shuffledCards addObject:[cardCopy firstObject]];
    }
    
    return shuffledCards;
}

- (Card *)dealNextCard {
    if (self.cards.count == 0) {
        return nil;
    }
    Card *card = [self.cards lastObject];
    [self.cards removeLastObject];
    return card;
}

@end
