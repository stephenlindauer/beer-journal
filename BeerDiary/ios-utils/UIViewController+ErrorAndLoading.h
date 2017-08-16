//
//  UIViewController+JogTimes.h
//  JogTimes
//
//  Created by Stephen Lindauer on 6/22/17.
//  Copyright © 2017 Stephen Lindauer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (ErrorAndLoading)

- (void)showLoadingAnimation;
- (void)hideLoadingAnimation;
- (void)showAlertForError:(NSError *)error;
- (void)showAlertForError:(NSError *)error completion:(void (^)())completion;


@end
