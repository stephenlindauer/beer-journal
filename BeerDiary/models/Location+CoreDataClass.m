//
//  Location+CoreDataClass.m
//  BeerDiary
//
//  Created by Stephen Lindauer on 8/14/17.
//  Copyright © 2017 Stephen Lindauer. All rights reserved.
//
//

#import "Location+CoreDataClass.h"
#import "NSManagedObject+CoreData.h"
#import "NSManagedObjectContext+Utils.h"

@implementation Location

+ (Location *)locationFromDictionary:(NSDictionary *)dict
{
    Location *location = [self createEntity];
    
    location.name = dict[@"name"];
    if (dict[@"coordinates"] && dict[@"coordinates"][@"latitude"] != [NSNull null]) {
        location.latitude = [dict[@"coordinates"][@"latitude"] floatValue];
        location.longitude = [dict[@"coordinates"][@"longitude"] floatValue];
    }
    
    return location;
}

@end
