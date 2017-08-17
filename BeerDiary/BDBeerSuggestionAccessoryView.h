//
//  BDBeerSuggestionAccessoryView.h
//  BeerDiary
//
//  Created by Stephen Lindauer on 8/17/17.
//  Copyright © 2017 Stephen Lindauer. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Beer;

@protocol BDBeerSuggestionDelegate
- (void)beerSuggestionWasSelected:(Beer *)beer;
@end

@interface BDBeerSuggestionAccessoryView : UIView

@property (nonatomic, weak) id<BDBeerSuggestionDelegate> delegate;

- (void)updateBeerSuggestionsWithText:(NSString *)search;

@end
