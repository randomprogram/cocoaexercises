//
//  UTStretchView.m
//  ImageFun
//
//  Created by Deqiang Qiu on 1/12/15.
//  Copyright (c) 2015 Deqiang Qiu. All rights reserved.
//

#import "UTStretchView.h"
#include "math.h"

@implementation UTStretchView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
       path =  [[NSBezierPath alloc]init];
        [path setLineWidth:3.0];
        NSPoint p = [self randomPoint];
        [path moveToPoint:p];
        for(int i = 0; i < 15; i++)
        {
            p = [self randomPoint];
            [path lineToPoint:p];
        }
        [path closePath];
        [self setOpacity:1.0];
    }
    return self;
}


-(void) dealloc
{
    [path release];
    [image release];
    [super dealloc];
}


//paint function, called whenever the view needs to repaint itself
- (void)drawRect:(NSRect)dirtyRect
{
    [super drawRect:dirtyRect];
    
    NSRect bounds = [self bounds];
    [[NSColor greenColor] set];
    [NSBezierPath fillRect:bounds];
    [[NSColor redColor] set];
    [path fill];
    if(image !=nil)
    {
        NSRect imageRect,drawRect;
        
        drawRect = NSMakeRect(fmin(downPoint.x,currentPoint.x),fmin(downPoint.y,currentPoint.y),fabs(downPoint.x-currentPoint.x), fabs(downPoint.y-currentPoint.y));
        imageRect.origin = NSZeroPoint;
        imageRect.size = [image size];
        
        [image drawInRect:drawRect fromRect:imageRect operation:NSCompositeSourceOver fraction:opacity];
        
    }
    // Drawing code here.
}

-(void) mouseDown:(NSEvent *) event
{
    NSLog(@"mouse down:%ld", [event clickCount]);
   downPoint =  [self convertPoint:[event locationInWindow] fromView:nil];
}

-(void) mouseDragged:(NSEvent *)theEvent
{
    currentPoint = [self convertPoint:[theEvent locationInWindow] fromView:nil];
    [self autoscroll:theEvent];
    [self setNeedsDisplay:YES];
}

-(void) mouseUp:(NSEvent *)theEvent
{
    currentPoint = [self convertPoint:[theEvent locationInWindow] fromView:nil];
    
    [self setNeedsDisplay:YES];
}

-(void) setImage:(NSImage*)img
{
    [img retain];
    [image release];
    image = img;
    
    currentPoint = NSZeroPoint;
    downPoint.x = [image size].width;
    downPoint.y = [image size].height;
    [self setNeedsDisplay:YES];
}

-(float) opacity
{
    return opacity;
}

-(void) setOpacity:(float)opc
{
    opacity = opc;
    [self setNeedsDisplay:YES];
}


-(NSPoint) randomPoint
{
    NSPoint point;
    NSRect r = [self bounds];
    point.x = r.origin.x + random()%(int) r.size.width;
    point.y = r.origin.y + random() %(int) r.size.height;
    
    return point;
    
}

@end
