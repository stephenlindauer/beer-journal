//
//  Location+CoreDataProperties.m
//  
//
//  Created by Stephen Lindauer on 9/6/17.
//
//

#import "Location+CoreDataProperties.h"

@implementation Location (CoreDataProperties)

+ (NSFetchRequest<Location *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Location"];
}

@dynamic isCustomUserLocation;
@dynamic latitude;
@dynamic longitude;
@dynamic name;
@dynamic locationID;
@dynamic beers;

@end
