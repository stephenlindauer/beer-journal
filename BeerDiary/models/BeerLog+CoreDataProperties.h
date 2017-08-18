//
//  BeerLog+CoreDataProperties.h
//  BeerDiary
//
//  Created by Stephen Lindauer on 8/17/17.
//  Copyright © 2017 Stephen Lindauer. All rights reserved.
//
//

#import "BeerLog+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@class Beer, Location;

@interface BeerLog (CoreDataProperties)

+ (NSFetchRequest<BeerLog *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSDate *date;
@property (nonatomic) float locationLatitude;
@property (nonatomic) float locationLongitude;
@property (nonatomic) int16_t rating;
@property (nullable, nonatomic, retain) NSData *imageData;
@property (nullable, nonatomic, retain) Beer *beer;
@property (nullable, nonatomic, retain) Location *location;

@end

NS_ASSUME_NONNULL_END
