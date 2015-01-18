//
//  UTStretchView.h
//  ImageFun
//
//  Created by Deqiang Qiu on 1/12/15.
//  Copyright (c) 2015 Deqiang Qiu. All rights reserved.
//

#import <Cocoa/Cocoa.h>

//This view shows random path, with option to add image as a composite controlled by a opacity factor
@interface UTStretchView : NSView
{
    NSBezierPath * path;
    NSImage * image;
    float opacity;
    
    NSPoint downPoint;
    NSPoint currentPoint;
}
@property (readwrite) float opacity;

-(void) setImage:(NSImage*)image;
-(NSPoint) randomPoint;
@end
