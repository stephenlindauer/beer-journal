//
//  BDBeerSuggestionCell.h
//  BeerDiary
//
//  Created by Stephen Lindauer on 8/16/17.
//  Copyright © 2017 Stephen Lindauer. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Beer;

@interface BDBeerSuggestionCell : UICollectionViewCell

@property (nonatomic, weak) Beer *beer;
@property (nonatomic, strong) UILabel *beerNameLabel;
@property (nonatomic, strong) UILabel *breweryNameLabel;


@end
