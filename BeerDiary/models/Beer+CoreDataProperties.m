//
//  Beer+CoreDataProperties.m
//  
//
//  Created by Stephen Lindauer on 9/6/17.
//
//

#import "Beer+CoreDataProperties.h"

@implementation Beer (CoreDataProperties)

+ (NSFetchRequest<Beer *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Beer"];
}

@dynamic name;
@dynamic beerID;
@dynamic brewery;
@dynamic logs;

@end
