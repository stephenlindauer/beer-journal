//
//  Brewery+CoreDataProperties.h
//  
//
//  Created by Stephen Lindauer on 9/6/17.
//
//

#import "Brewery+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Brewery (CoreDataProperties)

+ (NSFetchRequest<Brewery *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;
@property (nonatomic) int32_t breweryID;
@property (nullable, nonatomic, retain) NSSet<Beer *> *beers;

@end

@interface Brewery (CoreDataGeneratedAccessors)

- (void)addBeersObject:(Beer *)value;
- (void)removeBeersObject:(Beer *)value;
- (void)addBeers:(NSSet<Beer *> *)values;
- (void)removeBeers:(NSSet<Beer *> *)values;

@end

NS_ASSUME_NONNULL_END
