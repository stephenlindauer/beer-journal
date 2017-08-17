//
//  BDBeerSuggestionAccessoryView.m
//  BeerDiary
//
//  Created by Stephen Lindauer on 8/17/17.
//  Copyright © 2017 Stephen Lindauer. All rights reserved.
//

#import "BDBeerSuggestionAccessoryView.h"
#import "BDSuggestedBeersLayout.h"
#import "BDBeerSuggestionCell.h"
#import "Beer+CoreDataClass.h"
#import "Brewery+CoreDataClass.h"
#import "BeerLog+CoreDataClass.h"
#import "NSManagedObject+CoreData.h"


@interface BDBeerSuggestionAccessoryView () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray <Beer *> *beers;
@end

@implementation BDBeerSuggestionAccessoryView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    BDSuggestedBeersLayout *layout = [BDSuggestedBeersLayout new];
    self.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 4, frame.size.width, frame.size.height-8) collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.contentInset = UIEdgeInsetsMake(0, 5, 0, 5);
    [self.collectionView registerClass:[BDBeerSuggestionCell class] forCellWithReuseIdentifier:@"BeerSuggestionCell"];
    
    [self addSubview:self.collectionView];

    [self showRecentlyUsedBeers];
    
    return self;
}

- (void)showRecentlyUsedBeers
{
    NSArray <BeerLog *> *recentLogs = [BeerLog findAllSortedBy:@"date" ascending:NO];
    NSMutableArray *beers = [[NSMutableArray alloc] initWithCapacity:10];
    for (int i=0; i<MIN(10, recentLogs.count); i++) {
        if (![beers containsObject:recentLogs[i].beer]) {
            [beers addObject:recentLogs[i].beer];
        }
    }
    self.beers = beers;
}

- (void)updateBeerSuggestionsWithText:(NSString *)search
{
    // No search string, show recently used
    if (search.length == 0) {
        [self showRecentlyUsedBeers];
    }
    // Search
    else {
        self.beers = [Beer findAllWithPredicate:[NSPredicate predicateWithFormat:@"name CONTAINS[cd] %@", search]];
    }
    
   [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:0]];
}


#pragma mark - Collection view

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.beers.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BDBeerSuggestionCell *cell = (BDBeerSuggestionCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"BeerSuggestionCell" forIndexPath:indexPath];
    
    cell.beer = self.beers[indexPath.row];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // TODO: Dynamic text size
    Beer *beer = self.beers[indexPath.row];
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:16]};
    CGRect beerSize = [beer.name boundingRectWithSize:CGSizeMake(400, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
    attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:12]};
    CGRect brewerySize = [beer.brewery.name boundingRectWithSize:CGSizeMake(400, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
    
    
    return CGSizeMake(MAX(beerSize.size.width, brewerySize.size.width) + 10, self.collectionView.frame.size.height);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    // Call delegate method
    [self.delegate beerSuggestionWasSelected:self.beers[indexPath.row]];
}


@end
