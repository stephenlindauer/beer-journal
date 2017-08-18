//
//  UIImage+Utils.m
//  BeerDiary
//
//  Created by Stephen Lindauer on 8/17/17.
//  Copyright © 2017 Stephen Lindauer. All rights reserved.
//

#import "UIImage+Utils.h"

@implementation UIImage (Utils)

- (UIImage *)crop:(CGRect)rect
{
    if (self.scale > 1.0f) {
        rect = CGRectMake(rect.origin.x * self.scale,
                          rect.origin.y * self.scale,
                          rect.size.width * self.scale,
                          rect.size.height * self.scale);
    }
    
    CGImageRef imageRef = CGImageCreateWithImageInRect(self.CGImage, rect);
    UIImage *result = [UIImage imageWithCGImage:imageRef scale:self.scale orientation:self.imageOrientation];
    CGImageRelease(imageRef);
    return result;
}

- (UIImage *)cropCenter
{
    CGFloat smallerEdge = MIN(self.size.width, self.size.height);
    if (self.size.width > self.size.height) {
        return [self crop:CGRectMake((self.size.width - smallerEdge)/2, 0, smallerEdge, smallerEdge)];
    }
    else {
        return [self crop:CGRectMake((self.size.height - smallerEdge)/2, 0, smallerEdge, smallerEdge)];
    }
}

- (UIImage *)resize:(CGSize)size
{
    CGRect rect = CGRectMake(0,0,size.width,size.height);
    UIGraphicsBeginImageContext( size );
    [self drawInRect:rect];
    UIImage *resizedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resizedImage;
//    
//    NSData *imageData = UIImageJPEGRepresentation(resizedImage, 1);
//    return [UIImage imageWithData:imageData];
}



@end
