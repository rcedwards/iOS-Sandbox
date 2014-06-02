//
//  PKUIMasterViewController.m
//  UITesting
//
//  Created by Robert Edwards on 10/2/13.
//  Copyright (c) 2013 Panko. All rights reserved.
//

#import "PKAssosicatedObjectHelperTableViewController.h"

#import "UIView+ObjectTag.h"

@interface PKAssosicatedObjectHelperTableViewController () {
    NSMutableArray *_objects;
}

@property (nonatomic, retain) NSDate *mostCurrentDate;

@end

@implementation PKAssosicatedObjectHelperTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	self.navigationItem.leftBarButtonItem = self.editButtonItem;

	UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
	self.navigationItem.rightBarButtonItem = addButton;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Private Helpers

- (void)updateMostCurrentDateHighlight {
    
    UIView *previouslyMostCurrentView = [self.tableView viewWithObjectTag:self.mostCurrentDate];
	[previouslyMostCurrentView setBackgroundColor:nil];
    
    if (_objects.count) {
        self.mostCurrentDate = _objects[0];
    }
    
    UIView *mostCurrentView = [self.tableView viewWithObjectTag:self.mostCurrentDate];
	mostCurrentView.backgroundColor = [UIColor lightGrayColor];
}

- (void)insertNewObject:(id)sender
{
    if (!_objects) {
        _objects = [[NSMutableArray alloc] init];
    }
    
	NSDate *currentDate = [NSDate date];
	[_objects insertObject:currentDate atIndex:0];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
	
    [self updateMostCurrentDateHighlight];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return _objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
	if (!cell) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
	}
	NSDate *object = _objects[indexPath.row];
	cell.textLabel.text = [object description];
	cell.objectTag = object;
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_objects removeObjectAtIndex:indexPath.row];
        
        [self updateMostCurrentDateHighlight];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

@end
