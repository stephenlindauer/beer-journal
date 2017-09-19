//
//  Brewery+CoreDataClass.m
//  BeerDiary
//
//  Created by Stephen Lindauer on 8/11/17.
//  Copyright © 2017 Stephen Lindauer. All rights reserved.
//
//

#import "Brewery+CoreDataClass.h"

@implementation Brewery

- (NSDictionary *)toDictionary
{
    return @{
             @"name":self.name,
             @"user_created_by":@1
             };
}

@end
