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
#import "NSManagedObject+CoreData.h"

@implementation BDRecentBeerCell

- (id)init
{
    self = [super init];
    
    UILongPressGestureRecognizer *deleteGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(promptForDelete)];
    [self addGestureRecognizer:deleteGestureRecognizer];
    
    return self;
}
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    NSLog(@"checking gesture should begin");
    [self promptForDelete];
    return YES;
}

- (void)promptForDelete
{
    NSLog(@"Prompt for delete");
    self.optionsContainerViewConstraint.constant = 0;
    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        
    }];
}

- (void)setLog:(BeerLog *)log
{
    _log = log;
    
    self.beerNameLabel.text = log.beer.name;
    self.breweryNameLabel.text = log.beer.brewery.name;
    self.dateLabel.text = [log.date stringDaysAgo];
    self.locationLabel.text = log.location.name;
    self.beerImageView.image = log.image;
}


- (IBAction)showOptions:(id)sender {
    
    self.optionsContainerViewConstraint.constant = 0;
    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        
    }];
    
    NSLog(@"PRESS");
}

- (IBAction)confirmDelete:(id)sender {
    [self.delegate beerLogWasDeleted:self.log];
}

- (IBAction)dismissOptions:(id)sender {
    self.optionsContainerViewConstraint.constant = self.bounds.size.height;
    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        
    }];
}
@end
