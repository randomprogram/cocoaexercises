//
//  ULTDocument.h
//  RaiseMan
//
//  Created by Deqiang Qiu on 1/8/15.
//  Copyright (c) 2015 Deqiang Qiu. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class Person;
@interface ULTDocument2 : NSDocument <NSCoding>
{
    NSMutableArray * employees;
    IBOutlet NSTableView * tableView;
    IBOutlet NSArrayController * employeeArrayCountroller;
    IBOutlet NSButton * addEmployeeButton;
}

-(void) setEmployees: (NSMutableArray * ) a;
-(IBAction) creatEmployee:(id)sender;
-(void) removeObjectFromEmployeesAtIndex: (int)index;
- (void) insertObject: (Person *) p inEmployeesAtIndex: (int) index ;

@end
