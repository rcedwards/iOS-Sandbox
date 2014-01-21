//
//  PKAppDelegate.m
//  Sandbox
//
//  Created by Robert Edwards on 12/9/13.
//  Copyright (c) 2013 Panko. All rights reserved.
//

#import "PKAppDelegate.h"

#import "PKUITableViewController.h"
#import "PKSelectionViewController.h"

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
        UISplitViewController *splitVC = [[UISplitViewController alloc] init];
        splitVC.viewControllers = @[selectionNavContainer, [[UIViewController alloc] init]];
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
