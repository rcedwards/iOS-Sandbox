//
//  PKBaseImageViewCell.m
//  ImageCollectionView
//
//  Created by Robert Edwards on 6/15/14.
//  Copyright (c) 2014 Panko. All rights reserved.
//

#import "PKBaseImageViewCell.h"

@implementation PKBaseImageViewCell

- (void)prepareForReuse {
    self.imageView.image = nil;
}

@end
