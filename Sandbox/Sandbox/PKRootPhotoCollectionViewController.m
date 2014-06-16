//
//  PKRootPhotoCollectionViewController.m
//  ImageCollectionView
//
//  Created by Robert Edwards on 6/15/14.
//  Copyright (c) 2014 Panko. All rights reserved.
//

#import "PKRootPhotoCollectionViewController.h"

#import "PKBaseImageViewCell.h"
#import "PKSupplementaryView.h"

static NSString * const kPhotoCellReuseID = @"PKPhotoCellResuseIdentifier";
static NSString * const kSupplementaryReuseID = @"PKSupplementaryReuseID";

@interface PKRootPhotoCollectionViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSArray *imageURLStrings;
@property (strong, nonatomic) NSArray *sectionTitles;

@end

@implementation PKRootPhotoCollectionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _imageURLStrings = @[
                             @[
                                 @"http://i1-news.softpedia-static.com/images/news2/Some-Versions-of-OS-X-Lion-Don-t-Support-FCP-X-10-0-3-2.png",
                                 @"http://www.nordicblueconsulting.com/wp-content/uploads/2012/07/OS-X-Mountain-Lion-Logo-150x150.png",
                                 @"http://macx64.com/wp-content/uploads/2014/02/Osx-mavericks-logo-300x300.png",
                                 @"http://blog.typpz.com/wp-content/yosemite-300x300.png",
                                 @"http://i1-news.softpedia-static.com/images/news2/Some-Versions-of-OS-X-Lion-Don-t-Support-FCP-X-10-0-3-2.png",
                                 @"http://www.nordicblueconsulting.com/wp-content/uploads/2012/07/OS-X-Mountain-Lion-Logo-150x150.png",
                                 @"http://macx64.com/wp-content/uploads/2014/02/Osx-mavericks-logo-300x300.png",
                                 @"http://blog.typpz.com/wp-content/yosemite-300x300.png"
                             ],
                             @[
                                 @"http://www.hdicon.com/wp-content/uploads/2010/06/windows_xp.png",
                                 @"http://www.photoshop101.com/content_images/1/vista_orb/Greenorb.png",
                                 @"http://www.computersafetytip.com/wp-content/uploads/2010/08/Harmony_Logo_by_BumbleBritches57-300x300.png",
                                 @"http://www.photoshopgurus.com/forum/attachments/product-reviews/23823d1352609510t-windows-8-you-ready-wins8.png",
                                 @"http://www.hdicon.com/wp-content/uploads/2010/06/windows_xp.png",
                                 @"http://www.photoshop101.com/content_images/1/vista_orb/Greenorb.png",
                                 @"http://www.computersafetytip.com/wp-content/uploads/2010/08/Harmony_Logo_by_BumbleBritches57-300x300.png",
                                 @"http://www.photoshopgurus.com/forum/attachments/product-reviews/23823d1352609510t-windows-8-you-ready-wins8.png"
                             ]
                       ];
        
        _sectionTitles = @[
                           @"OS X",
                           @"Windows"
                           ];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([PKBaseImageViewCell class]) bundle:nil]
          forCellWithReuseIdentifier:kPhotoCellReuseID];
    
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([PKSupplementaryView class]) bundle:nil]
          forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kSupplementaryReuseID];
}

#pragma mark - Collection View Delegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.imageURLStrings.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.imageURLStrings[section] count];
    ;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PKBaseImageViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kPhotoCellReuseID forIndexPath:indexPath];
    
    NSURL *url = [NSURL URLWithString:self.imageURLStrings[indexPath.section][indexPath.row]];
    
    cell.backgroundView = [UIView new];
    cell.selectedBackgroundView = [UIView new];
    cell.backgroundView.backgroundColor = [UIColor clearColor];
    cell.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:0.976 green:0.949 blue:0.882 alpha:1];
    cell.layer.cornerRadius = 6.0f;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0ul), ^{
        NSData *imageData = [NSData dataWithContentsOfURL:url];
        dispatch_sync(dispatch_get_main_queue(), ^{
            if ([collectionView.indexPathsForVisibleItems containsObject:indexPath]) {
                UIImage *image = [UIImage imageWithData:imageData];
                cell.imageView.image = image;
            }
        });
    });

    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    PKSupplementaryView *suppView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                                                       withReuseIdentifier:kSupplementaryReuseID forIndexPath:indexPath];
    suppView.titleLabel.text = self.sectionTitles[indexPath.section];
    return suppView;
}

@end
