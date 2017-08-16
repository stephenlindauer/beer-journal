//
//  BDBeerLogCell.m
//  BeerDiary
//
//  Created by Stephen Lindauer on 8/11/17.
//  Copyright © 2017 Stephen Lindauer. All rights reserved.
//

#import "BDBeerLogCell.h"

#import "BeerLog+CoreDataClass.h"
#import "Beer+CoreDataClass.h"
#import "Brewery+CoreDataClass.h"
#import "Location+CoreDataClass.h"
#import "NSDate+Helper.h"


@implementation BDBeerLogCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (void)setLog:(BeerLog *)log
{
    _log = log;
    
    self.beerNameLabel.text = log.beer.name;
    self.breweryNameLabel.text = log.beer.brewery.name;
    self.dateLabel.text = [log.date stringDaysAgo];
    self.locationLabel.text = log.location.name;
}

@end
