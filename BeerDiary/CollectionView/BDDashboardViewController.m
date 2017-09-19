//
//  BDDashboardViewController.m
//  BeerDiary
//
//  Created by Stephen Lindauer on 8/17/17.
//  Copyright © 2017 Stephen Lindauer. All rights reserved.
//

#import "BDDashboardViewController.h"
#import "BeerLog+CoreDataClass.h"
#import "BDRecentBeerCell.h"
#import "NSManagedObjectContext+Utils.h"
#import "NSManagedObject+CoreData.h"
#import "BDClient.h"
#import "UIImage+Utils.h"


@interface BDDashboardViewController () <BDRecentBeerCellDelegate>

@property (nonatomic, strong) NSArray <BeerLog *> *recentBeers;

@end

@implementation BDDashboardViewController

static NSString * const reuseIdentifier = @"RecentBeerCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
//    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    self.recentBeers = [BeerLog findAllSortedBy:@"date" ascending:NO];
    
    [self.collectionView reloadData];
}

- (IBAction)showNewBeerView:(id)sender {
    
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // Full width
     return CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.width + 90);
    
    // 3 per row
//    return CGSizeMake(self.view.bounds.size.width / 3, self.view.bounds.size.width / 3 + 50);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.recentBeers.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BDRecentBeerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    cell.log = self.recentBeers[indexPath.row];
    cell.delegate = self;
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    BeerLog *log = self.recentBeers[indexPath.row];
    
    UIImage *image = [[log.image cropCenter] resize:CGSizeMake(1200, 1200)];
//    UIImage *image = [[log.image cropCenter] resize:CGSizeMake(120, 120)];
    [BDClient uploadImage:image progress:^(CGFloat progress) {
        
    } success:^(NSString *url) {
        NSLog(@"image: %@", url);
    } failure:^(NSError *error) {
        
    }];
}

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

#pragma mark - Recent Beer Cell delegate

- (void)beerLogWasDeleted:(BeerLog *)log
{
    [log deleteEntity];
    
    for (int i=0; i<self.recentBeers.count; i++) {
        if (self.recentBeers[i] == log) {
            
            NSMutableArray *mutableBeers = [self.recentBeers mutableCopy];
            [mutableBeers removeObjectAtIndex:i];
            
            [self.collectionView performBatchUpdates:^{
                self.recentBeers = mutableBeers;
                
                [self.collectionView deleteItemsAtIndexPaths:@[[NSIndexPath indexPathForRow:i inSection:0]]];
            } completion:^(BOOL finished) {
                
            }];
            
        }
    }
    
    [log saveManagedObjectContext];
}

@end
