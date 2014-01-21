//
//  PKImageEvalViewController.m
//  Sandbox
//
//  Created by Robert Edwards on 1/15/14.
//  Copyright (c) 2014 Panko. All rights reserved.
//

#import "PKImageEvalViewController.h"

#import "NSData+ImageType.h"

@interface PKImageEvalViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *elCapitanImageView;
@property (weak, nonatomic) IBOutlet UIImageView *afNetworkLogoImageView;
@property (weak, nonatomic) IBOutlet UILabel *elCapitanLabel;
@property (weak, nonatomic) IBOutlet UILabel *afNetworkLabel;

@end

@implementation PKImageEvalViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	NSString *resourcePath = [[NSBundle mainBundle] resourcePath];
	NSString *afPath = [resourcePath stringByAppendingPathComponent:@"AFIcon.png"];
	NSString *elCapitanPath = [resourcePath stringByAppendingPathComponent:@"El_Capitan.jpg"];
	
	NSData *afLogo = [NSData dataWithContentsOfFile:afPath];
	NSData *elCapitan = [NSData dataWithContentsOfFile:elCapitanPath];
	
	self.elCapitanImageView.image = [UIImage imageWithContentsOfFile:elCapitanPath];
	self.afNetworkLogoImageView.image = [UIImage imageWithContentsOfFile:afPath];
	
	NSAssert([afLogo imageType] == PKImageTypePNG, @"AF Logo is not of type PNG");
	NSAssert([elCapitan imageType] == PKImageTypeJPEG, @"El Capitan is not of type JPG");
	
	self.afNetworkLabel.text = @"PNG";
	self.elCapitanLabel.text = @"JPG";
}


@end
