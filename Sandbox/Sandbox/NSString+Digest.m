//
//  NSString+Digest.m
//  Sandbox
//
//  Created by Robert Edwards on 2/17/14.
//  Copyright (c) 2014 Panko. All rights reserved.
//

#import "NSString+Digest.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (Digest)

- (NSString *)PK_SHA1 {
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(self.UTF8String, (int)self.length, digest);
    
    NSMutableString *result = [NSMutableString string];
    for (int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++) {
        [result appendFormat:@"%02X", digest[i]];
    }
    
    return result;
}

@end
