//
//  BeerLog+CoreDataProperties.m
//  BeerDiary
//
//  Created by Stephen Lindauer on 8/17/17.
//  Copyright © 2017 Stephen Lindauer. All rights reserved.
//
//

#import "BeerLog+CoreDataProperties.h"

@implementation BeerLog (CoreDataProperties)

+ (NSFetchRequest<BeerLog *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"BeerLog"];
}

@dynamic date;
@dynamic locationLatitude;
@dynamic locationLongitude;
@dynamic rating;
@dynamic imageData;
@dynamic beer;
@dynamic location;

@end
