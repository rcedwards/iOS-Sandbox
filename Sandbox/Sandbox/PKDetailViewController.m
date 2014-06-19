//
//  PKDetailViewController.m
//  Sandbox
//
//  Created by Robert Edwards on 6/18/14.
//  Copyright (c) 2014 Panko. All rights reserved.
//

#import "PKDetailViewController.h"

@interface PKDetailViewController ()

@property (nonatomic, strong) UIPopoverController *popOverController;

@end

@implementation PKDetailViewController

- (void)displaySampleViewController:(UIViewController *)viewController {
    [self.navigationController popViewControllerAnimated:NO];
    [self.navigationController pushViewController:viewController animated:YES];
    if (self.popOverController) {
        [self.popOverController dismissPopoverAnimated:YES];
    }
}

#pragma mark - UISplitViewControllerDelegate

- (void)splitViewController:(UISplitViewController *)svc willShowViewController:(UIViewController *)aViewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem {
    if ([self.navigationItem.rightBarButtonItem isEqual:barButtonItem]) {
        self.navigationItem.rightBarButtonItem = nil;
    }
    self.popOverController = nil;
}

- (void)splitViewController:(UISplitViewController *)svc willHideViewController:(UIViewController *)aViewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)pc {
    self.popOverController = pc;
    self.navigationItem.rightBarButtonItem = barButtonItem;
    self.navigationItem.rightBarButtonItem.title = @"Example List";
}

@end
