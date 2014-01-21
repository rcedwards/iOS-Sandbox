//
//  PKGlobalNotificationsViewController.m
//  Sandbox
//
//  Created by Robert Edwards on 1/17/14.
//  Copyright (c) 2014 Panko. All rights reserved.
//

#import "PKGlobalNotificationsViewController.h"

@interface PKGlobalNotificationsViewController ()

@property (strong, nonatomic) id localNotificationObserver;
@property (weak, nonatomic) IBOutlet UISwitch *enableLoggingSwitch;

@end

@implementation PKGlobalNotificationsViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	
	[self.enableLoggingSwitch addTarget:self
								 action:@selector(loggingSwitchToggled:)
					   forControlEvents:UIControlEventValueChanged];
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	
	[self toggleLogging:self.enableLoggingSwitch.isOn];
}

- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
	
	[[NSNotificationCenter defaultCenter] removeObserver:self.localNotificationObserver];
}

#pragma mark - Private

- (void)loggingSwitchToggled:(id)sender {
	if (![sender isEqual:self.enableLoggingSwitch]) {
		return;
	}
	
	[self toggleLogging:self.enableLoggingSwitch.isOn];
}

- (void)toggleLogging:(BOOL)enabled {
	if (enabled) {
		self.localNotificationObserver = [[NSNotificationCenter defaultCenter]
										  addObserverForName:nil object:nil queue:nil
										  usingBlock:^(NSNotification *note) {
											  NSLog(@"%@", note.description);
										  }];
	} else {
		[[NSNotificationCenter defaultCenter] removeObserver:self.localNotificationObserver];
	}
}


@end
