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

@property (strong, nonatomic) NSArray *showIDs;

@end

@implementation PKImageListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
}

#pragma mark - Static Data Source

- (NSArray *)showIDs {
	if (!_showIDs) {
      	_showIDs = @[
                     @(161511),
                     @(73739),
                     @(247897),
                     @(262980),
                     @(79126),
                     @(73871),
                     @(74845),
                     @(84947),
                     @(70682),
                     @(134241),
                     @(210171),
                     @(79349),
                     @(79647),
                     @(261690),
                     @(84946)
                     ];
	}
	return _showIDs;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.showIDs.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"PKImageCell";
    PKImageCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[PKImageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSURL *url = [self urlWithShowID:self.showIDs[indexPath.row]];
	[cell configureWithImageURL:url];
    
    return cell;
}

#pragma mark - Table View Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 75.0f;
}

#pragma mark - URL Forming

- (NSURL *)urlWithShowID:(NSNumber *)showID {
    static NSString *host = @"http://thetvdb.com/banners/graphical/";
    NSString *path = [host stringByAppendingPathComponent:[NSString stringWithFormat:@"%@-g.jpg", showID]];
    return [NSURL URLWithString:path];
}

@end
