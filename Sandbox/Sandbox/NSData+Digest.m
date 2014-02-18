//
//  NSData+Crypto.m
//  Sandbox
//
//  Created by Robert Edwards on 2/17/14.
//  Copyright (c) 2014 Panko. All rights reserved.
//

#import "NSData+Digest.h"

#import <CommonCrypto/CommonDigest.h>

@implementation NSData (Crypto)

- (NSData *)PK_SHA1 {
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    unsigned char *hashedData = CC_SHA1(self.bytes, self.length, digest);
    return [NSData dataWithBytes:hashedData length:self.length];
}

@end
