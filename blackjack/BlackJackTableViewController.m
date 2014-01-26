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
#import "CardCollectionViewController.h"

#import "Player.h"
#import "GameManager.h"
#import "AppDelegate.h"

@interface BlackJackTableViewController () <GameManagerDelegate>

@property (weak, nonatomic) CardCollectionViewController *dealerHandVC;
@property (weak, nonatomic) CardCollectionViewController *playerHandVC;
@property (weak, nonatomic) IBOutlet UILabel *bankBalanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *betAmountLabel;
@property (weak, nonatomic) GameManager *gameManager;

@property (weak, nonatomic) IBOutlet UILabel *gamePlayStatusLabel;

@property (weak, nonatomic) IBOutlet UIButton *dealButton;
@property (weak, nonatomic) IBOutlet UIButton *doubleDownButton;
@property (weak, nonatomic) IBOutlet UIButton *hitButton;
@property (weak, nonatomic) IBOutlet UIButton *standButton;
@property (weak, nonatomic) IBOutlet UIButton *clearBetButton;


@property (weak, nonatomic) IBOutlet UIButton *wagerIncreaseButton1;
@property (weak, nonatomic) IBOutlet UIButton *wagerIncreaseButton2;
@property (weak, nonatomic) IBOutlet UIButton *wagerIncreaseButton3;

@end

@implementation BlackJackTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.gameManager = [appDelegate getGameManager];
    self.gameManager.dealderCardDealDelegate = self.dealerHandVC;
    self.gameManager.playerCardDealDelegate = self.playerHandVC;
    self.gameManager.delegate = self;
    [self updateStatus];
}

#pragma mark - segue prep

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"dealerHand"]) {
        self.dealerHandVC = segue.destinationViewController;
    } else if ([segue.identifier isEqualToString:@"playerHand"]) {
        self.playerHandVC = segue.destinationViewController;
    }
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

- (IBAction)dealButtonPressed {
    [self.gameManager dealInitialCards];
}

- (void)dealCardToDealer {
    [self.gameManager dealCardToDealer];
}

- (void)dealCardtoPlayer {
    [self.gameManager dealCardToPlayer];
}

- (IBAction)doubleDownButtonTapped {
    [self.gameManager playerDoubleDown];
}

- (IBAction)hitButtonTapped {
    [self.gameManager playerHit];
}

- (IBAction)standButtonTapped {
    [self.gameManager playerStand];
}

- (IBAction)clearBetButtonTapped {
    
    
}

#pragma mark - GameManagerDelegate

- (void)updateStatus {
    self.dealButton.hidden = ![self.gameManager playerCanDeal];
    self.doubleDownButton.hidden = ![self.gameManager playerCanDoubleDown];
    self.hitButton.hidden = ![self.gameManager playerCanHit];
    self.standButton.hidden = ![self.gameManager playerCanStand];
    
    self.bankBalanceLabel.text = [NSString stringWithFormat:@"%.02f", [self.gameManager.currentPlayer getBankBalance]];
    NSString *betBalance = [NSString stringWithFormat:@"%.02f", [self.gameManager.currentPlayer currentBetOnTable]];
    [self.clearBetButton setTitle:betBalance forState:UIControlStateNormal];
    self.gamePlayStatusLabel.text = self.gameManager.gameStatusString;
}


@end
