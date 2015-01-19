//
//  UTBigLetterView.m
//  BigLetterView
//
//  Created by Deqiang Qiu on 1/17/15.
//  Copyright (c) 2015 Deqiang Qiu. All rights reserved.
//

#import "UTBigLetterView.h"

@implementation UTBigLetterView

//synthesize setter getter methods for string
@synthesize string;

-(NSColor*) bgColor
{
    return bgColor;
}

-(void) setBgColor:(NSColor *)bgC
{
    [bgC retain];
    [bgColor release];
    bgColor = bgC;
    //refresh display
    [self setNeedsDisplay:YES];
}

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
        bgColor = [[NSColor yellowColor] retain];
        string = @" ";
        //initialize font attributes
        [self prepareAttributes];
        
        
    }
    return self;
}



-(void) dealloc
{
    [bgColor release];
    [string release];
    [attributes release];
    [super dealloc];
}

//Handles first responder chain calls
-(BOOL) acceptsFirstResponder
{
    return YES;
}

-(BOOL) resignFirstResponder
{
    [self setNeedsDisplay:YES];
    return YES;
}

- (BOOL) becomeFirstResponder
{
    [self setNeedsDisplay:YES];
    return YES;
}

//call interpret KeyEvents of NSView to distinguish Tab/Shift-Tab keys from other keys, interpretKeyEvents will call insertText or insertBacktab accordingly
-(void) keyDown:(NSEvent *)theEvent
{
    [self interpretKeyEvents:[NSArray arrayWithObject:theEvent]];
}

- (void) insertText:(NSString* )insertString
{
    [self setString:insertString];
    [self setNeedsDisplay:YES];
}

-(void) insertBacktab:(id)sender
{
    [[self window] selectKeyViewPrecedingView:self];
}

-(void) insertTab:(id)sender
{
    [[self window] selectKeyViewFollowingView:self];
}

-(void) deleteBackward:(id)sender
{
    [self setString:@" "];
}

//handles rollover, to allow highlighting of the border
- (void) viewDidMoveToWindow
{
    int options = NSTrackingMouseEnteredAndExited |
                  NSTrackingActiveAlways |
    NSTrackingInVisibleRect;
    NSTrackingArea * ta;
    
    ta = [[NSTrackingArea alloc] initWithRect:NSZeroRect options:options owner:self userInfo:nil];
    
    [self addTrackingArea:ta];
    [ta release];
}

- (void) mouseEntered:(NSEvent *)theEvent
{
    isHighlighted = YES;
    NSLog(@"Mouse entered view");
    [self setNeedsDisplay:YES];
}

- (void) mouseExited:(NSEvent *)theEvent
{
    isHighlighted = NO;
     NSLog(@"Mouse exited view");
    [self setNeedsDisplay:YES];
}


//prepare text attributes
-(void) prepareAttributes
{
    attributes = [[NSMutableDictionary alloc] init];
    [attributes setObject:[NSFont fontWithName:@"Helvetica" size:75] forKey:NSFontAttributeName];
    [attributes setObject:[NSColor redColor] forKey:NSForegroundColorAttributeName];
}

-(BOOL) isOpaque
{
    return YES;
}

//repaint methods, this method gets call everytime the view needs a repaint
- (void)drawRect:(NSRect)dirtyRect
{
    [super drawRect:dirtyRect];
    
    // Drawing code here.
    NSRect bounds = [self bounds];
    [bgColor set];
    //fill the background with set color
    [NSBezierPath fillRect:bounds];
    
    [self drawStringCenteredIn:bounds];
    if(isHighlighted || ([[self window] firstResponder] == self && [NSGraphicsContext currentContextDrawingToScreen]))
    {
        [NSGraphicsContext saveGraphicsState];
        NSSetFocusRingStyle(NSFocusRingOnly);
        [[NSColor keyboardFocusIndicatorColor] set];
        [NSBezierPath setDefaultLineWidth:4.0];
        [NSBezierPath strokeRect:bounds];
        [NSGraphicsContext restoreGraphicsState];
    }
    
}

//function for drawing string on the center of the view
-(void) drawStringCenteredIn:(NSRect) r
{
    NSSize strSize = [string sizeWithAttributes:attributes];
    NSPoint strOrigin;
    strOrigin.x = r.origin.x + (r.size.width - strSize.width)/2;
    strOrigin.y = r.origin.y + (r.size.height - strSize.height)/2;
    [string drawAtPoint:strOrigin withAttributes:attributes];
}

//save view to a pdf file
-(IBAction)savePDF:(id)sender
{
    NSSavePanel * panel = [NSSavePanel savePanel];
 //   [panel setRequiredFileType:@"pdf"];
//    [panel beginSheetForDirectory:nil file:nil modalForWindow:[self window] modalDelegate:self didEndSelector:@selector(didEnd:returnCode:contextInfo:) contextInfo:NULL];
    [panel setAllowedFileTypes:[NSArray arrayWithObject:@"pdf"]];
     
    [panel beginSheetModalForWindow:[self window] completionHandler:
     ^(NSInteger result)
     {
         if(result != NSOKButton)
             return;
         NSRect r= [self bounds];
         NSData * data = [self dataWithPDFInsideRect:r];
         NSString * path = [[panel URL] path];
         NSError * error;
         BOOL successful = [data writeToFile:path options:0 error:&error];
         if(!successful){
             NSAlert * a = [NSAlert alertWithError:error];
             [a runModal];
         }
         
     }
     ];
}

-(void) writeToPasteboard: (NSPasteboard *) pb
{
    //declare type
    [pb declareTypes:[NSArray arrayWithObjects:NSStringPboardType, NSPDFPboardType,nil] owner:self];
    //copy data to the pasteboard
    [pb setString:string forType:NSStringPboardType];
    
    NSRect r= [self bounds];
    NSData * data = [self dataWithPDFInsideRect:r];
    
    [pb setData:data forType:NSPDFPboardType];
    
    
 
}

-(BOOL) readFromPasteboard: (NSPasteboard*) pb
{
    NSArray * types = [pb types];
    if([types containsObject:NSStringPboardType])
    {
        NSString * value = [pb stringForType:NSStringPboardType];
        //we can only handle one character
        if([value length] ==1)
        {
            [self setString:value];
            [self setNeedsDisplay:YES];
            return YES;
        }
    }
    
    return NO;
}


-(IBAction)cut:(id)sender
{
    [self copy:sender];
    [self setString:@" "];
}

-(IBAction)copy:(id)sender
{
    [self writeToPasteboard:[NSPasteboard generalPasteboard]];
    
}

-(IBAction)paste:(id)sender
{
    NSPasteboard * pb = [NSPasteboard generalPasteboard];
    if(![self readFromPasteboard:pb])
    {
        NSBeep();
    }
}
@end
