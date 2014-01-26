//
//  SettingsViewController.m
//  blackjack
//
//  Created by Jason Liang on 1/25/14.
//  Copyright (c) 2014 jasonliang. All rights reserved.
//

#import "SettingsViewController.h"
#import "UIButton+Style.h"
#import "UserDefaultManager.h"

#define MIN_SLIDER_MULTIPLIER 5
#define MAX_SLIDER_MULTIPLIER 10

@interface SettingsViewController ()

@property (nonatomic) NSInteger minBetValue;
@property (nonatomic) NSInteger maxBetValue;

@end

@implementation SettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    UserDefaultManager *mgr = [UserDefaultManager sharedInstance];
    self.minBetValue = mgr.minBet;
    self.maxBetValue = mgr.maxBet;
    
    self.minBetSlider.value = self.minBetValue/MIN_SLIDER_MULTIPLIER;
    self.maxBetSlider.value = self.maxBetValue/MAX_SLIDER_MULTIPLIER/self.minBetSlider.value;

    [self updateValueLabels];
}

- (IBAction)closeButtonTapped {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)saveButtonTapped:(id)sender {
    UserDefaultManager *mgr = [UserDefaultManager sharedInstance];
    [mgr setMaxBet:self.maxBetValue];
    [mgr setMinBet:self.minBetValue];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)minSliderValueChanged:(id)sender {
    float newStep = roundf(self.minBetSlider.value);
    self.minBetSlider.value = newStep;
    
    self.minBetValue = self.minBetSlider.value * MIN_SLIDER_MULTIPLIER;
    self.maxBetValue = self.minBetValue * self.maxBetSlider.value * MAX_SLIDER_MULTIPLIER;
    [self updateValueLabels];
}

- (IBAction)maxSliderValueChanged:(id)sender {
    float newStep = roundf(self.maxBetSlider.value);
    self.maxBetSlider.value = newStep;
    self.maxBetValue = self.minBetValue * self.maxBetSlider.value * MAX_SLIDER_MULTIPLIER;
    [self updateValueLabels];
}

- (void)updateValueLabels {
    self.minBetLabel.text = [NSString stringWithFormat:@"$ %d", self.minBetValue];
    self.maxBetLabel.text = [NSString stringWithFormat:@"$ %d", self.maxBetValue];
}

@end
