//
//  BDLocationClient.m
//  BeerDiary
//
//  Created by Stephen Lindauer on 8/14/17.
//  Copyright © 2017 Stephen Lindauer. All rights reserved.
//

#import "BDLocationClient.h"
#import "Location+CoreDataClass.h"

@implementation BDLocationClient


- (AFHTTPSessionManager *)sessionManager
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager.requestSerializer setValue:@"Bearer IJHzwPA0RanwSh7MDdURbLsU603lsyHRuICv7Pea1C0KKnrxhzw9z0r6eYBgGFhSWHtC3wtq7EwZ9gKdIenxs0CZ8nUwkTpLu8oTTofUH6PG-JnCAyeyXv-Z1P6RWXYx" forHTTPHeaderField:@"Authorization"];
    
    return manager;
}


- (void)getLocationsFrom:(CLLocation *)location success:(void (^)(NSArray <Location *> *locations))success failure:(void (^)(NSError *error))failure
{
    AFHTTPSessionManager *manager = [self sessionManager];
    
    NSString *url = [NSString stringWithFormat:@"https://api.yelp.com/v3/businesses/search?latitude=%f&longitude=%f", location.coordinate.latitude, location.coordinate.longitude];
    
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        
        NSMutableArray *locations = [NSMutableArray new];
        NSLog(@"response: %@", responseObject);
        for (NSDictionary *dict in responseObject[@"businesses"]) {
            [locations addObject:[Location locationFromDictionary:dict]];
        }
        success(locations);
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        failure(error);
    }];
}

@end
