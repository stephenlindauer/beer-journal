//
//  BDBeerDetailsViewController.m
//  BeerDiary
//
//  Created by Stephen Lindauer on 8/21/17.
//  Copyright © 2017 Stephen Lindauer. All rights reserved.
//

#import "BDBeerDetailsViewController.h"
#import "BeerLog+CoreDataClass.h"
#import "Beer+CoreDataClass.h"
#import "Brewery+CoreDataClass.h"
#import "Location+CoreDataClass.h"
#import "BDBeerSuggestionAccessoryView.h"
#import "NSManagedObject+CoreData.h"
#import <CoreLocation/CoreLocation.h>
#import "BDLocationClient.h"
#import "BDSetLocationViewController.h"


@interface BDBeerDetailsViewController () <BDBeerSuggestionDelegate, CLLocationManagerDelegate, UITextFieldDelegate, BDSetLocationDelegate>

@property (nonatomic, strong) BDBeerSuggestionAccessoryView *suggestionView;
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) NSArray <Location *> *locations;

@end

@implementation BDBeerDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.bounces = YES;
    self.tableView.alwaysBounceVertical = YES;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleDone target:self action:@selector(saveBeerLog)];
    
    [self lookupLocationIfNeeded];
    [self configureBeerSuggestions];
    [self configureFields];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    if (self.isMovingFromParentViewController) {
        [self.beerLog deleteEntity];
    }
}

- (void)lookupLocationIfNeeded
{
    if (self.beerLog.location == nil && self.startingLocation == nil) {
        // Setup location manager
        self.locationManager = [CLLocationManager new];
        self.locationManager.delegate = self;
        [self.locationManager requestAlwaysAuthorization];
        [self.locationManager startUpdatingLocation];
    }
    else if (self.startingLocation != nil) {
        [self fetchLocationsFrom:self.startingLocation];
    }
}

- (void)configureBeerSuggestions
{
    self.suggestionView = [[BDBeerSuggestionAccessoryView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 50)];
    self.suggestionView.delegate = self;
    self.beerTextField.inputAccessoryView = self.suggestionView;
}

- (void)configureFields
{
    self.beerImageView.image = self.beerLog.image;
    self.beerTextField.text = self.beerLog.beer.name;
    self.breweryTextField.text = self.beerLog.beer.brewery.name;
    self.locationTextField.text = self.beerLog.location.name;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)ratingSliderValueChanged:(id)sender {
    self.ratingSliderView.value = (int)(self.ratingSliderView.value + 0.5);
    self.beerLog.rating = self.ratingSliderView.value;
    
    NSArray *ratingMessages = @[
                                @"I'll rate this beer later.",
                                @"Awful! Never again.",
                                @"Nope, not a fan.",
                                @"Okay, would drink again.",
                                @"Good, bring me another.",
                                @"Love it!"
                                ];
    self.ratingMessage.text = ratingMessages[self.beerLog.rating];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"setLocation"]) {
        BDSetLocationViewController *setLocationViewController = segue.destinationViewController;
        setLocationViewController.locations = self.locations;
        setLocationViewController.delegate = self;
        setLocationViewController.startingLocation = self.startingLocation;
    }
}

- (void)saveBeerLog
{
    
    Brewery *brewery = [Brewery findFirstByAttribute:@"name" withValue:self.breweryTextField.text];
    if (brewery == nil) {
        brewery = [Brewery createEntity];
        brewery.name = self.breweryTextField.text;
    }
    
    Beer *beer = [Beer findFirstWithPredicate:[NSPredicate predicateWithFormat:@"name = %@ AND brewery = %@", self.beerTextField.text, brewery]];
    if (beer == nil) {
        beer = [Beer createEntity];
        beer.name = self.beerTextField.text;
        beer.brewery = brewery;
    }
    
    self.beerLog.beer = beer;
    [self.beerLog saveManagedObjectContext];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)fetchLocationsFrom:(CLLocation *)location
{
    [[BDLocationClient new] getLocationsFrom:location withSearchTerm:@"" success:^(NSArray *locations) {
        if (locations.count > 0) {
            
            NSArray *allValidLocations = [locations arrayByAddingObjectsFromArray:[Location findAllWithPredicate:[NSPredicate predicateWithFormat:@"isCustomUserLocation = YES"]]];
            
            allValidLocations = [allValidLocations sortedArrayUsingComparator:^NSComparisonResult(Location * _Nonnull obj1, Location * _Nonnull obj2) {
                
                
                CGFloat d1 = [location distanceFromLocation:[[CLLocation alloc] initWithLatitude:obj1.latitude longitude:obj1.longitude]];
                CGFloat d2 = [location distanceFromLocation:[[CLLocation alloc] initWithLatitude:obj2.latitude longitude:obj2.longitude]];
                
                return d1 > d2;
            }];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                Location *suggestedLocation = allValidLocations[0];
                self.locationTextField.text = suggestedLocation.name;
                self.beerLog.location = suggestedLocation;
                self.locations = allValidLocations;
            });
        }
        else {
            NSLog(@"Error: No locations found");
            dispatch_async(dispatch_get_main_queue(), ^{
                self.locationTextField.text = @"No locations found";
            });
        }
    } failure:^(NSError *error) {
        NSLog(@"Error: %@", error.localizedDescription);
        NSLog(@"Details: %@", error.userInfo);
        dispatch_async(dispatch_get_main_queue(), ^{
            self.locationTextField.text = @"Error fetching locations";
        });
    }];
}

#pragma mark - Table View delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return self.view.bounds.size.width;
    }
    
    return [super tableView:tableView heightForRowAtIndexPath:indexPath];
}

#pragma mark - Text Field delegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == self.beerTextField || textField == self.breweryTextField) {
        dispatch_time_t t = dispatch_time(DISPATCH_TIME_NOW, 0.1 * NSEC_PER_SEC);
        dispatch_after(t, dispatch_get_main_queue(), ^{
            [self updateBeerSuggestionsFromTextField:textField];
        });
    }
    
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == self.locationTextField) {
        [self performSegueWithIdentifier:@"setLocation" sender:nil];
        return NO;
    }
    
    // Scroll to show both Beer & Brewery cells (after 0.1s delay)
    dispatch_time_t t = dispatch_time(DISPATCH_TIME_NOW, 0.1 * NSEC_PER_SEC);
    dispatch_after(t, dispatch_get_main_queue(), ^{
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:1] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    });
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.beerTextField) {
        [self.breweryTextField becomeFirstResponder];
    }
    
    if (textField == self.breweryTextField) {
        [textField resignFirstResponder];
    }
    
    
    return NO;
}

- (void)updateBeerSuggestionsFromTextField:(UITextField *)textField
{
    [self.suggestionView updateBeerSuggestionsWithText:textField.text];
}

#pragma mark - Set Location delegate

- (void)locationChangedTo:(Location *)location
{
    self.locationTextField.text = location.name;
    self.beerLog.location = location;
}

#pragma mark - Beer suggestion accessory delegate

- (void)beerSuggestionWasSelected:(Beer *)beer
{
    self.beerTextField.text = beer.name;
    self.breweryTextField.text = beer.brewery.name;
    
    [self.beerTextField resignFirstResponder];
}


#pragma mark - Location Manager delegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    CLLocation *location = locations[0];
    [self.locationManager stopUpdatingLocation];
    
    [self fetchLocationsFrom:location];
}



@end
