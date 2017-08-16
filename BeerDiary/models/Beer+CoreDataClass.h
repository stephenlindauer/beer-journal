//
//  Beer+CoreDataClass.h
//  BeerDiary
//
//  Created by Stephen Lindauer on 8/11/17.
//  Copyright © 2017 Stephen Lindauer. All rights reserved.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class BeerLog, Brewery;

NS_ASSUME_NONNULL_BEGIN

@interface Beer : NSManagedObject

@end

NS_ASSUME_NONNULL_END

#import "Beer+CoreDataProperties.h"
