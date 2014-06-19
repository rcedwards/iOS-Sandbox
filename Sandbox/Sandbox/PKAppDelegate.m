//
//  PKAppDelegate.m
//  Sandbox
//
//  Created by Robert Edwards on 12/9/13.
//  Copyright (c) 2013 Panko. All rights reserved.
//

#import "PKAppDelegate.h"

#import "PKAssosicatedObjectHelperTableViewController.h"
#import "PKSelectionViewController.h"
#import "PKDetailViewController.h"

@interface PKAppDelegate()

@end

@implementation PKAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	[self setUpUIStack];
		
    return YES;
}

- (void)setUpUIStack {
	self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    PKSelectionViewController *selectionViewController = [[PKSelectionViewController alloc] init];
    UINavigationController *selectionNavContainer = [[UINavigationController alloc] initWithRootViewController:selectionViewController];
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        PKDetailViewController *detailVC = [[PKDetailViewController alloc] init];
        selectionViewController.detailViewController = detailVC;
        
        UISplitViewController *splitVC = [[UISplitViewController alloc] init];
        splitVC.delegate = detailVC;
        
        UINavigationController *detailNavContainer = [[UINavigationController alloc] initWithRootViewController:detailVC];
        splitVC.viewControllers = @[selectionNavContainer, detailNavContainer];
        self.window.rootViewController = splitVC;
    } else {
        self.window.rootViewController = selectionNavContainer;
    }
    
	self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
}

- (void)application:(UIApplication *)application handleEventsForBackgroundURLSession:(NSString *)identifier completionHandler:(void (^)())completionHandler {
	/* Apple Sample Code */
	self.backgroundSessionCompletionHandler = completionHandler;
}

@end
