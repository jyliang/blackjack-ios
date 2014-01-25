//
//  BlackJackTableViewController.m
//  blackjack
//
//  Created by Jason Liang on 1/25/14.
//  Copyright (c) 2014 jasonliang. All rights reserved.
//

#import "BlackJackTableViewController.h"
#import "SettingsViewController.h"
#import "AboutViewController.h"

@interface BlackJackTableViewController ()

@end

@implementation BlackJackTableViewController

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (IBAction)aboutButtonTapped {
    AboutViewController *settingsVC = [[UIStoryboard storyboardWithName:@"AboutStoryboard" bundle:[NSBundle mainBundle]] instantiateInitialViewController];
    [self presentViewController:settingsVC animated:YES completion:nil];
}
- (IBAction)settingsButtonTapped {
    SettingsViewController *settingsVC = [[UIStoryboard storyboardWithName:@"SettingsStoryboard" bundle:[NSBundle mainBundle]] instantiateInitialViewController];
    
    [self presentViewController:settingsVC animated:YES completion:nil];
}

@end
