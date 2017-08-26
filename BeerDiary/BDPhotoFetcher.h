//
//  BDPhotoFetcher.h
//  BeerDiary
//
//  Created by Stephen Lindauer on 8/25/17.
//  Copyright © 2017 Stephen Lindauer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BDPhotoFetcher : NSObject

@property (nonatomic, assign) NSInteger count;

- (void)fetchThumbnailImageAtIndex:(NSInteger)index success:(void (^)(UIImage *image))success;

- (void)fetchFullsizeImageAndDetailsAtIndex:(NSInteger)index success:(void (^)(UIImage *image, PHAsset *asset))success;

@end
