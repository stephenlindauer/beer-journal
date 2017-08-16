//
//  Beer+CoreDataProperties.m
//  BeerDiary
//
//  Created by Stephen Lindauer on 8/11/17.
//  Copyright © 2017 Stephen Lindauer. All rights reserved.
//
//

#import "Beer+CoreDataProperties.h"

@implementation Beer (CoreDataProperties)

+ (NSFetchRequest<Beer *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Beer"];
}

@dynamic name;
@dynamic brewery;
@dynamic logs;

@end
