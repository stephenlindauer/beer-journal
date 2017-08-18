//
//  BeerLog+CoreDataClass.h
//  BeerDiary
//
//  Created by Stephen Lindauer on 8/11/17.
//  Copyright © 2017 Stephen Lindauer. All rights reserved.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <UIKit/UIKit.h>


@class Beer;

NS_ASSUME_NONNULL_BEGIN

@interface BeerLog : NSManagedObject

- ( UIImage * _Nullable )image;
- (void)setImage:(UIImage *)image;


@end

NS_ASSUME_NONNULL_END

#import "BeerLog+CoreDataProperties.h"
