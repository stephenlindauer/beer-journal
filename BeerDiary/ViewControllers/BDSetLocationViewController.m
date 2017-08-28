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
#import "BDLocationClient.h"


@interface BDSetLocationViewController () <UISearchBarDelegate, CLLocationManagerDelegate>

@property (nonatomic, strong) NSArray <Location *> *filteredLocations;
@property (nonatomic, strong) NSTimer *searchDelayTimer;

@end

@implementation BDSetLocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.filteredLocations = self.locations;
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
        location.latitude = self.startingLocation.coordinate.latitude;
        location.longitude = self.startingLocation.coordinate.longitude;
        location.isCustomUserLocation = YES;
        
        [self.delegate locationChangedTo:location];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Search bar delegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    // Clear any pending searches
    if (self.searchDelayTimer != nil) {
        [self.searchDelayTimer invalidate];
        self.searchDelayTimer = nil;
    }
    
    if (searchText.length == 0) {
        self.filteredLocations = self.locations;
    }
    else {
        self.filteredLocations = [self.locations filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"name CONTAINS[cd] %@", searchText]];
        
        
        self.searchDelayTimer = [NSTimer scheduledTimerWithTimeInterval:0.4 repeats:NO block:^(NSTimer * _Nonnull timer) {
            [self searchLocations];
        }];
    }
    
    [self.tableView reloadData];
}

- (void)searchLocations
{
    [[BDLocationClient new] getLocationsFrom:self.startingLocation withSearchTerm:self.searchBar.text success:^(NSArray<Location *> *locations) {
        
        if (locations.count > 0) {
            
            NSArray *allValidLocations = [locations arrayByAddingObjectsFromArray:[Location findAllWithPredicate:[NSPredicate predicateWithFormat:@"isCustomUserLocation = YES"]]];
            
            allValidLocations = [allValidLocations sortedArrayUsingComparator:^NSComparisonResult(Location * _Nonnull obj1, Location * _Nonnull obj2) {
                
                
                CGFloat d1 = [self.startingLocation distanceFromLocation:[[CLLocation alloc] initWithLatitude:obj1.latitude longitude:obj1.longitude]];
                CGFloat d2 = [self.startingLocation distanceFromLocation:[[CLLocation alloc] initWithLatitude:obj2.latitude longitude:obj2.longitude]];
                
                return d1 > d2;
            }];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                self.locations = allValidLocations;
            });
        }
        else {
            NSLog(@"Info: No locations found");
        }
        
    } failure:^(NSError *error) {
        NSLog(@"Error: %@", error.localizedDescription);
        NSLog(@"Details: %@", error.userInfo);
    }];
}

@end
