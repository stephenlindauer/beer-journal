//
//  BDLocationCell.m
//  BeerDiary
//
//  Created by Stephen Lindauer on 8/16/17.
//  Copyright © 2017 Stephen Lindauer. All rights reserved.
//

#import "BDLocationCell.h"
#import "Location+CoreDataClass.h"


@implementation BDLocationCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setLocation:(Location *)location
{
    _location = location;
    
    self.locationLabel.text = location.name;
}

@end
