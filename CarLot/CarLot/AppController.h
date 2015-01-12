//
//  AppController.h
//  CarLot
//
//  Created by Deqiang Qiu on 1/11/15.
//  Copyright (c) 2015 Deqiang Qiu. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UTPreferenceController;

@interface AppController : NSObject
{
    UTPreferenceController * preferenceController;
}

//call preference panel, called when Preference menu is selected
-(IBAction)showPreferencePanel:(id)sender;

@end
