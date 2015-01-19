//
//  UTBigLetterView.h
//  BigLetterView
//
//  Created by Deqiang Qiu on 1/17/15.
//  Copyright (c) 2015 Deqiang Qiu. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface UTBigLetterView : NSView
{

    NSColor * bgColor;
    NSString * string;
    BOOL isHighlighted;
    NSMutableDictionary * attributes;

}
@property (retain,readwrite) NSColor * bgColor;
@property (copy, readwrite) NSString * string;
@end
