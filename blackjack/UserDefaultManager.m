//
//  UserDefaultManager.m
//  blackjack
//
//  Created by Jason Liang on 1/25/14.
//  Copyright (c) 2014 jasonliang. All rights reserved.
//

#import "UserDefaultManager.h"

#define kUDUserID @"kUDUserID"
#define kUDFirstUse @"kUDFirstUse"

static UserDefaultManager *instance;

@implementation UserDefaultManager

+ (UserDefaultManager *)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[UserDefaultManager alloc] init];
    });
    return instance;
}

- (id)init
{
    self = [super init];
    if (self) {
        [self initDefault];
    }
    return self;
}

- (void)initDefault {
    _userDefault = [NSUserDefaults standardUserDefaults];
    
    BOOL needSync = NO;
    if (![_userDefault objectForKey:kUDUserID]) {
        [_userDefault setObject:[UserDefaultManager uuid] forKey:kUDUserID];
        needSync = YES;
    }
    
    if (![_userDefault objectForKey:kUDFirstUse]) {
        [_userDefault setObject:[NSNumber numberWithBool:YES] forKey:kUDFirstUse];
        needSync = YES;
    }
    
    if (needSync) {
        [_userDefault synchronize];
    }
}

- (NSString *)userID {
    return [_userDefault objectForKey:kUDUserID];
}

- (BOOL)isFirstUse {
    return [[_userDefault objectForKey:kUDFirstUse] boolValue];
}

- (void)completeFirstUse {
    [_userDefault setObject:[NSNumber numberWithBool:NO] forKey:kUDFirstUse];
    [_userDefault synchronize];
}


+ (NSString *)uuid
{
    CFUUIDRef uuidRef = CFUUIDCreate(NULL);
    CFStringRef uuidStringRef = CFUUIDCreateString(NULL, uuidRef);
    CFRelease(uuidRef);
    return (__bridge NSString *)uuidStringRef;
}

@end
