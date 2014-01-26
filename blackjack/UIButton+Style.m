//
//  UIButton+Style.m
//  blackjack
//
//  Created by Jason Liang on 1/26/14.
//  Copyright (c) 2014 jasonliang. All rights reserved.
//

#import "UIButton+Style.h"

@implementation UIButton (Style)

- (void)applyBlackButtonStyle {
    UIButton *button = self;
    UIImage *buttonImage = [[UIImage imageNamed:@"blackButton.png"]
                            resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
    UIImage *buttonImageHighlight = [[UIImage imageNamed:@"blackButtonHighlight.png"]
                                     resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
    [button setBackgroundImage:buttonImage forState:UIControlStateNormal]
    ;
    [button setBackgroundImage:buttonImageHighlight forState:UIControlStateHighlighted];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

@end
