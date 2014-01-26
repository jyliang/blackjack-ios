//
//  Hand.m
//  blackjack
//
//  Created by Jason Liang on 1/25/14.
//  Copyright (c) 2014 jasonliang. All rights reserved.
//

#import "BlackJackHand.h"
#import "Card.h"

@interface BlackJackHand ()


@end

@implementation BlackJackHand

- (id)init
{
    self = [super init];
    if (self) {
        self.cards = [NSMutableArray array];
    }
    return self;
}

- (void)addCard:(Card *)card {
    [self.cards addObject:card];
}


- (NSArray *)currentHandScores {
    NSMutableArray *scores = [NSMutableArray array];
    BOOL aceCardFound = NO;
    NSInteger score = 0;
    for (Card *card in self.cards) {
        if ([card isAce]) {
            aceCardFound = YES;
        }
        score += [card cardBaseValue];
    }
    [scores addObject:[NSNumber numberWithInt:score]];
    if (aceCardFound) {
        if (score + 10 <= 21) {
            [scores addObject:[NSNumber numberWithInt:score+10]];
        }
    }
    return scores;
}

- (BOOL)is21 {
    NSArray *currentHandScores = [self currentHandScores];
    BOOL is21 = NO;
    for (NSNumber *score in currentHandScores) {
        if (score.integerValue == 21) {
            is21 = YES;
            break;
        }
    }
    return is21;
}

- (BOOL)isBlackJack {
    if (self.cards.count != 2) {
        return NO;
    }
    BOOL aceCardFound = NO;
    BOOL value10CardFound = NO;
    for (Card *card in self.cards) {
        if ([card isAce]) {
            aceCardFound = YES;
        } else if ([card cardBaseValue] == 10) {
            value10CardFound = YES;
        }
    }
    return aceCardFound && value10CardFound;
    
}

- (BOOL)isBusted {
    NSArray *currentHandScores = [self currentHandScores];
    BOOL isBusted = NO;
    if (currentHandScores.count == 1) {
        if (((NSNumber *)[currentHandScores firstObject]).integerValue > 21) {
            isBusted = YES;
        }
    }
    return isBusted;
}

- (ResultEvaluation)evaluteAgainstHand:(BlackJackHand *)dealerHand {
    ResultEvaluation result;
    if ([self isBlackJack]) {
        if ([dealerHand isBlackJack]) {
            result = kResultTie;
        } else {
            result = kResultWinBlackJack;
        }
    } else if ([dealerHand isBlackJack]) {
        result = kResultLose;
    } else if ([self isBusted]) {
        result = kResultLose;
    } else if ([dealerHand isBusted]) {
        result = kResultWin;
    } else {
        NSInteger dealerScore = [[[dealerHand currentHandScores] lastObject] integerValue];
        NSInteger playerScore = [[[self currentHandScores] lastObject] integerValue];
        if (dealerScore > playerScore) {
            result = kResultLose;
        } else if (dealerScore == playerScore) {
            result = kResultTie;
        } else {
            result = kResultWin;
        }
    }
    return result;
}

@end
