//
//  BeerLog+CoreDataClass.m
//  BeerDiary
//
//  Created by Stephen Lindauer on 8/11/17.
//  Copyright © 2017 Stephen Lindauer. All rights reserved.
//
//

#import "BeerLog+CoreDataClass.h"

@implementation BeerLog

- (UIImage * _Nullable)image
{
    if (self.imageData == nil) {
        return nil;
    }
    
    return [UIImage imageWithData:self.imageData];
}

- (void)setImage:(UIImage *)image
{
    self.imageData = UIImageJPEGRepresentation(image, 1);
}

@end
