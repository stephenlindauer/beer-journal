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
    self.optionsContainerViewConstraint.constant = self.bounds.size.height;
    [self layoutIfNeeded];
    
    self.optionsContainerViewConstraint.constant = 0;
    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        
    }];
}

- (void)setLog:(BeerLog *)log
{
    _log = log;
    
    self.profileImageView.layer.cornerRadius = 20;
    
    self.beerNameLabel.text = log.beer.name;
    self.breweryNameLabel.text = log.beer.brewery.name;
    self.dateLabel.text = [log.date stringDaysAgo];
    self.dateLabel.text = [log.date stringWithFormat:@"MMM d, h:mm a"];
    self.locationLabel.text = log.location.name;
    self.beerImageView.image = log.image;
    
    self.star1ImageView.hidden = log.rating < 1;
    self.star2ImageView.hidden = log.rating < 2;
    self.star3ImageView.hidden = log.rating < 3;
    self.star4ImageView.hidden = log.rating < 4;
    self.star5ImageView.hidden = log.rating < 5;
}


- (IBAction)showOptions:(id)sender {
    self.optionsContainerViewConstraint.constant = self.bounds.size.height;
    [self layoutIfNeeded];
    self.hidden = NO;
    
    self.optionsContainerViewConstraint.constant = 0;
    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        
    }];
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
