//
//  BDBeerLogCell.h
//  BeerDiary
//
//  Created by Stephen Lindauer on 8/11/17.
//  Copyright © 2017 Stephen Lindauer. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BeerLog;

@interface BDBeerLogCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *beerNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *breweryNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@property (nonatomic, weak) BeerLog *log;

@end
