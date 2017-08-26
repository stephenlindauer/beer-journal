//
//  BDPhotoFetcher.m
//  BeerDiary
//
//  Created by Stephen Lindauer on 8/25/17.
//  Copyright © 2017 Stephen Lindauer. All rights reserved.
//

@import Photos;

#import "BDPhotoFetcher.h"

@interface BDPhotoFetcher ()

@property (nonatomic, strong) PHImageManager *imageManager;
@property (nonatomic, strong) PHImageRequestOptions *requestOptions;
@property (nonatomic, strong) PHFetchOptions *fetchOptions;
@property (nonatomic, strong) PHFetchResult *fetchResult;

@end

@implementation BDPhotoFetcher


- (id)init
{
    self = [super init];
    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
    
    self.imageManager = [PHImageManager defaultManager];
    self.requestOptions = [PHImageRequestOptions new];
    self.requestOptions.synchronous = YES;
    
    self.fetchOptions = [PHFetchOptions new];
    self.fetchOptions.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO]];
    
    self.fetchResult = [PHAsset fetchAssetsWithMediaType:PHAssetMediaTypeImage options:self.fetchOptions];
    
    self.count = self.fetchResult.count;
    
//    });
    
    return self;
}

- (void)fetchThumbnailImageAtIndex:(NSInteger)index success:(void (^)(UIImage *image))success
{
    CGSize size = CGSizeMake(200, 200);

    [self.imageManager requestImageForAsset:[self.fetchResult objectAtIndex:index] targetSize:size contentMode:PHImageContentModeAspectFill options:self.requestOptions resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        
        success(result);
    }];
}

- (void)fetchFullsizeImageAndDetailsAtIndex:(NSInteger)index success:(void (^)(UIImage *image, PHAsset *asset))success
{
    CGSize size = CGSizeMake(1200, 1200);
    
    [self.imageManager requestImageForAsset:[self.fetchResult objectAtIndex:index] targetSize:size contentMode:PHImageContentModeAspectFill options:self.requestOptions resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        
        success(result, [self.fetchResult objectAtIndex:index]);
    }];
}

@end
