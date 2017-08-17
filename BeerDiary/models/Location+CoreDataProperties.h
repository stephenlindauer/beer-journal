//
//  Location+CoreDataProperties.h
//  BeerDiary
//
//  Created by Stephen Lindauer on 8/16/17.
//  Copyright © 2017 Stephen Lindauer. All rights reserved.
//
//

#import "Location+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Location (CoreDataProperties)

+ (NSFetchRequest<Location *> *)fetchRequest;

@property (nonatomic) float latitude;
@property (nonatomic) float longitude;
@property (nullable, nonatomic, copy) NSString *name;
@property (nonatomic) BOOL isCustomUserLocation;
@property (nullable, nonatomic, retain) NSSet<BeerLog *> *beers;

@end

@interface Location (CoreDataGeneratedAccessors)

- (void)addBeersObject:(BeerLog *)value;
- (void)removeBeersObject:(BeerLog *)value;
- (void)addBeers:(NSSet<BeerLog *> *)values;
- (void)removeBeers:(NSSet<BeerLog *> *)values;

@end

NS_ASSUME_NONNULL_END
