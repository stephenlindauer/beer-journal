//
//  Brewery+CoreDataClass.h
//  BeerDiary
//
//  Created by Stephen Lindauer on 8/11/17.
//  Copyright © 2017 Stephen Lindauer. All rights reserved.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Beer;

NS_ASSUME_NONNULL_BEGIN

@interface Brewery : NSManagedObject

- (NSDictionary *)toDictionary;

@end

NS_ASSUME_NONNULL_END

#import "Brewery+CoreDataProperties.h"
