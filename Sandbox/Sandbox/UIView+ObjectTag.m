//
//  UIView+ObjectTag.m
//  UITesting
//
//  Created by Robert Edwards on 10/14/13.
//  Copyright (c) 2013 Panko. All rights reserved.
//

#import "UIView+ObjectTag.h"
#import <objc/runtime.h>

/** Note associated object key is a const void * 
 you have to pass the same pointer at runtime, 
 if you used an NSString that was copied it will not work.
 */
static char const * const kObjectTagKey = "ObjectTagKey";

@implementation UIView (ObjectTag)

@dynamic objectTag;

- (id)objectTag {
	return objc_getAssociatedObject(self, kObjectTagKey);
}

- (void)setObjectTag:(id)objectTag {
	objc_setAssociatedObject(self, kObjectTagKey, objectTag, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)viewWithObjectTag:(id)tag {
	__block UIView *matchingView = nil;
	
	if ([self.objectTag isEqual:tag]) {
		matchingView = self;
	} else {
		[self.subviews enumerateObjectsUsingBlock:^(UIView *subView, NSUInteger idx, BOOL *stop) {
			matchingView = [subView viewWithObjectTag:tag];
			if (matchingView) {
				*stop = YES;
			}
		}];
	}
	
	return matchingView;
}

@end
