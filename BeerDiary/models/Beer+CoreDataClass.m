//
//  Beer+CoreDataClass.m
//  BeerDiary
//
//  Created by Stephen Lindauer on 8/11/17.
//  Copyright © 2017 Stephen Lindauer. All rights reserved.
//
//

#import "Beer+CoreDataClass.h"

@implementation Beer

- (NSDictionary *)toDictionary
{
    return @{
             @"name": self.name,
//             @"brewery": self.brewery,
             @"user_create_by": @1
             };
}

@end
