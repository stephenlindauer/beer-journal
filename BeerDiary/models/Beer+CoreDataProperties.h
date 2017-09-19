//
//  Beer+CoreDataProperties.h
//  
//
//  Created by Stephen Lindauer on 9/6/17.
//
//

#import "Beer+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Beer (CoreDataProperties)

+ (NSFetchRequest<Beer *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;
@property (nonatomic) int32_t beerID;
@property (nullable, nonatomic, retain) Brewery *brewery;
@property (nullable, nonatomic, retain) NSSet<BeerLog *> *logs;

@end

@interface Beer (CoreDataGeneratedAccessors)

- (void)addLogsObject:(BeerLog *)value;
- (void)removeLogsObject:(BeerLog *)value;
- (void)addLogs:(NSSet<BeerLog *> *)values;
- (void)removeLogs:(NSSet<BeerLog *> *)values;

@end

NS_ASSUME_NONNULL_END
