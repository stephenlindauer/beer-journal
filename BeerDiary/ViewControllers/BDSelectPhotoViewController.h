//
//  BDSelectPhotoViewController.h
//  BeerDiary
//
//  Created by Stephen Lindauer on 8/19/17.
//  Copyright © 2017 Stephen Lindauer. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BDCamPreviewView;

@interface BDSelectPhotoViewController : UIViewController

@property (weak, nonatomic) IBOutlet BDCamPreviewView *camPreviewView;

@end
