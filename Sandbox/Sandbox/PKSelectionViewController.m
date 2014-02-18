//
//  PKSelectionViewController.m
//  Sandbox
//
//  Created by Robert Edwards on 1/14/14.
//  Copyright (c) 2014 Panko. All rights reserved.
//

#import "PKSelectionViewController.h"

#import "PKKVOExampleViewController.h"
#import "PKImageEvalViewController.h"
#import "PKColorSwapperViewController.h"
#import "PKShakeViewController.h"
#import "PKCardDemoViewController.h"
#import "PKGlobalNotificationsViewController.h"
#import "PKBackgroundExampleViewController.h"
#import "PKRuntimeViewController.h"
#import "PKImageListTableViewController.h"

@interface PKSelectionViewController ()

@property (nonatomic, strong) NSArray *viewControllerCollection;
@property (nonatomic, strong) NSArray *sectionTitles;

@end

@implementation PKSelectionViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        
        _viewControllerCollection = @[@[
										  NSStringFromClass([PKColorSwapperViewController class]),
										  NSStringFromClass([PKImageEvalViewController class]),
                                          NSStringFromClass([PKShakeViewController class]),
										  NSStringFromClass([PKImageListTableViewController class])],
                                      @[
										  NSStringFromClass([PKKVOExampleViewController class]),
										  NSStringFromClass([PKGlobalNotificationsViewController class])],
                                      @[
                                          NSStringFromClass([PKCardDemoViewController class]),
										  NSStringFromClass([PKRuntimeViewController class])],
                                      @[
                                          NSStringFromClass([PKBackgroundExampleViewController class])]];
        
        _sectionTitles = @[@"UI Stuff",
                           @"KVO / Notifications",
                           @"Models",
                           @"Networking"];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.navigationItem.title = @"Sandbox Examples";
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.viewControllerCollection.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.viewControllerCollection[section] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.sectionTitles[section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = self.viewControllerCollection[indexPath.section][indexPath.row];
    
    return cell;
}

#pragma mark - Table view delgate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *vc = [[NSClassFromString(self.viewControllerCollection[indexPath.section][indexPath.row]) alloc] init];
    if (self.splitViewController) {
		self.splitViewController.viewControllers = @[self.navigationController, vc];
    } else {
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
