//
//  BDCamPreviewCell.h
//  BeerDiary
//
//  Created by Stephen Lindauer on 8/23/17.
//  Copyright © 2017 Stephen Lindauer. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface BDCamPreviewCell : UICollectionViewCell

@property (nonatomic, weak) UIViewController *viewController;

- (void)setup;
- (void)teardown;

@end
