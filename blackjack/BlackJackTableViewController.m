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

#import "Deck.h"

@interface BlackJackTableViewController ()

@property (strong, nonatomic) Deck *deck;

@property (weak, nonatomic) CardCollectionViewController *dealerHandVC;
@property (weak, nonatomic) CardCollectionViewController *playerHandVC;

@end

@implementation BlackJackTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.deck = [[Deck alloc] init];
    [self.deck createNewDeck];
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

- (IBAction)dealButtonPressed {
    [self dealCardtoPlayer];
    [self dealCardToDealer];
    [self dealCardtoPlayer];
    [self dealCardToDealer];
    
}

- (void)dealCardToDealer {
    Card *card = [self.deck dealNextCard];
    [self.dealerHandVC addCard:card];
}

- (void)dealCardtoPlayer {
    Card *card = [self.deck dealNextCard];
    [self.playerHandVC addCard:card];
}

#pragma mark - segue prep

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"dealerHand"]) {
        self.dealerHandVC = segue.destinationViewController;
    } else if ([segue.identifier isEqualToString:@"playerHand"]) {
        self.playerHandVC = segue.destinationViewController;
    }
}

@end
