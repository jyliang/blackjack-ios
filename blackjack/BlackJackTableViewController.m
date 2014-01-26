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
#import "UIButton+Style.h"
#import "UserDefaultManager.h"

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
    [self updateBetButtons];
    [self updateButtonStyles];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self updateBetButtons];
}

- (void)updateButtonStyles {
    NSArray *buttons = @[self.dealButton, self.doubleDownButton, self.hitButton, self.standButton, self.clearBetButton, self.wagerIncreaseButton1, self.wagerIncreaseButton2, self.wagerIncreaseButton3];
    for (UIButton *button in buttons) {
        [button applyBlackButtonStyle];
    }
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
    [self.gameManager resetBet];
    
}

- (IBAction)increaseBetButtonTapped:(id)sender {
    NSInteger betIncreaseValue = 0;
    NSArray *values = [self.gameManager getBetIncreaseValues];
    if (sender == self.wagerIncreaseButton1) {
        betIncreaseValue = [[values objectAtIndex:0] integerValue];
    } else if (sender == self.wagerIncreaseButton2) {
        betIncreaseValue = [[values objectAtIndex:1] integerValue];
    } else if (sender == self.wagerIncreaseButton3) {
        betIncreaseValue = [[values objectAtIndex:2] integerValue];
    }
    [self.gameManager increaseBet:betIncreaseValue];
    
}

#pragma mark - GameManagerDelegate

- (void)updateStatus {
    self.dealButton.hidden = ![self.gameManager playerCanDeal];
    self.doubleDownButton.hidden = ![self.gameManager playerCanDoubleDown];
    self.hitButton.hidden = ![self.gameManager playerCanHit];
    self.standButton.hidden = ![self.gameManager playerCanStand];
    
    self.bankBalanceLabel.text = [NSString stringWithFormat:@"$ %.02f", [self.gameManager.currentPlayer getBankBalance]];
    NSString *betBalance = [NSString stringWithFormat:@"$ %.02f", [self.gameManager.currentPlayer currentBetOnTable]];
    self.betAmountLabel.text = betBalance;
    self.gamePlayStatusLabel.text = self.gameManager.gameStatusString;
    self.wagerIncreaseButton1.hidden = self.wagerIncreaseButton2.hidden = self.wagerIncreaseButton3.hidden = self.clearBetButton.hidden =  ![self.gameManager playerCanAdjustBet];
}

- (void)updateBetButtons {
    NSArray *values = [self.gameManager getBetIncreaseValues];
    NSArray *buttons = @[self.wagerIncreaseButton1, self.wagerIncreaseButton2, self.wagerIncreaseButton3];
    for (int i = 0; i < values.count; i++) {
        NSString *buttonString = [NSString stringWithFormat:@"+$%@", [values objectAtIndex:i]];
        [[buttons objectAtIndex:i] setTitle:buttonString forState:UIControlStateNormal];
    }
}


@end
