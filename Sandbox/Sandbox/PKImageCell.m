//
//  PKImageCell.m
//  Sandbox
//
//  Created by Robert Edwards on 2/17/14.
//  Copyright (c) 2014 Panko. All rights reserved.
//

#import "PKImageCell.h"
#import "UIImage+AsyncLoading.h"

@interface PKImageCell()

@property (nonatomic, strong) NSBlockOperation *loadOperation;

@end

@implementation PKImageCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)configureWithImageURL:(NSURL *)imageURL {
	self.loadOperation = [UIImage loadImageWithURL:imageURL completion:^(UIImage *image) {
		self.imageView.image = image;
	}];
}

- (void)prepareForReuse {
	[self.loadOperation cancel];
	self.loadOperation = nil;
}

@end
