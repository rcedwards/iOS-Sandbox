//
//  PKColorSwapperViewController.m
//  Sandbox
//
//  Created by Robert Edwards on 1/15/14.
//  Copyright (c) 2014 Panko. All rights reserved.
//

/**
 
 Demonstrates the difference between a HSB based color and an RGB color.
 Use control switch to see color switching between grey and the stock HSB color;
 
 */

#import "PKColorSwapperViewController.h"

@interface PKColorSwapperViewController () {
	UIColor *__currentColor;
	UIColor *__originalColor;
}

@property (nonatomic, strong) NSTimer *swapColorTimer;
@property (weak, nonatomic) IBOutlet UISwitch *controlSwitch;
@property (weak, nonatomic) IBOutlet UILabel *currentColorLabel;

@end

@implementation PKColorSwapperViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	__originalColor = self.view.backgroundColor;
	[self.controlSwitch setOn:NO];
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	
	self.swapColorTimer = [NSTimer scheduledTimerWithTimeInterval:2.0
													  target:self
													selector:@selector(swapColor)
													userInfo:nil
													 repeats:YES];
	[self.swapColorTimer fire];
}

- (void)viewWillDisappear:(BOOL)animated {
	self.navigationController.navigationBar.barTintColor = __originalColor;
	
	[self.swapColorTimer invalidate];
	
	[super viewWillDisappear:animated];
}

- (void)swapColor {
	UIColor *HSBColor = [UIColor colorWithHue:0.577
								   saturation:0.455
								   brightness:0.965
										alpha:1];
	
	UIColor *RGBColor = [UIColor colorWithRed:0.525
										green:0.761 blue:0.965 alpha:1];
	UIColor *control_color = [UIColor darkGrayColor];
	
	NSString *currentColorDescription = nil;
	
	if ([__currentColor isEqual:HSBColor]) {
		if (self.controlSwitch.on) {
			__currentColor = control_color;
			currentColorDescription = @"Control Color";
		} else {
			__currentColor = RGBColor;
			currentColorDescription = @"RGB Based Color";
		}
	} else {
		__currentColor = HSBColor;
		currentColorDescription = @"HSB Based Color";
	}
	
	self.currentColorLabel.text = currentColorDescription;
	self.view.backgroundColor = __currentColor;
}

@end
