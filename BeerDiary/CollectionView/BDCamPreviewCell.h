//
//  BDCamPreviewCell.h
//  BeerDiary
//
//  Created by Stephen Lindauer on 8/23/17.
//  Copyright © 2017 Stephen Lindauer. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol BDCamPreviewCellDelegate
- (void)cameraTookPhoto:(UIImage *)image;
@end

@class BDCamPreviewView;

@interface BDCamPreviewCell : UICollectionViewCell

@property (nonatomic, weak) UIViewController<BDCamPreviewCellDelegate> *viewController;
@property (weak, nonatomic) IBOutlet BDCamPreviewView *camPreviewView;

- (void)setup;
- (void)teardown;

@end
