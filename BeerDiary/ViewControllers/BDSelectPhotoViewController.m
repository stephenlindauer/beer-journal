//
//  BDSelectPhotoViewController.m
//  BeerDiary
//
//  Created by Stephen Lindauer on 8/19/17.
//  Copyright © 2017 Stephen Lindauer. All rights reserved.
//

@import AVFoundation;

#import "BDSelectPhotoViewController.h"
#import "BDCamPreviewView.h"
#import "AVCamPhotoCaptureDelegate.h"
#import "UIImage+Utils.h"
#import "BDBeerDetailsViewController.h"
#import "BeerLog+CoreDataClass.h"
#import "NSManagedObject+CoreData.h"
#import "BDCamPreviewCell.h"


static void * SessionRunningContext = &SessionRunningContext;

typedef NS_ENUM( NSInteger, AVCamSetupResult ) {
    AVCamSetupResultSuccess,
    AVCamSetupResultCameraNotAuthorized,
    AVCamSetupResultSessionConfigurationFailed
};

@interface BDSelectPhotoViewController ()

@property (nonatomic, strong) BDCamPreviewCell *camPreviewCell;

@end

@implementation BDSelectPhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];

}


#pragma mark Actions

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    BDBeerDetailsViewController *detailsViewController = segue.destinationViewController;
    
    BeerLog *log = [BeerLog createEntity];
//    [log setImage:self.capturedImageView.image];
    log.date = [NSDate date];
    
    
    detailsViewController.beerLog = log;
    
}

- (void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.camPreviewCell teardown];
}




#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 1;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (cell == self.camPreviewCell) {
//        [(BDCamPreviewCell *)cell setup];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (cell == self.camPreviewCell) {
        [(BDCamPreviewCell *)cell teardown];
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BDCamPreviewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CamPreviewCell" forIndexPath:indexPath];
    
    self.camPreviewCell = cell;
    
    // Configure the cell
    [cell setup];
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

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
