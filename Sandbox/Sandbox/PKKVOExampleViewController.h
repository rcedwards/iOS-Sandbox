//
//  PKKVOExampleViewController.h
//  Sandbox
//
//  Created by Robert Edwards on 12/9/13.
//  Copyright (c) 2013 Panko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PKKVOExampleViewController : UIViewController

extern NSString *const PKTextFieldSettingKey;

@property (weak, nonatomic) IBOutlet UITextField *kvoTextField;
@property (strong, nonatomic) NSMutableDictionary *settingsDictionary;

@end
