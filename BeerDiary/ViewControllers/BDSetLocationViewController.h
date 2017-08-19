//
//  BDSetLocationViewController.h
//  BeerDiary
//
//  Created by Stephen Lindauer on 8/16/17.
//  Copyright © 2017 Stephen Lindauer. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Location, CLLocation;

@protocol BDSetLocationDelegate
- (void)locationChangedTo:(Location *)location;
@end

@interface BDSetLocationViewController : UITableViewController

@property (nonatomic, weak) CLLocation *startingLocation;
@property (nonatomic, strong) NSArray <Location *> *locations;
@property (nonatomic, strong) id<BDSetLocationDelegate> delegate;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;


@end
