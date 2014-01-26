//
//  UserDefaultManager.h
//  blackjack
//
//  Created by Jason Liang on 1/25/14.
//  Copyright (c) 2014 jasonliang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserDefaultManager : NSObject {
    NSUserDefaults *_userDefault;
}

+ (UserDefaultManager *)sharedInstance;

- (NSString *)userID;
- (BOOL)isFirstUse;
- (void)completeFirstUse;

@end
