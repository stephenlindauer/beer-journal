//
//  BeerLog+CoreDataProperties.m
//  
//
//  Created by Stephen Lindauer on 9/6/17.
//
//

#import "BeerLog+CoreDataProperties.h"

@implementation BeerLog (CoreDataProperties)

+ (NSFetchRequest<BeerLog *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"BeerLog"];
}

@dynamic date;
@dynamic imageData;
@dynamic locationLatitude;
@dynamic locationLongitude;
@dynamic rating;
@dynamic beerLogID;
@dynamic beer;
@dynamic location;

@end
