//
//  Brewery+CoreDataProperties.h
//  BeerDiary
//
//  Created by Stephen Lindauer on 8/11/17.
//  Copyright © 2017 Stephen Lindauer. All rights reserved.
//
//

#import "Brewery+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Brewery (CoreDataProperties)

+ (NSFetchRequest<Brewery *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, retain) NSSet<Beer *> *beers;

@end

@interface Brewery (CoreDataGeneratedAccessors)

- (void)addBeersObject:(Beer *)value;
- (void)removeBeersObject:(Beer *)value;
- (void)addBeers:(NSSet<Beer *> *)values;
- (void)removeBeers:(NSSet<Beer *> *)values;

@end

NS_ASSUME_NONNULL_END
