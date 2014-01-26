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

#define kUDMinBet @"kUDMinBet"
#define kUDMaxBet @"kUDMaxBet"

#define DEFAULT_

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
        [_userDefault setObject:[NSNumber numberWithBool:YES] forKey:kUDFirstUse];
        
        NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"configuration" ofType:@"plist"]];
        NSLog(@"dictionary = %@", dictionary);
        NSNumber *defaultMinBet = [dictionary objectForKey:@"defaultMinBet"];
        [_userDefault setObject:defaultMinBet forKey:kUDMinBet];
        NSNumber *defaultMaxBet = [dictionary objectForKey:@"defaultMaxBet"];
        [_userDefault setObject:defaultMaxBet forKey:kUDMaxBet];
        
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

- (NSInteger)minBet {
    return [[_userDefault objectForKey:kUDMinBet] integerValue];
}

- (NSInteger)maxBet {
    return [[_userDefault objectForKey:kUDMaxBet] integerValue];
}

- (void)setMinBet:(NSInteger)amount {
    [_userDefault setObject:[NSNumber numberWithInteger:amount] forKey:kUDMinBet];
}

- (void)setMaxBet:(NSInteger)amount {
    [_userDefault setObject:[NSNumber numberWithInteger:amount] forKey:kUDMaxBet];
}


+ (NSString *)uuid
{
    CFUUIDRef uuidRef = CFUUIDCreate(NULL);
    CFStringRef uuidStringRef = CFUUIDCreateString(NULL, uuidRef);
    CFRelease(uuidRef);
    return (__bridge NSString *)uuidStringRef;
}

@end
