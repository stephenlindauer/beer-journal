//
//  BDRecentBeerCell.h
//  BeerDiary
//
//  Created by Stephen Lindauer on 8/17/17.
//  Copyright © 2017 Stephen Lindauer. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BeerLog;

@protocol BDRecentBeerCellDelegate

- (void)beerLogWasDeleted:(BeerLog *)log;
@end


@interface BDRecentBeerCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *profileNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *beerNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *breweryNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UIImageView *beerImageView;
@property (weak, nonatomic) IBOutlet UIImageView *star1ImageView;
@property (weak, nonatomic) IBOutlet UIImageView *star2ImageView;
@property (weak, nonatomic) IBOutlet UIImageView *star3ImageView;
@property (weak, nonatomic) IBOutlet UIImageView *star4ImageView;
@property (weak, nonatomic) IBOutlet UIImageView *star5ImageView;



@property (nonatomic, weak) BeerLog *log;
@property (nonatomic, weak) id<BDRecentBeerCellDelegate> delegate;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *optionsContainerViewConstraint;

- (IBAction)confirmDelete:(id)sender;
- (IBAction)dismissOptions:(id)sender;


@end
