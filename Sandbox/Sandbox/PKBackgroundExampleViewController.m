//
//  PKBackgroundExampleViewController.m
//  TheTVDBKit
//
//  Created by Robert Edwards on 12/19/13.
//  Copyright (c) 2013 Panko. All rights reserved.
//

#import "PKBackgroundExampleViewController.h"
#import "PKAppDelegate.h"

@interface PKBackgroundExampleViewController () <NSURLSessionDelegate, NSURLSessionDownloadDelegate>

@property (nonatomic, strong) NSURLSessionDownloadTask *task;
@property (nonatomic) NSURLSession *session;

@end

@implementation PKBackgroundExampleViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
	[super viewDidLoad];
	
	self.session = [self backgroundSession];
	
	self.progressView.progress = 0;
	self.imageView.hidden = NO;
	self.progressView.hidden = YES;
    
    self.navigationItem.title = @"Background Example";
}

#pragma mark - Accessors

- (NSURLSession *)backgroundSession {
	static NSURLSession *session = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		NSURLSessionConfiguration *config = [NSURLSessionConfiguration backgroundSessionConfiguration:@"me.panko.ios.BackgroundExample"];
		session = [NSURLSession sessionWithConfiguration:config
												delegate:self
										   delegateQueue:nil];
	});
	return session;
}

#pragma mark - User Actions

- (IBAction)send:(id)sender {
	if (self.task) return;
	
	NSURL *elCapitan = [NSURL URLWithString:@"http://upload.wikimedia.org/wikipedia/commons/e/e2/Yosemite_El_Capitan.jpg"];
	NSURLRequest *request = [NSURLRequest requestWithURL:elCapitan];
	self.task = [self.session downloadTaskWithRequest:request];
	[self.task resume];
	
	self.imageView.hidden = YES;
	self.progressView.hidden = NO;
}

- (IBAction)crash:(id)sender {
	NSObject *test = nil;
	__unused NSArray *TEST = @[test];
}

#pragma mark - URL Session Delegate

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite {
	double progress = (double)totalBytesWritten/(double)totalBytesExpectedToWrite;
	dispatch_async(dispatch_get_main_queue(), ^{
		self.progressView.progress = progress;
	});
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location {
	//Grab user dir
	
	NSArray *URLs = [[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory
														   inDomains:NSUserDomainMask];
	NSURL *documentsURL = [URLs firstObject];
	
	NSURL *originalURL = downloadTask.originalRequest.URL;
	NSURL *destinationURL = [documentsURL URLByAppendingPathComponent:originalURL.lastPathComponent];
	
	NSError *copyError = nil;
	[[NSFileManager defaultManager] removeItemAtURL:destinationURL error:NULL];
	BOOL success = [[NSFileManager defaultManager] copyItemAtURL:location toURL:destinationURL error:&copyError];
	if (success) {
		//Display image
		dispatch_async(dispatch_get_main_queue(), ^{
			UIImage *image = [UIImage imageWithContentsOfFile:destinationURL.path];
			self.imageView.image = image;
			self.progressView.hidden = YES;
			self.imageView.hidden = NO;
		});
	} else {
		NSLog(@"Error: %@", copyError);
	}
}

-(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didResumeAtOffset:(int64_t)fileOffset expectedTotalBytes:(int64_t)expectedTotalBytes
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
	if (error) {
		NSLog(@"Fail");
	}
	
	double progress = (double)task.countOfBytesReceived / (double)task.countOfBytesExpectedToReceive;
	dispatch_async(dispatch_get_main_queue(), ^{
		self.progressView.progress = progress;
	});
	self.task = nil;
}

- (void)URLSessionDidFinishEventsForBackgroundURLSession:(NSURLSession *)session {
	PKAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
	if (appDelegate.backgroundSessionCompletionHandler) {
		void (^completion)() = appDelegate.backgroundSessionCompletionHandler;
		appDelegate.backgroundSessionCompletionHandler = nil;
		completion();
	}
}

@end
