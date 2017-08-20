//
//  BDCamPreviewView.m
//  BeerDiary
//
//  Created by Stephen Lindauer on 8/19/17.
//  Copyright © 2017 Stephen Lindauer. All rights reserved.
//

@import AVFoundation;

#import "BDCamPreviewView.h"

@implementation BDCamPreviewView


+ (Class)layerClass
{
    return [AVCaptureVideoPreviewLayer class];
}

- (AVCaptureVideoPreviewLayer *)videoPreviewLayer
{
    return (AVCaptureVideoPreviewLayer *)self.layer;
}

- (AVCaptureSession *)session
{
    return self.videoPreviewLayer.session;
}

- (void)setSession:(AVCaptureSession *)session
{
    self.videoPreviewLayer.session = session;
}

@end
