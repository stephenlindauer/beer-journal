//
//  BDClient.m
//  BeerDiary
//
//  Created by Stephen Lindauer on 8/14/17.
//  Copyright © 2017 Stephen Lindauer. All rights reserved.
//

#import "BDClient.h"
#import "SDLEnvironment.h"
#import "Beer+CoreDataClass.h"
#import "Brewery+CoreDataClass.h"


#define ERROR_STRING [[NSString alloc] initWithData:error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding]


@implementation BDClient



NSString * const kClientSecret = @"Q9UxlhFqGLiwLCWZS23pjb9OQmVBdTLYFVNwDU3qgCVbAUkQo4bbFj9zCUF1EQ2BIGXgMzFtvlLbQy9vXem8Ys5qNz9YgODDG02ObGeve5ELf3Lktm9qNKYDOpaR5E5f";
NSString * const kRestaurantsLastUpdatedDate = @"RestaurantsLastUpdatedDate";


+ (NSString *)urlWithPath:(NSString *)path
{
    return [NSString stringWithFormat:@"%@/api/%@", [SDLEnvironment baseUrl], path];
}

+ (AFHTTPSessionManager *)sessionManager
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
//
//    if (token) {
//        NSString *tokenString = [NSString stringWithFormat:@"Bearer %@", token.accessToken];
//        [manager.requestSerializer setValue:tokenString forHTTPHeaderField:@"Authorization"];
//    }
    
    return manager;
}

+ (void)uploadImage:(UIImage *)image progress:(void (^)(CGFloat))progress success:(void (^)(NSString *url))success failure:(void (^)(NSError *))failure
{
    AFHTTPSessionManager *manager = [self sessionManager];
    NSString *url = [self urlWithPath:@"1.0/beerlog/images"];
    
    NSMutableURLRequest *request = [manager.requestSerializer multipartFormRequestWithMethod:@"POST" URLString:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
        [formData appendPartWithFileData:imageData name:@"image" fileName:@"image.jpg" mimeType:@"image/jpeg"];
    } error:nil];
    
    NSURLSessionUploadTask *uploadTask;
    uploadTask = [manager
                  uploadTaskWithStreamedRequest:request
                  progress:^(NSProgress * _Nonnull uploadProgress) {
                      NSLog(@"Progress: %f", uploadProgress.fractionCompleted);
                      
                      // This is not called back on the main queue.
                      // You are responsible for dispatching to the main queue for UI updates
                      dispatch_async(dispatch_get_main_queue(), ^{
                          progress(uploadProgress.fractionCompleted);
                      });
                  }
                  completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                      if (error) {
                          NSLog(@"ERROR: %@", ERROR_STRING);
                          failure(error);
                      } else {
                          NSLog(@"%@ %@", response, responseObject);
                          
                          
                          success(responseObject[@"url"]);
                      }
                  }];
    
    [uploadTask resume];
}

+ (void)postBeer:(Beer *)beer success:(void (^)(void))success failure:(void (^)(NSError *error))failure
{
    AFHTTPSessionManager *manager = [self sessionManager];
    NSString *url = [self urlWithPath:@"1.0/beers"];
    
    NSDictionary *params = [beer toDictionary];
    
    [manager POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        beer.beerID = (int)[responseObject[@"id"] integerValue];
        
        success();
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

+ (void)postBrewery:(Brewery *)brewery success:(void (^)(void))success failure:(void (^)(NSError *error))failure
{
    AFHTTPSessionManager *manager = [self sessionManager];
    NSString *url = [self urlWithPath:@"1.0/brewery"];
    
    NSDictionary *params = [brewery toDictionary];
    
    [manager POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        brewery.breweryID = (int)[responseObject[@"id"] integerValue];
        
        success();
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}











@end
