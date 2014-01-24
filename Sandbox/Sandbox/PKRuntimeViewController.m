//
//  PKRuntimeViewController.m
//  Sandbox
//
//  Created by Robert Edwards on 1/23/14.
//  Copyright (c) 2014 Panko. All rights reserved.
//
//	From Matt Gallagher's Cocoa with Love
//	http://www.cocoawithlove.com/2010/01/what-is-meta-class-in-objective-c.html

#import "PKRuntimeViewController.h"

#import <objc/runtime.h>

@interface PKRuntimeViewController ()

@end

@implementation PKRuntimeViewController

void ReportFunction(id self, SEL _cmd)
{
    NSLog(@"This object is %p.", self);
    NSLog(@"Class is %@, and super is %@.", [self class], [self superclass]);
	
    Class currentClass = [self class];
    for (int i = 1; i < 5; i++)
    {
        NSLog(@"Following the isa pointer %d times gives %p", i, currentClass);
        currentClass = object_getClass(currentClass);
    }
	
    NSLog(@"NSObject's class is %p", [NSObject class]);
    NSLog(@"NSObject's meta class is %p", object_getClass([NSObject class]));
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	Class newClass = objc_allocateClassPair([NSError class], "RuntimeErrorSubclass", 0);
	class_addMethod(newClass, @selector(report), (IMP)ReportFunction, "v@:");
	objc_registerClassPair(newClass);
	
	id instanceOfNewClass =
    [[newClass alloc] initWithDomain:@"someDomain" code:0 userInfo:nil];
	[instanceOfNewClass performSelector:@selector(report)];
}

@end
