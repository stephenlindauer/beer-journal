//
//  BDRecentBeerCell.h
//  BeerDiary
//
//  Created by Stephen Lindauer on 8/17/17.
//  Copyright © 2017 Stephen Lindauer. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BeerLog;

@interface BDRecentBeerCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *beerNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *breweryNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UIImageView *beerImageView;

@property (nonatomic, weak) BeerLog *log;


@end
