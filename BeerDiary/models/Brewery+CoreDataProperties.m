//
//  Brewery+CoreDataProperties.m
//  BeerDiary
//
//  Created by Stephen Lindauer on 8/11/17.
//  Copyright © 2017 Stephen Lindauer. All rights reserved.
//
//

#import "Brewery+CoreDataProperties.h"

@implementation Brewery (CoreDataProperties)

+ (NSFetchRequest<Brewery *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Brewery"];
}

@dynamic name;
@dynamic beers;

@end
