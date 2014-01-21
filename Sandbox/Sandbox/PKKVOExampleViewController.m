//
//  PKKVOExampleViewController.m
//  Sandbox
//
//  Created by Robert Edwards on 12/9/13.
//  Copyright (c) 2013 Panko. All rights reserved.
//

#import "PKKVOExampleViewController.h"

NSString *const PKTextFieldSettingKey = @"PKTextFieldSettingKey";

@interface PKKVOExampleViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *oldValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *updatedValueLabel;

@end

@implementation PKKVOExampleViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		_settingsDictionary = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.kvoTextField.delegate = self;
	
	UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
																				 action:@selector(dismissTextField)];
	tapGesture.numberOfTapsRequired = 1;
	[self.view addGestureRecognizer:tapGesture];
}

- (void)viewWillAppear:(BOOL)animated {
    [self setUpKVO];
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self tearDownKVO];
    [super viewWillDisappear:animated];
}

#pragma mark - Gesture Recognizer

- (void)dismissTextField {
	[self.kvoTextField endEditing:YES];
}

#pragma mark - TextField Delegate

- (void)textFieldDidEndEditing:(UITextField *)textField {
	self.settingsDictionary[PKTextFieldSettingKey] = textField.text;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	[self.kvoTextField resignFirstResponder];
	return YES;
}

#pragma mark - KVO Observing

- (void)setUpKVO {
	[self
	 addObserver:self
	 forKeyPath:[self observingKeypath]
	 options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld
	 context:NULL];
}

- (void)tearDownKVO {
    [self removeObserver:self forKeyPath:[self observingKeypath]];
}

- (NSString *)observingKeypath {
    return [NSString stringWithFormat:@"%@.%@",
            NSStringFromSelector(@selector(settingsDictionary)),
            PKTextFieldSettingKey];
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
	id oldValue = change[NSKeyValueChangeOldKey];
	id updatedValue = change[NSKeyValueChangeNewKey];
	
	if ([oldValue isKindOfClass:[NSString class]]) {
		self.oldValueLabel.text = oldValue;
	}
	if ([updatedValue isKindOfClass:[NSString class]]) {
		self.updatedValueLabel.text = updatedValue;
	}
}

@end
