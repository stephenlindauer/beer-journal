//
//  BDSelectPhotoViewController.m
//  BeerDiary
//
//  Created by Stephen Lindauer on 8/19/17.
//  Copyright © 2017 Stephen Lindauer. All rights reserved.
//

@import AVFoundation;
@import Photos;

#import "BDSelectPhotoViewController.h"
#import "BDCamPreviewView.h"
#import "AVCamPhotoCaptureDelegate.h"
#import "UIImage+Utils.h"
#import "BDBeerDetailsViewController.h"
#import "BeerLog+CoreDataClass.h"
#import "NSManagedObject+CoreData.h"
#import "BDCamPreviewCell.h"
#import "BDPhotoCell.h"
#import "BDPhotoFetcher.h"





@interface BDSelectPhotoViewController ()

@property (nonatomic, strong) BDCamPreviewCell *camPreviewCell;
@property (nonatomic, strong) BDPhotoFetcher *photoFetcher;
@property (nonatomic, strong) UIImage *selectedImage;
@property (nonatomic, strong) PHAsset *selectedAsset;

@end

@implementation BDSelectPhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];

    
    self.photoFetcher = [BDPhotoFetcher new];
}


#pragma mark Actions

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    BDBeerDetailsViewController *detailsViewController = segue.destinationViewController;
    
    BeerLog *log = [BeerLog createEntity];
    [log setImage:self.selectedImage];
    if (self.selectedAsset) {
        log.date = self.selectedAsset.creationDate;
        detailsViewController.startingLocation = self.selectedAsset.location;
    }
    else {
        log.date = [NSDate date];
    }
    
    
    detailsViewController.beerLog = log;
    
}

- (void)useSelectedPhoto
{
    [self performSegueWithIdentifier:@"showBeerDetails" sender:nil];
}

- (void)cancel
{
    if (self.selectedImage == nil) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
    else {
        self.selectedImage = nil;
        [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:0]];
        self.navigationItem.rightBarButtonItem = nil;
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.camPreviewCell teardown];
}




#pragma mark <UICollectionViewDataSource>

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.width);
    }
    else {
        return CGSizeMake(self.view.bounds.size.width/4, self.view.bounds.size.width/4);
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 1;
            break;
            
        case 1:
            return self.photoFetcher.count;
            break;
            
        default:
            return 0;
    }
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (cell == self.camPreviewCell) {
        NSLog(@"will display cell");
//        [(BDCamPreviewCell *)cell setup];
    }
    
    if (indexPath.section == 1) {
        BDPhotoCell *photoCell = (BDPhotoCell *)cell;
        
        [self.photoFetcher fetchThumbnailImageAtIndex:indexPath.row success:^(UIImage *image) {
            dispatch_async(dispatch_get_main_queue(), ^{
                photoCell.photoImageView.image = image;
            });
        }];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (cell == self.camPreviewCell) {
        [(BDCamPreviewCell *)cell teardown];
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0 && self.selectedImage == nil) {
        return [self collectionView:collectionView camPreviewCellForItemAtIndexPath:indexPath];
    }
    if (indexPath.section == 0 && self.selectedImage != nil) {
        return [self collectionView:collectionView confirmationCellForItemAtIndexPath:indexPath];
    }
    if (indexPath.section == 1) {
        return [self collectionView:collectionView photoCellForItemAtIndexPath:indexPath];
    }
    return nil;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView camPreviewCellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BDCamPreviewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CamPreviewCell" forIndexPath:indexPath];
    
    self.camPreviewCell = cell;
    
    // Configure the cell
    [cell setup];
    
    return cell;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView photoCellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    BDPhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PhotoCell" forIndexPath:indexPath];
    return cell;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView confirmationCellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    BDPhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PhotoCell" forIndexPath:indexPath];
    
    cell.photoImageView.image = self.selectedImage;
    
    return cell;
    
}



#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.photoFetcher fetchFullsizeImageAndDetailsAtIndex:indexPath.row success:^(UIImage *image, PHAsset *asset) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.selectedImage = image;
            self.selectedAsset = asset;
            [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:0]];
            [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStyleDone target:self action:@selector(useSelectedPhoto)];
        });
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



@end
