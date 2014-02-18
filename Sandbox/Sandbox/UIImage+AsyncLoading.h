//
//  UIImage+AsyncLoading.h
//  Sandbox
//
//  Created by Robert Edwards on 2/17/14.
//  Copyright (c) 2014 Panko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (AsyncLoading)

+ (NSBlockOperation *)loadImageWithURL:(NSURL *)url
                                 scale:(CGFloat)scale
                           shouldCache:(BOOL)shouldCache
                            completion:(void(^)(UIImage *image))completion;

@end
