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



@interface BDAddBeerLogViewController () <CLLocationManagerDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITextFieldDelegate, BDSetLocationDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) Location *suggestedLocation;
@property (nonatomic, strong) UICollectionView *suggestionsCollectionsView;
@property (nonatomic, strong) NSArray <Beer *> *beers;
@property (nonatomic, strong) NSArray <Location *> *locations;


@end

@implementation BDAddBeerLogViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Setup location manager
    self.locationManager = [CLLocationManager new];
    self.locationManager.delegate = self;
    [self.locationManager requestAlwaysAuthorization];
    [self.locationManager startUpdatingLocation];
    
    // Setup auto suggest beers
    BDSuggestedBeersLayout *layout = [BDSuggestedBeersLayout new];
    
    self.suggestionsCollectionsView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 54) collectionViewLayout:layout];
    self.suggestionsCollectionsView.delegate = self;
    self.suggestionsCollectionsView.dataSource = self;
    self.suggestionsCollectionsView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    [self.suggestionsCollectionsView registerClass:[BDBeerSuggestionCell class] forCellWithReuseIdentifier:@"BeerSuggestionCell"];
    self.beerTextField.inputAccessoryView = self.suggestionsCollectionsView;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleDone target:self action:@selector(saveBeerLog)];
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
    log.date = [NSDate date];
    [log saveManagedObjectContext];
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)changeLocation:(id)sender {
    
}

- (IBAction)changeDate:(id)sender {
    
}

- (IBAction)roundSliderToValue:(id)sender {
    NSLog(@"roundSliderToValue");
    self.ratingSlider.value = (int)(self.ratingSlider.value + 0.5);
}

- (void)fetchLocationsFrom:(CLLocation *)location
{
    [[BDLocationClient new] getLocationsFrom:location success:^(NSArray *locations) {
        if (locations.count > 0) {
            dispatch_async(dispatch_get_main_queue(), ^{
                Location *suggestedLocation = locations[0];
                self.locationLabel.text = suggestedLocation.name;
                self.suggestedLocation = suggestedLocation;
                self.locations = locations;
            });
        }
        else {
            self.locationLabel.text = @"No locations found";
        }
    } failure:^(NSError *error) {
        self.locationLabel.text = @"Error fetching locations";
    }];
}

#pragma mark - Collection view

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.beers.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BDBeerSuggestionCell *cell = (BDBeerSuggestionCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"BeerSuggestionCell" forIndexPath:indexPath];

    cell.beer = self.beers[indexPath.row];
    NSLog(@"cell: %@", cell);
    cell.hidden = NO;
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // TODO: Dynamic text size
    return CGSizeMake(160, 54);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    Beer *beer = self.beers[indexPath.row];
    
    self.beerTextField.text = beer.name;
    self.breweryTextField.text = beer.brewery.name;
    
    [self.beerTextField resignFirstResponder];
}



#pragma mark - Location Manager delegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    NSLog(@"Got location: %@", locations[0]);
    CLLocation *location = locations[0];
    [self.locationManager stopUpdatingLocation];
    
    [self fetchLocationsFrom:location];
}

#pragma mark - Suggestions

- (void)updateBeerSuggestions
{
    self.beers = [Beer findAllWithPredicate:[NSPredicate predicateWithFormat:@"name CONTAINS[cd] %@", self.beerTextField.text]];
    [self.suggestionsCollectionsView reloadSections:[NSIndexSet indexSetWithIndex:0]];
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

#pragma mark - Set Location delegate

- (void)locationChangedTo:(Location *)location
{
    self.locationLabel.text = location.name;
    self.suggestedLocation = location;
}

@end
