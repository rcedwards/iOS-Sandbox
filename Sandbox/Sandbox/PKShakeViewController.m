//
//  PKShakeViewController.m
//  Sandbox
//
//  Created by Robert Edwards on 1/15/14.
//  Copyright (c) 2014 Panko. All rights reserved.
//

#import "PKShakeViewController.h"

@interface PKShakeViewController ()

@end

@implementation PKShakeViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self becomeFirstResponder];
}

#pragma mark - Motion Events

- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    UIAlertView *alertView = nil;
	switch (motion) {
		case UIEventSubtypeMotionShake:
            alertView = [[UIAlertView alloc] initWithTitle:nil
                                                   message:NSLocalizedString(@"PKShakeLogMessage",
                                                                             @"Subsitute your localized version of a shake pun here")
                                                  delegate:nil
                                         cancelButtonTitle:@"Word"
                                         otherButtonTitles:nil, nil];
            [alertView show];
			break;
		default:
			break;
	}
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
	NSLog(@"Motion Event Ended: %@", event);
}

- (void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event {
	NSLog(@"Motion Event Cancelled: %@", event);
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

@end
