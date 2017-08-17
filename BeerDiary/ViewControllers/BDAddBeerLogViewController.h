//
//  BDAddBeerLogViewController.h
//  BeerDiary
//
//  Created by Stephen Lindauer on 8/11/17.
//  Copyright © 2017 Stephen Lindauer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BDAddBeerLogViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *beerTextField;
@property (weak, nonatomic) IBOutlet UITextField *breweryTextField;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UISlider *ratingSlider;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIButton *changeDateButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelDateButton;

- (IBAction)cancelSetDate:(id)sender;
- (IBAction)changeDate:(id)sender;
- (IBAction)roundSliderToValue:(id)sender;

@end
