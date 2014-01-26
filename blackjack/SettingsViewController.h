//
//  SettingsViewController.h
//  blackjack
//
//  Created by Jason Liang on 1/25/14.
//  Copyright (c) 2014 jasonliang. All rights reserved.
//

#import "BaseViewController.h"

@interface SettingsViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UILabel *minBetLabel;
@property (weak, nonatomic) IBOutlet UISlider *minBetSlider;
@property (weak, nonatomic) IBOutlet UILabel *maxBetLabel;
@property (weak, nonatomic) IBOutlet UISlider *maxBetSlider;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;


@end
