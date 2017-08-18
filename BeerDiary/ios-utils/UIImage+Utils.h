//
//  UIImage+Utils.h
//  BeerDiary
//
//  Created by Stephen Lindauer on 8/17/17.
//  Copyright © 2017 Stephen Lindauer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Utils)

- (UIImage *)crop:(CGRect)rect;
- (UIImage *)cropCenter;
- (UIImage *)resize:(CGSize)size;

@end
