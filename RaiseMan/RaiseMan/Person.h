//
//  Person.h
//  RaiseMan
//
//  Created by Deqiang Qiu on 1/8/15.
//  Copyright (c) 2015 Deqiang Qiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject  <NSCoding>
{
NSString * personName;
float expectedRaise;
}

@property (readwrite, copy) NSString * personName;
@property (readwrite, assign) float expectedRaise;

@end
