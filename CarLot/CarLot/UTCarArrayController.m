//
//  UTCarArrayController.m
//  CarLot
//
//  Created by Deqiang Qiu on 1/11/15.
//  Copyright (c) 2015 Deqiang Qiu. All rights reserved.
//

#import "UTCarArrayController.h"

@implementation UTCarArrayController

//override parent method to make the purchase date today when creating new object
-(id) newObject
{
    id newObj = [super newObject];
    
    NSDate * now = [NSDate date];
    [newObj setValue:now forKey:@"datePurchased"];
    
    return newObj;
    
}

@end
