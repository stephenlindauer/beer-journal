//
//  BDClient.h
//  BeerDiary
//
//  Created by Stephen Lindauer on 8/14/17.
//  Copyright © 2017 Stephen Lindauer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>


@class Beer, BeerLog;


@interface BDClient : NSObject


+ (void)uploadImage:(UIImage *)image progress:(void (^)(CGFloat progress))progress success:(void (^)(NSString *url))success failure:(void (^)(NSError *error))failure;

+ (void)postBeer:(Beer *)beer success:(void (^)(void))success failure:(void (^)(NSError *error))failure;
+ (void)postBrewery:(Brewery *)brewery success:(void (^)(void))success failure:(void (^)(NSError *error))failure;


@end
