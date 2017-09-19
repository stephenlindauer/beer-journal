//
//  BeerLog+CoreDataProperties.h
//  
//
//  Created by Stephen Lindauer on 9/6/17.
//
//

#import "BeerLog+CoreDataClass.h"



NS_ASSUME_NONNULL_BEGIN

@interface BeerLog (CoreDataProperties)

+ (NSFetchRequest<BeerLog *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSDate *date;
@property (nullable, nonatomic, retain) NSData *imageData;
@property (nonatomic) float locationLatitude;
@property (nonatomic) float locationLongitude;
@property (nonatomic) int16_t rating;
@property (nonatomic) int32_t beerLogID;
@property (nullable, nonatomic, retain) Beer *beer;
@property (nullable, nonatomic, retain) Location *location;

@end

NS_ASSUME_NONNULL_END
