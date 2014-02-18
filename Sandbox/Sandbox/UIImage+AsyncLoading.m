//
//  UIImage+AsyncLoading.m
//  Sandbox
//
//  Created by Robert Edwards on 2/17/14.
//  Copyright (c) 2014 Panko. All rights reserved.
//

#import "UIImage+AsyncLoading.h"
#import "NSString+Digest.h"

static NSOperationQueue *imageFetchOperationQueue;

@implementation UIImage (AsyncLoading)

+ (NSBlockOperation *)loadImageWithURL:(NSURL *)url scale:(CGFloat)scale
                           shouldCache:(BOOL)shouldCache completion:(void (^)(UIImage *))completion {
    static dispatch_once_t onceToken;
    static NSString *cacheDirectory = nil;
    
	dispatch_once(&onceToken, ^{
		imageFetchOperationQueue = [[NSOperationQueue alloc] init];
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        cacheDirectory = [paths firstObject];
	});
    
	NSBlockOperation *fetchOperation = [NSBlockOperation blockOperationWithBlock:^{
        NSData *imageData = nil;
        UIImage *image = nil;
        CGFloat imageScale = (scale) ?: 1.0f;
        
        NSString *hashPath = [[url absoluteString] PK_SHA1];
        NSString *cachePath = [cacheDirectory stringByAppendingPathComponent:hashPath];
        
        if (![[NSFileManager defaultManager] fileExistsAtPath:cachePath]) {
            imageData = [NSData dataWithContentsOfURL:url];
            if (shouldCache) {
                if (![[NSFileManager defaultManager] createFileAtPath:cachePath
                                                        contents:imageData
                                                           attributes:nil]) {
                    NSLog(@"Failed to save file");
                }
            }
        } else {
            imageData = [NSData dataWithContentsOfFile:cachePath];
        }
        
		if (imageData) {
            image = [UIImage imageWithData:imageData scale:imageScale];
        }
        
		dispatch_async(dispatch_get_main_queue(), ^{
			completion(image);
		});
	}];
	[imageFetchOperationQueue addOperation:fetchOperation];
	
	return fetchOperation;
}

@end
