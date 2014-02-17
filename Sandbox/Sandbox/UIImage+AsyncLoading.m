//
//  UIImage+AsyncLoading.m
//  Sandbox
//
//  Created by Robert Edwards on 2/17/14.
//  Copyright (c) 2014 Panko. All rights reserved.
//

#import "UIImage+AsyncLoading.h"

static NSOperationQueue *imageFetchOperationQueue;

@implementation UIImage (AsyncLoading)

+ (NSBlockOperation *)loadImageWithURL:(NSURL *)url completion:(void (^)(UIImage *))completion {
	
	static CGFloat scale = 1.0f;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		imageFetchOperationQueue = [[NSOperationQueue alloc] init];
	});
	
	NSBlockOperation *fetchOperation = [NSBlockOperation blockOperationWithBlock:^{
		NSData *imageData = [NSData dataWithContentsOfURL:url];
		UIImage *image = nil;
		if (imageData)
			image = [UIImage imageWithData:imageData scale:scale];
		dispatch_async(dispatch_get_main_queue(), ^{
			completion(image);
		});
	}];
	[imageFetchOperationQueue addOperation:fetchOperation];
	
	return fetchOperation;
}

/* Alternate with cacheing
+(NSBlockOperation *)cachedImageFromURL:(NSString *)urlString
                    withCompletionBlock:(void(^)(UIImage *image))completionBlock
{
    static CGFloat scale = 0;
    static dispatch_once_t onceToken;
    static NSString *cachesDirectory = nil;
    dispatch_once(&onceToken, ^{
        scale = [UIScreen mainScreen].scale;
        if (!_operationQueue) {
            _operationQueue = [[NSOperationQueue alloc] init];
            _operationQueue.maxConcurrentOperationCount = 4;
        }
		
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        cachesDirectory = [paths objectAtIndex:0];
    });
	
    NSURL *imageURL = [NSURL URLWithString:urlString];
    NSString *filePath = [[cachesDirectory stringByAppendingFormat:@"/%@", imageURL.path] stringByStandardizingPath];
    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
        UIImage *image = nil;
        NSData *imageData = nil;
        BOOL needsSave = NO;
        if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
            imageData = [NSData dataWithContentsOfFile:filePath];
        } else {
            imageData = [NSData dataWithContentsOfURL:imageURL];
            needsSave = YES;
        }
		
        if (imageData) {
            image = [UIImage imageWithData:imageData scale:scale];
            if (needsSave) {
                NSMutableArray *pathCompnents = [NSMutableArray arrayWithArray:[filePath pathComponents]];
                [pathCompnents removeLastObject];
                NSString *fileDirectoryPath = [pathCompnents componentsJoinedByString:@"/"];
                // If any of the following file operations fail, there is no one to tell, really, so we fail silently.
                // Best practices in other scenarios would demand more robust error handling, of course.
                if ([[NSFileManager defaultManager] createDirectoryAtPath:fileDirectoryPath
                                              withIntermediateDirectories:YES attributes:nil error:nil]) {
                    [imageData writeToFile:filePath options:NSDataWritingAtomic error:nil];
                }
            }
        }
		
        dispatch_async(dispatch_get_main_queue(), ^{
            completionBlock(image);
        });
    }];
    [_operationQueue addOperation:operation];
	
    return operation;
}*/

@end
