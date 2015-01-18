//
//  UTAppController.m
//  ImageFun
//
//  Created by Deqiang Qiu on 1/12/15.
//  Copyright (c) 2015 Deqiang Qiu. All rights reserved.
//

#import "UTAppController.h"
#import "UTStretchView.h"

@implementation UTAppController

//initiate open file panel
- (IBAction)showOpenPanel:(id)sender
{
    
    NSOpenPanel * panel = [NSOpenPanel openPanel];
    
    [panel beginSheetForDirectory:nil file:nil types:[NSImage imageFileTypes] modalForWindow:[stretchView window] modalDelegate:self didEndSelector:@selector(openPanelDidEnd:returnCode:contextInfo:) contextInfo:NULL];
    
}

// add a button manually
- (IBAction)addNewButton:(id)sender {
    NSView *superview = [window contentView];
       NSRect frame = NSMakeRect(10,10,100,30);
    NSButton * button = [[NSButton alloc] initWithFrame:frame];
    [button setTitle:@"Click Me"];
     [button setBordered:YES];
     [button setBezelStyle:NSRoundedDisclosureBezelStyle];
 
    [superview addSubview:button];
    [button release];
    
}

//callback function of open image file panel
-(void) openPanelDidEnd:(NSOpenPanel*) openPanel returnCode:(int) returnCode contextInfo:(void*) x
{
    if(returnCode == NSOKButton)
    {
        NSString * path = [[openPanel URL] path];
        NSImage * image = [[NSImage alloc] initWithContentsOfFile:path];
        [stretchView setImage:image];
        [image release];
    }
    
}


@end
