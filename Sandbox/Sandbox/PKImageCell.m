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
@property (nonatomic, strong) UIImageView *bannerImageView;

@end

@implementation PKImageCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _bannerImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _bannerImageView.contentMode = UIViewContentModeScaleAspectFit;
        _bannerImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        [self.contentView addSubview:_bannerImageView];
   }
    return self;
}

- (void)configureWithImageURL:(NSURL *)imageURL {
	self.loadOperation = [UIImage loadImageWithURL:imageURL scale:0.7f shouldCache:YES completion:^(UIImage *image) {
		self.bannerImageView.image = image;
	}];
}

- (void)prepareForReuse {
	[self.loadOperation cancel];
	self.loadOperation = nil;
    self.bannerImageView.image = nil;
}

@end
