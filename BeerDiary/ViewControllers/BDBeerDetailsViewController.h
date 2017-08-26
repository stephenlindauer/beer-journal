//
//  BDBeerDetailsViewController.h
//  BeerDiary
//
//  Created by Stephen Lindauer on 8/21/17.
//  Copyright © 2017 Stephen Lindauer. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CLLocation;
@class BeerLog;

@interface BDBeerDetailsViewController : UITableViewController

@property (nonatomic, strong) BeerLog *beerLog;
@property (nonatomic, strong) CLLocation *startingLocation;

@property (weak, nonatomic) IBOutlet UITableViewCell *imageViewCell;
@property (weak, nonatomic) IBOutlet UIImageView *beerImageView;
@property (weak, nonatomic) IBOutlet UITextField *beerTextField;
@property (weak, nonatomic) IBOutlet UITextField *breweryTextField;
@property (weak, nonatomic) IBOutlet UITextField *locationTextField;
@property (weak, nonatomic) IBOutlet UISlider *ratingSliderView;
@property (weak, nonatomic) IBOutlet UILabel *ratingMessage;

@end
