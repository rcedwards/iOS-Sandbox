//
//  PKImageListTableViewController.m
//  Sandbox
//
//  Created by Robert Edwards on 2/17/14.
//  Copyright (c) 2014 Panko. All rights reserved.
//

#import "PKImageListTableViewController.h"

#import "PKImageCell.h"

@interface PKImageListTableViewController ()

@property (strong, nonatomic) NSArray *urls;

@end

@implementation PKImageListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
}

#pragma mark - Static Data Source

- (NSArray *)urls {
	if (!_urls) {
		_urls = @[[NSURL URLWithString:@""],
				  [NSURL URLWithString:@""],
				  [NSURL URLWithString:@""],
				  [NSURL URLWithString:@""],
				  [NSURL URLWithString:@""],
				  [NSURL URLWithString:@""],
				  [NSURL URLWithString:@""],
				  [NSURL URLWithString:@""],
				  [NSURL URLWithString:@""],
				  [NSURL URLWithString:@""],
				  [NSURL URLWithString:@""],
				  [NSURL URLWithString:@""],
				  [NSURL URLWithString:@""],
				  [NSURL URLWithString:@""],
				  [NSURL URLWithString:@""],
				  [NSURL URLWithString:@""],
				  [NSURL URLWithString:@""],
				  [NSURL URLWithString:@""],
				  [NSURL URLWithString:@""],
				  [NSURL URLWithString:@""],
				  [NSURL URLWithString:@""],
				  [NSURL URLWithString:@""],
				  [NSURL URLWithString:@""],
				  [NSURL URLWithString:@""],
				  [NSURL URLWithString:@""],
				  [NSURL URLWithString:@""],
				  [NSURL URLWithString:@""]];
	}
	return _urls;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.urls.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"PKImageCell";
    PKImageCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[PKImageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
	[cell configureWithImageURL:self.urls[indexPath.row]];
    
    return cell;
}

@end
