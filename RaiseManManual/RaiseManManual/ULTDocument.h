//
//  ULTDocument.h
//  RaiseManManual
//
//  Created by Deqiang Qiu on 1/9/15.
//  Copyright (c) 2015 Deqiang Qiu. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ULTDocument : NSDocument <NSTableViewDataSource>
{
    NSMutableArray * employees;
    IBOutlet NSTableView * tableView;
}

-(void) setEmployees: (NSMutableArray * ) a;

-(IBAction) addEmployee:(id)sender;
-(IBAction) deleteEmployee:(id)sender;

@end
