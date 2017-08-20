//
//  BDCamPreviewView.h
//  BeerDiary
//
//  Created by Stephen Lindauer on 8/19/17.
//  Copyright © 2017 Stephen Lindauer. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AVCaptureSession;

@interface BDCamPreviewView : UIView

@property (nonatomic, readonly) AVCaptureVideoPreviewLayer *videoPreviewLayer;

@property (nonatomic) AVCaptureSession *session;


@end
