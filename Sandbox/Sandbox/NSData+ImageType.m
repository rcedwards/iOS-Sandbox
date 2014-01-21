//
//  NSData+ImageType.m
//  Sandbox
//
//  Created by Robert Edwards on 1/2/14.
//  Copyright (c) 2014 Panko. All rights reserved.
//
// Based on NSPUIImageTypeFromData https://github.com/NSProgrammer
//

#import "NSData+ImageType.h"

@implementation NSData (ImageType)

- (PKImageType)imageType {
	PKImageType type = PKImageTypeUnknown;
	if (self.length > 4) {
		const unsigned char * bytes = [self bytes];
		if (bytes[0] == 0xff &&
			bytes[1] == 0xd8 &&
			bytes[2] == 0xff) {
			type = PKImageTypeJPEG;
		} else if (bytes[0] == 0x89 &&
			bytes[1] == 0x50 &&
			bytes[2] == 0x4e &&
			bytes[3] == 0x47) {
			type = PKImageTypePNG;
		}
	}
	
	return type;
}

@end
