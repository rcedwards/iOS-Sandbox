//
//  PKEmailValidationTests.m
//  Sandbox
//
//  Created by Robert Edwards on 3/7/14.
//  Copyright (c) 2014 Panko. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "NSString+Validation.h"

@interface PKEmailValidationTests : XCTestCase

@end

@implementation PKEmailValidationTests

- (void)setUp
{
    [super setUp];
    // Put setup code here; it will be run once, before the first test case.
}

- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
    [super tearDown];
}

- (void)testEmails
{
	NSString *invalidEmail = @"Look at all these spaces!@example.com";
	NSLog(@"%@", invalidEmail);

	NSString *alsoInvalidEmail = @"Look\\ at\\ all\\ these\\ spaces!@example.com";
	NSLog(@"%@", alsoInvalidEmail);
	
	NSString *validEmail = @"\"Look at all these spaces!\"@example.com";
	NSLog(@"%@", validEmail);
	
	XCTAssertFalse([invalidEmail validEmailAddress], @"Validator is falsely claiming %@ is a valid email address", invalidEmail);
	XCTAssertFalse([alsoInvalidEmail validEmailAddress], @"Validator is falsely claiming %@ is a valid email address", alsoInvalidEmail);
	XCTAssertTrue([validEmail validEmailAddress], @"Validator incorrectly flagged %@ as an invalid email address", validEmail);
}

@end
