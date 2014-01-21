//
//  UIView+ObjectTag.h
//  UITesting
//
//  Created by Robert Edwards on 10/14/13.
//  Copyright (c) 2013 Panko. All rights reserved.
//
// Based on blog post @ http://oleb.net/blog/2011/05/faking-ivars-in-objc-categories-with-associative-references/

#import <UIKit/UIKit.h>

@interface UIView (ObjectTag)

@property (nonatomic, retain) id objectTag;

- (UIView *)viewWithObjectTag:(id)tag;

@end
