//
//  NSData+ImageType.h
//  Sandbox
//
//  Created by Robert Edwards on 1/2/14.
//  Copyright (c) 2014 Panko. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, PKImageType) {
	PKImageTypePNG,
	PKImageTypeJPEG,
	PKImageTypeUnknown
};

@interface NSData (ImageType)

- (PKImageType)imageType;

@end
