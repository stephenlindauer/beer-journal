//
//  BDRecentBeerCell.m
//  BeerDiary
//
//  Created by Stephen Lindauer on 8/17/17.
//  Copyright © 2017 Stephen Lindauer. All rights reserved.
//

#import "BDRecentBeerCell.h"
#import "BeerLog+CoreDataClass.h"
#import "Beer+CoreDataClass.h"
#import "Brewery+CoreDataClass.h"
#import "NSDate+Helper.h"
#import "Location+CoreDataClass.h"


@implementation BDRecentBeerCell

- (void)setLog:(BeerLog *)log
{
    _log = log;
    
    self.beerNameLabel.text = log.beer.name;
    self.breweryNameLabel.text = log.beer.brewery.name;
    self.dateLabel.text = [log.date stringDaysAgo];
    self.locationLabel.text = log.location.name;
    self.beerImageView.image = log.image;
}


@end
