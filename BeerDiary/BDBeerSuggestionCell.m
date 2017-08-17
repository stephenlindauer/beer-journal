//
//  BDBeerSuggestionCell.m
//  BeerDiary
//
//  Created by Stephen Lindauer on 8/16/17.
//  Copyright © 2017 Stephen Lindauer. All rights reserved.
//

#import "BDBeerSuggestionCell.h"
#import "Beer+CoreDataClass.h"
#import "Brewery+CoreDataClass.h"


@implementation BDBeerSuggestionCell

- (void)setBeer:(Beer *)beer
{
    // Setup labels on first time config
    if (self.beerNameLabel == nil) {
        
        self.beerNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 300, 25)];
        self.breweryNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 26, 300, 20)];
        
        self.beerNameLabel.font = [UIFont systemFontOfSize:16];
        self.breweryNameLabel.font = [UIFont systemFontOfSize:12];
        
        self.translatesAutoresizingMaskIntoConstraints = NO;
        self.beerNameLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.breweryNameLabel.translatesAutoresizingMaskIntoConstraints = NO;
        
        [self addSubview:self.beerNameLabel];
        [self addSubview:self.breweryNameLabel];
        
        // Setup autolayout constraints
//        NSDictionary *views = @{
//                                @"beerLabel": self.beerNameLabel,
//                                @"breweryLabel": self.breweryNameLabel
//                                };
//
//        NSString *hFormat = @"H:|[beerLabel]-5-[breweryLabel]";
//
//        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[beerLabel]-5-|" options:NSLayoutFormatAlignAllCenterX metrics:nil views:views]];
//        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[breweryLabel]|" options:NSLayoutFormatAlignAllCenterX metrics:nil views:views]];
//
//        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:hFormat options:NSLayoutFormatAlignAllCenterY metrics:nil views:views]];
//
        
    }
    
    self.beerNameLabel.text = beer.name;
    self.breweryNameLabel.text = beer.brewery.name;
    
    
    
}

@end
