//
//  PKBackgroundExampleViewController.h
//  TheTVDBKit
//
//  Created by Robert Edwards on 12/19/13.
//  Copyright (c) 2013 Panko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PKBackgroundExampleViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

- (IBAction)send:(id)sender;
- (IBAction)crash:(id)sender;

@end
