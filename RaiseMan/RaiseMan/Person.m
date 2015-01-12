//
//  Person.m
//  RaiseMan
//
//  Created by Deqiang Qiu on 1/8/15.
//  Copyright (c) 2015 Deqiang Qiu. All rights reserved.
//

#import "Person.h"

@implementation Person
@synthesize personName;
@synthesize expectedRaise;

-(id) init
{
    self = [super init];
    expectedRaise = 5.0;
    personName = @"New Person";
    return self;
}

-(void) dealloc
{
    [personName release];
    [super dealloc];
}

-(void) setNilValueForKey:(NSString *)key
{
    if([key isEqualTo:@"expectedRaise"])
    {
        [self setExpectedRaise:0];
    }
    else{
        [self setNilValueForKey:key];
    }
}

-(id) initWithCoder: (NSCoder*) coder
{
    [super init];
    personName = [[coder decodeObjectForKey:@"personName"] retain];
    expectedRaise = [coder decodeFloatForKey:@"expectedRaise"];
    return self;
}

-(void) encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:personName forKey:@"personName"];
    [aCoder encodeFloat:expectedRaise forKey:@"expectedRaise"];
}

@end
