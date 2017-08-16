//
//  BDLocationClient.h
//  BeerDiary
//
//  Created by Stephen Lindauer on 8/14/17.
//  Copyright © 2017 Stephen Lindauer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import <CoreLocation/CoreLocation.h>

@class Location;

@interface BDLocationClient : NSObject

- (void)getLocationsFrom:(CLLocation *)location success:(void (^)(NSArray <Location *>* locations))success failure:(void (^)(NSError *error))failure;

@end
