//
//  UTAppController.h
//  ImageFun
//
//  Created by Deqiang Qiu on 1/12/15.
//  Copyright (c) 2015 Deqiang Qiu. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UTStretchView;

@interface UTAppController : NSObject
{
    IBOutlet UTStretchView * stretchView;
    IBOutlet NSWindow *window;
}
- (IBAction)showOpenPanel:(id)sender;

- (IBAction)addNewButton:(id)sender;

@end
