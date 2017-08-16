//
//  UIViewController+JogTimes.m
//  JogTimes
//
//  Created by Stephen Lindauer on 6/22/17.
//  Copyright © 2017 Stephen Lindauer. All rights reserved.
//

#import "UIViewController+ErrorAndLoading.h"
#import <AFNetworking/AFNetworking.h>
#import "DGActivityIndicatorView.h"



@implementation UIViewController (ErrorAndLoading)

- (void)showLoadingAnimation
{
    DGActivityIndicatorView *activityView = [[DGActivityIndicatorView alloc] initWithType:DGActivityIndicatorAnimationTypeTriplePulse tintColor:[UIColor whiteColor] size:50.0f];
    UIView *view;
    if (self.navigationController.navigationBarHidden || self.navigationController == nil) {
        view = self.view;
    }
    else {
        view = self.navigationController.navigationBar;
    }
    
    
    // Container view is just to add the semi transparent circle around the animation
    UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    containerView.backgroundColor = [UIColor colorWithWhite:0 alpha:.6];
    containerView.center = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2-40);
    containerView.layer.cornerRadius = 30;
    [containerView addSubview:activityView];
    containerView.tag = 42; // This value has no real meaning
    
    [view addSubview:containerView];
    activityView.center = CGPointMake(containerView.bounds.size.width/2, containerView.bounds.size.height/2);
    [activityView startAnimating];
    
    // Animate pop in
    containerView.transform = CGAffineTransformMakeScale(.001, .001);
    [UIView animateWithDuration:.6 delay:0 usingSpringWithDamping:.7 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        containerView.transform = CGAffineTransformMakeScale(1, 1);
    } completion:^(BOOL finished) {
        
    }];
}

- (void)hideLoadingAnimation
{
    UIView *view;
    if (self.navigationController.navigationBarHidden || self.navigationController == nil) {
        view = self.view;
    }
    else {
        view = self.navigationController.navigationBar;
    }
    
    for (UIView *subview in view.subviews) {
        if (subview.tag == 42) {
            [UIView animateWithDuration:.3 animations:^{
                subview.transform = CGAffineTransformMakeScale(.001, .001);
            } completion:^(BOOL finished) {
                [subview removeFromSuperview];
            }];
        }
    }
}

- (void)showAlertForError:(NSError *)error completion:(void (^)())completion
{
    NSString *errorString;
    
    NSError *jsonError;
    NSDictionary *json;
    if (error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey]) {
        json = [NSJSONSerialization JSONObjectWithData:error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey]
                                               options:NSJSONReadingMutableContainers
                                                 error:&jsonError];
    }
    
    NSLog(@"json: %@", json);
    if (jsonError || json == nil) {
        errorString = error.localizedDescription;
    }
    else {
        errorString = json[@"error_description"];
    }
    NSLog(@"Error: %@", errorString);
    
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"Error"
                                                                    message:errorString
                                                             preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* okAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        [alert dismissViewControllerAnimated:YES completion:nil];
        if (completion) {
            completion();
        }
    }];
    
    [alert addAction:okAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)showAlertForError:(NSError *)error
{
    [self showAlertForError:error completion:nil];
}



@end
