//
//  Location+CoreDataClass.h
//  BeerDiary
//
//  Created by Stephen Lindauer on 8/14/17.
//  Copyright © 2017 Stephen Lindauer. All rights reserved.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class BeerLog;

NS_ASSUME_NONNULL_BEGIN

@interface Location : NSManagedObject

+ (Location *)locationFromDictionary:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END

#import "Location+CoreDataProperties.h"
