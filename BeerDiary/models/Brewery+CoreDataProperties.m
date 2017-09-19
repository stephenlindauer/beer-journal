//
//  Brewery+CoreDataProperties.m
//  
//
//  Created by Stephen Lindauer on 9/6/17.
//
//

#import "Brewery+CoreDataProperties.h"

@implementation Brewery (CoreDataProperties)

+ (NSFetchRequest<Brewery *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Brewery"];
}

@dynamic name;
@dynamic breweryID;
@dynamic beers;

@end
