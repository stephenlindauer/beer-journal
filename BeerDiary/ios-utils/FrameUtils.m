//
//  Night Owl FrameUtils
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "FrameUtils.h"

void FrameSetX(id objectWithFrame, CGFloat x) {
    
    if (![objectWithFrame respondsToSelector:@selector(frame)]) {
        return;
    }
    
    CGRect frame = [objectWithFrame frame];
    
    frame.origin.x = x;
    
    [objectWithFrame setFrame:frame];    
}

void FrameSetY(id objectWithFrame, CGFloat y) {
    
    if (![objectWithFrame respondsToSelector:@selector(frame)]) {
        return;
    }
    
    CGRect frame = [objectWithFrame frame];
    
    frame.origin.y = y;
    
    [objectWithFrame setFrame:frame];
}

void FrameSetXY(id objectWithFrame, CGFloat x, CGFloat y)
{
    if (![objectWithFrame respondsToSelector:@selector(frame)]) {
        return;
    }
    
    CGRect frame = [objectWithFrame frame];
    
    frame.origin.x = x;
    frame.origin.y = y;
    
    [objectWithFrame setFrame:frame];
}

void FrameSetHeight(id objectWithFrame, CGFloat height)
{
    if (![objectWithFrame respondsToSelector:@selector(frame)]) {
        return;
    }
    CGRect frame = [objectWithFrame frame];
    frame.size.height = height;
    [objectWithFrame setFrame:frame];
}

void FrameSetWidth(id objectWithFrame, CGFloat width)
{
    if (![objectWithFrame respondsToSelector:@selector(frame)]) {
        return;
    }
    
    CGRect frame = [objectWithFrame frame];
    
    frame.size.width = width;
    
    [objectWithFrame setFrame:frame];
}

void FrameSetCenter(id objectInCenter, id objectToCenter)
{
    if (![objectToCenter respondsToSelector:@selector(frame)]) {
        return;
    }
    
    CGRect desiredFrame = [objectInCenter frame];
    
    CGPoint center = CGPointMake(desiredFrame.size.width / 2, desiredFrame.size.height / 2);
    [objectToCenter setCenter:center];
}

void FrameSetCenterX(UIView *objectWithFrame, CGFloat x)
{
    if (![objectWithFrame respondsToSelector:@selector(frame)]) {
        return;
    }
    
//    CGRect originalFrame = [objectWithFrame frame];
//    originalFrame.origin.x = x;
    
    CGPoint center = CGPointMake(x, objectWithFrame.center.y);
    [objectWithFrame setCenter:center];
}

void FrameSetCenterY(id objectWithFrame, CGFloat y) 
{
    if (![objectWithFrame respondsToSelector:@selector(frame)]) {
        return;
    }
    
    CGRect originalFrame = [objectWithFrame frame];
    originalFrame.origin.y = y;
    
    CGPoint center = CGPointMake(originalFrame.origin.x, y);
    [objectWithFrame setCenter:center];
}

void FrameNudgeX(id objectWithFrame, CGFloat x)
{
    if (![objectWithFrame respondsToSelector:@selector(frame)]) {
        return;
    }
    
    CGRect frame = [objectWithFrame frame];
    frame.origin.x += x;
    
    [objectWithFrame setFrame:frame];
}

void FrameNudgeY(id objectWithFrame, CGFloat y)
{
    if (![objectWithFrame respondsToSelector:@selector(frame)]) {
        return;
    }
    
    CGRect frame = [objectWithFrame frame];
    frame.origin.y += y;
    
    [objectWithFrame setFrame:frame];
}

void FrameSize(id objectWithFrame, float width, float height)
{
    if (![objectWithFrame respondsToSelector:@selector(frame)]) {
        return;
    }
    
    CGRect frame = [objectWithFrame frame];
    
    frame.size.width = width;
    frame.size.height = height;
    
    [objectWithFrame setFrame:frame];    
}
