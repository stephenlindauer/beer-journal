//
//  BDAddBeerLogViewController.m
//  BeerDiary
//
//  Created by Stephen Lindauer on 8/11/17.
//  Copyright © 2017 Stephen Lindauer. All rights reserved.
//

#import "BDAddBeerLogViewController.h"
//#import "LUAutocompleteView.h"
#import "BeerDiary-Swift.h"
#import "BDLocationClient.h"
#import <CoreLocation/CoreLocation.h>
#import "Location+CoreDataClass.h"
#import "Beer+CoreDataClass.h"
#import "Brewery+CoreDataClass.h"
#import "BeerLog+CoreDataClass.h"
#import "NSManagedObject+CoreData.h"
#import "NSManagedObjectContext+Utils.h"
#import "FrameUtils.h"
#import "BDBeerSuggestionCell.h"
#import "BDSuggestedBeersLayout.h"
#import "NSManagedObjectContext+Utils.h"
#import "BDSetLocationViewController.h"
#import "NSDate+Helper.h"
#import "BDBeerSuggestionAccessoryView.h"


@interface BDAddBeerLogViewController () <CLLocationManagerDelegate, UICollectionViewDelegateFlowLayout, UITextFieldDelegate, BDSetLocationDelegate, UIPickerViewDelegate, BDBeerSuggestionDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) Location *suggestedLocation;
@property (nonatomic, strong) BDBeerSuggestionAccessoryView *suggestionView;
@property (nonatomic, strong) NSArray <Location *> *locations;
@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, strong) NSDate *date;


@end

@implementation BDAddBeerLogViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Setup location manager
    self.locationManager = [CLLocationManager new];
    self.locationManager.delegate = self;
    [self.locationManager requestAlwaysAuthorization];
    [self.locationManager startUpdatingLocation];
    
    self.suggestionView = [[BDBeerSuggestionAccessoryView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 54)];
    self.suggestionView.delegate = self;
    self.beerTextField.inputAccessoryView = self.suggestionView;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleDone target:self action:@selector(saveBeerLog)];
    
    self.datePicker = [UIDatePicker new];
    self.datePicker.datePickerMode = UIDatePickerModeDateAndTime;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"setLocation"]) {
        BDSetLocationViewController *setLocationViewController = segue.destinationViewController;
        setLocationViewController.locations = self.locations;
        setLocationViewController.delegate = self;
    }
}


- (void)saveBeerLog
{
    BeerLog *log = [BeerLog createEntity];
    
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
    
    log.beer = beer;
    log.location = self.suggestedLocation;
    log.date = self.date ?: [NSDate date];
    log.rating = self.ratingSlider.value;
    [log saveManagedObjectContext];
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)changeDate:(id)sender {
    // Show date picker
    if (self.cancelDateButton.hidden) {
        [self.view endEditing:YES];
        
        [self.view addSubview:self.datePicker];
        self.datePicker.frame = CGRectMake(0, self.view.bounds.size.height - 216, self.view.bounds.size.width, 216.0);
        
        [self.changeDateButton setTitle:@"Set" forState:UIControlStateNormal];
        self.cancelDateButton.hidden = NO;
    }
    // Set date and hide picker
    else {
        self.date = self.datePicker.date;
        [self cancelSetDate:nil];
        self.dateLabel.text = [self.date stringWithFormat:@"MMM d, yyyy h:mm a"];
    }
}

- (IBAction)cancelSetDate:(id)sender {
    [self.changeDateButton setTitle:@"Change" forState:UIControlStateNormal];
    self.cancelDateButton.hidden = YES;
    
    [self.datePicker setDate:self.date];
    
    [self.datePicker removeFromSuperview];
}

- (IBAction)roundSliderToValue:(id)sender {
    self.ratingSlider.value = (int)(self.ratingSlider.value + 0.5);
}

- (void)fetchLocationsFrom:(CLLocation *)location
{
    [[BDLocationClient new] getLocationsFrom:location success:^(NSArray *locations) {
        if (locations.count > 0) {
            
            NSArray *allValidLocations = [locations arrayByAddingObjectsFromArray:[Location findAllWithPredicate:[NSPredicate predicateWithFormat:@"isCustomUserLocation = YES"]]];
            
            allValidLocations = [allValidLocations sortedArrayUsingComparator:^NSComparisonResult(Location * _Nonnull obj1, Location * _Nonnull obj2) {
                
                
                CGFloat d1 = [self.locationManager.location distanceFromLocation:[[CLLocation alloc] initWithLatitude:obj1.latitude longitude:obj1.longitude]];
                CGFloat d2 = [self.locationManager.location distanceFromLocation:[[CLLocation alloc] initWithLatitude:obj2.latitude longitude:obj2.longitude]];
                
                return d1 > d2;
            }];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                Location *suggestedLocation = allValidLocations[0];
                self.locationLabel.text = suggestedLocation.name;
                self.suggestedLocation = suggestedLocation;
                self.locations = allValidLocations;
            });
        }
        else {
            NSLog(@"Error: No locations found");
            dispatch_async(dispatch_get_main_queue(), ^{
                self.locationLabel.text = @"No locations found";
            });
        }
    } failure:^(NSError *error) {
        NSLog(@"Error: %@", error.localizedDescription);
        NSLog(@"Details: %@", error.userInfo);
        dispatch_async(dispatch_get_main_queue(), ^{
            self.locationLabel.text = @"Error fetching locations";
        });
    }];
}




#pragma mark - Location Manager delegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    NSLog(@"Got location: %@", locations[0]);
    CLLocation *location = locations[0];
    [self.locationManager stopUpdatingLocation];
    
    [self fetchLocationsFrom:location];
}



#pragma mark - Text Field delegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    dispatch_time_t t = dispatch_time(DISPATCH_TIME_NOW, 0.1 * NSEC_PER_SEC);
    dispatch_after(t, dispatch_get_main_queue(), ^{
        [self updateBeerSuggestions];
    });
    
    return YES;
}

- (void)updateBeerSuggestions
{
    [self.suggestionView updateBeerSuggestionsWithText:self.beerTextField.text];
}

#pragma mark - Set Location delegate

- (void)locationChangedTo:(Location *)location
{
    self.locationLabel.text = location.name;
    self.suggestedLocation = location;
}

#pragma mark - Beer suggestion accessory delegate

- (void)beerSuggestionWasSelected:(Beer *)beer
{
    self.beerTextField.text = beer.name;
    self.breweryTextField.text = beer.brewery.name;
    
    [self.beerTextField resignFirstResponder];
}

@end
