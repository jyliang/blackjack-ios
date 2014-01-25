//
//  Hand.m
//  blackjack
//
//  Created by Jason Liang on 1/25/14.
//  Copyright (c) 2014 jasonliang. All rights reserved.
//

#import "Hand.h"
#import "Card.h"

@interface Hand ()


@end

@implementation Hand

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


- (NSArray *)currentHandValues {
    return nil;
}

@end
