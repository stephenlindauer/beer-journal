//
//  BDSuggestedBeersLayout.m
//  BeerDiary
//
//  Created by Stephen Lindauer on 8/16/17.
//  Copyright © 2017 Stephen Lindauer. All rights reserved.
//

#import "BDSuggestedBeersLayout.h"

@implementation BDSuggestedBeersLayout

- (id)init
{
    self = [super init];
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.estimatedItemSize = CGSizeMake(150, 40);
    return self;
}



- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

@end
