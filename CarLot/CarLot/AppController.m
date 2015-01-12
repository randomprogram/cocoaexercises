//
//  AppController.m
//  CarLot
//
//  Created by Deqiang Qiu on 1/11/15.
//  Copyright (c) 2015 Deqiang Qiu. All rights reserved.
//

#import "AppController.h"
#import "UTPreferenceController.h"


@implementation AppController
-(id) init
{
    self = [super init];
    preferenceController = nil;
    
//    NSNotificationCenter * nc = [NSNotificationCenter defaultCenter];
//    [nc addObserver:self selector:@selector(handleLoseFocus:) name:NSApplicationDidResignActiveNotification object:nil];
    
    return self;
}

//call preference panel, called when Preference menu is selected
-(void) showPreferencePanel:(id)sender
{
    if(preferenceController == nil)
    {
        preferenceController = [[UTPreferenceController alloc] init];
    }
    
    NSLog(@"showing %@", preferenceController);
    [preferenceController showWindow:self];
}

//delegate method of NSApplication to determine whether a blank document should always appear
-(BOOL) applicationShouldOpenUntitledFile:(id) sender
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:UTEmptyDocKey];
}

//beep when losing focus, to trigger uncomment the lines on "init"
-(void) handleLoseFocus:(NSNotification * ) note
{
    NSBeep();
}

@end
