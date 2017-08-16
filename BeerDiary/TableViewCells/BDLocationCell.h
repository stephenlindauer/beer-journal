//
//  BDLocationCell.h
//  BeerDiary
//
//  Created by Stephen Lindauer on 8/16/17.
//  Copyright © 2017 Stephen Lindauer. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Location;

@interface BDLocationCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (nonatomic, weak) Location *location;

@end
