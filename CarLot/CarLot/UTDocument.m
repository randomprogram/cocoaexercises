//
//  UTDocument.m
//  CarLot
//
//  Created by Deqiang Qiu on 1/11/15.
//  Copyright (c) 2015 Deqiang Qiu. All rights reserved.
//

#import "UTDocument.h"
#import "UTPreferenceController.h"

@implementation UTDocument

- (id)init
{
    self = [super init];
    if (self) {
        // Add your subclass-specific initialization here.
        NSNotificationCenter * nc = [NSNotificationCenter defaultCenter];
        [nc addObserver:self selector:@selector(handleBackgroundColorChange:) name:UTColorChangeNotification object:nil];
    }
    return self;
}

- (NSString *)windowNibName
{
    // Override returning the nib file name of the document
    // If you need to use a subclass of NSWindowController or if your document supports multiple NSWindowControllers, you should remove this method and override -makeWindowControllers instead.
    return @"UTDocument";
}

- (void)windowControllerDidLoadNib:(NSWindowController *)aController
{
    [super windowControllerDidLoadNib:aController];
    // Add any code here that needs to be executed once the windowController has loaded the document's window.
  //  [self handleBackgroundColorChange:nil];
    
    //register to receive notification of the color change in Preference Panel
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSData * colorAsData;
    colorAsData = [defaults objectForKey:UTTableBgColorKey];
    [tableView setBackgroundColor:[NSKeyedUnarchiver unarchiveObjectWithData:colorAsData]];
}

//handle background color change in preference panel
- (void) handleBackgroundColorChange:(NSNotification*)note
{
    NSColor * color = [[note userInfo] objectForKey:@"color"];
    [tableView setBackgroundColor:color];
    
    
}

+ (BOOL)autosavesInPlace
{
    return YES;
}

@end
