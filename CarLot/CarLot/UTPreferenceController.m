//
//  UTPreferenceController.m
//  CarLot
//
//  Created by Deqiang Qiu on 1/11/15.
//  Copyright (c) 2015 Deqiang Qiu. All rights reserved.
//

#import "UTPreferenceController.h"
NSString * const UTTableBgColorKey = @"TableBackgroundColor";
NSString * const UTEmptyDocKey = @"EmptyDocumentFlag";
NSString * const UTColorChangeNotification = @"UTColorChanged";


@implementation UTPreferenceController

+(void) initialize //class initializer
{
    NSMutableDictionary * defaultValues = [NSMutableDictionary dictionary];
    NSData * colorAsData = [NSKeyedArchiver archivedDataWithRootObject:[NSColor yellowColor]];
    [defaultValues setObject:colorAsData forKey:UTTableBgColorKey];
    [defaultValues setObject:[NSNumber numberWithBool:YES] forKey:UTEmptyDocKey];
    
    [[NSUserDefaults standardUserDefaults] registerDefaults:defaultValues];
    
    NSLog(@"registered defaults: %@", defaultValues);
    
}

- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {
        // Initialization code here.
        

    }
    return self;
}

-(id) init
{
    if(![self initWithWindowNibName:@"Preference"])
        return nil;

    return self;
    
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    [colorWell setColor:[self tableBgColor]];
    [checkBox setState:[self emptyDoc]];
    
}

-(IBAction) changeBackgroundColor:(id)sender
{
    NSColor *color = [colorWell color];
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[NSKeyedArchiver archivedDataWithRootObject:color] forKey:UTTableBgColorKey];
    NSDictionary * d = [NSDictionary dictionaryWithObject:color forKey:@"color"];
    NSNotificationCenter * nc = [NSNotificationCenter defaultCenter];
    [nc postNotificationName:UTColorChangeNotification object:self userInfo:d];
    
    NSLog(@"Color changed to %@", color);
}

-(IBAction)changeNewEmptyDoc:(id)sender
{
    int state = [checkBox state];
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:state forKey:UTEmptyDocKey];

    NSLog(@"Checkbox changed %d",state);
}

- (NSColor *) tableBgColor
{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSData * colorAsData = [defaults objectForKey:UTTableBgColorKey];
    return [NSKeyedUnarchiver unarchiveObjectWithData:colorAsData];
}

-(BOOL) emptyDoc
{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    return [defaults boolForKey:UTEmptyDocKey];
}




@end
