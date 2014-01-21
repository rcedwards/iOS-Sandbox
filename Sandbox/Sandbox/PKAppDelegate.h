//
//  PKAppDelegate.h
//  Sandbox
//
//  Created by Robert Edwards on 12/9/13.
//  Copyright (c) 2013 Panko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PKAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (copy, nonatomic) void(^backgroundSessionCompletionHandler)();

@end
