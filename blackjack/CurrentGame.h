//
//  CurrentGame.h
//  blackjack
//
//  Created by Jason Liang on 1/25/14.
//  Copyright (c) 2014 jasonliang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BlackJackHand.h"

typedef enum {
    kStageDealing,
    kStagePlayerTurn,
    kStageDealerTurn,
    kStageEnd
} GameStage;

@interface CurrentGame : NSObject

@property (strong, nonatomic) BlackJackHand *dealerHand;
@property (strong, nonatomic) BlackJackHand *playerHand;

@end
