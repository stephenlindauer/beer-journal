//
//  BDSetLocationViewController.m
//  BeerDiary
//
//  Created by Stephen Lindauer on 8/16/17.
//  Copyright © 2017 Stephen Lindauer. All rights reserved.
//

#import "BDSetLocationViewController.h"
#import "BDLocationCell.h"
#import "BDGenericTextCell.h"
#import <CoreLocation/CoreLocation.h>
#import "NSManagedObject+CoreData.h"
#import "Location+CoreDataClass.h"


@interface BDSetLocationViewController () <UISearchBarDelegate, CLLocationManagerDelegate>

@property (nonatomic, strong) NSArray <Location *> *filteredLocations;
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) CLLocation *lastLocation;

@end

@implementation BDSetLocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.filteredLocations = self.locations;
    
    self.locationManager = [CLLocationManager new];
    self.locationManager.delegate = self;
    [self.locationManager startUpdatingLocation];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.locationManager stopUpdatingLocation];
    self.locationManager = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.filteredLocations.count;
    }
    else {
        return 1;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView locationCellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BDLocationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LocationCell" forIndexPath:indexPath];
    
    cell.location = self.filteredLocations[indexPath.row];
    
    return cell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView createLocationCellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BDGenericTextCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CreateLocationCell" forIndexPath:indexPath];
    
    cell.mainLabel.text = [NSString stringWithFormat:@"Create \"%@\"", self.searchBar.text];
    
    return cell;
}
                                                                                       

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        return [self tableView:tableView locationCellForRowAtIndexPath:indexPath];
    }
    else {
        return [self tableView:tableView createLocationCellForRowAtIndexPath:indexPath];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        [self.delegate locationChangedTo:self.filteredLocations[indexPath.row]];
    }
    else {
        Location *location = [Location createEntity];
        location.name = self.searchBar.text;
        location.latitude = self.lastLocation.coordinate.latitude;
        location.longitude = self.lastLocation.coordinate.longitude;
        
        [self.delegate locationChangedTo:location];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Search bar delegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (searchText.length == 0) {
        self.filteredLocations = self.locations;
    }
    else {
        self.filteredLocations = [self.locations filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"name CONTAINS[cd] %@", searchText]];
    }
    
    [self.tableView reloadData];
}

#pragma mark - Location manager

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    self.lastLocation = locations[0];
}

@end
