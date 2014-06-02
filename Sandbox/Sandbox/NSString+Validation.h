//
//  NSString+Validation.h
//  Sandbox
//
//  Created by Robert Edwards on 3/7/14.
//  Copyright (c) 2014 Panko. All rights reserved.
//
// NSString escaped version of perl based
// RFC 822 email address regex described here: http://www.ex-parrot.com/pdw/Mail-RFC822-Address.html
//

#import <Foundation/Foundation.h>

@interface NSString (Validation)

- (BOOL)validEmailAddress;

@end
