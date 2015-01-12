//
//  UTPreferenceController.h
//  CarLot
//
//  Created by Deqiang Qiu on 1/11/15.
//  Copyright (c) 2015 Deqiang Qiu. All rights reserved.
//

#import <Cocoa/Cocoa.h>
extern NSString * const UTTableBgColorKey;
extern NSString * const UTEmptyDocKey;
extern NSString * const UTColorChangeNotification;


@interface UTPreferenceController : NSWindowController
{
    IBOutlet NSColorWell * colorWell;
    IBOutlet NSButton * checkBox;
}

-(IBAction)changeBackgroundColor:(id)sender;
-(IBAction)changeNewEmptyDoc:(id)sender;

@end
