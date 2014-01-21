//
//  PKCardDemoViewController.m
//  Sandbox
//
//  Created by Robert Edwards on 1/16/14.
//  Copyright (c) 2014 Panko. All rights reserved.
//

#import "PKCardDemoViewController.h"

#import "PKCard.h"
#import "PKDeck.h"

@interface PKCardDemoViewController ()

- (IBAction)runCardRoutine:(id)sender;

@end

@implementation PKCardDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)runCardRoutine:(id)sender {
    PKDeck *cardDeck = [[PKDeck alloc] init];
	[cardDeck.cards enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
		NSLog(@"%@ at position: %d", obj, idx);
	}];
}

@end
