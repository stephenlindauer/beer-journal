//
//  Beer+CoreDataProperties.h
//  BeerDiary
//
//  Created by Stephen Lindauer on 8/11/17.
//  Copyright © 2017 Stephen Lindauer. All rights reserved.
//
//

#import "Beer+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Beer (CoreDataProperties)

+ (NSFetchRequest<Beer *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;
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
