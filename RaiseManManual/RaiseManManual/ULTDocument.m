//
//  ULTDocument.m
//  RaiseManManual
//
//  Created by Deqiang Qiu on 1/9/15.
//  Copyright (c) 2015 Deqiang Qiu. All rights reserved.
//

#import "ULTDocument.h"
#import "Person.h"

@implementation ULTDocument

- (id)init
{
    self = [super init];
    if (self) {
           employees = [[NSMutableArray alloc] init];
        // Add your subclass-specific initialization here.
    }
    return self;
}


-(void) dealloc
{
    [self setEmployees:nil];
    [super dealloc];
}

-(void) setEmployees:(NSMutableArray *)a
{
    [a retain];
    [employees release];
    employees = a;
}

- (NSString *)windowNibName
{
    // Override returning the nib file name of the document
    // If you need to use a subclass of NSWindowController or if your document supports multiple NSWindowControllers, you should remove this method and override -makeWindowControllers instead.
    return @"ULTDocument";
}

- (void)windowControllerDidLoadNib:(NSWindowController *)aController
{
    [super windowControllerDidLoadNib:aController];
    // Add any code here that needs to be executed once the windowController has loaded the document's window.
}

+ (BOOL)autosavesInPlace
{
    return YES;
}

- (NSData *)dataOfType:(NSString *)typeName error:(NSError **)outError
{
    // Insert code here to write your document to data of the specified type. If outError != NULL, ensure that you create and set an appropriate error when returning nil.
    // You can also choose to override -fileWrapperOfType:error:, -writeToURL:ofType:error:, or -writeToURL:ofType:forSaveOperation:originalContentsURL:error: instead.
    NSException *exception = [NSException exceptionWithName:@"UnimplementedMethod" reason:[NSString stringWithFormat:@"%@ is unimplemented", NSStringFromSelector(_cmd)] userInfo:nil];
    @throw exception;
    return nil;
}

- (BOOL)readFromData:(NSData *)data ofType:(NSString *)typeName error:(NSError **)outError
{
    // Insert code here to read your document from the given data of the specified type. If outError != NULL, ensure that you create and set an appropriate error when returning NO.
    // You can also choose to override -readFromFileWrapper:ofType:error: or -readFromURL:ofType:error: instead.
    // If you override either of these, you should also override -isEntireFileLoaded to return NO if the contents are lazily loaded.
    NSException *exception = [NSException exceptionWithName:@"UnimplementedMethod" reason:[NSString stringWithFormat:@"%@ is unimplemented", NSStringFromSelector(_cmd)] userInfo:nil];
    @throw exception;
    return YES;
}

-(void) addEmployee:(id) sender
{
    Person * newEmployee = [[Person alloc] init];
    [employees addObject:newEmployee];
    [newEmployee release];
    [tableView reloadData];
    
}

-(void) deleteEmployee:(id)sender
{
    NSIndexSet * idxSet = [tableView selectedRowIndexes];
    
    if([idxSet count] >0)
    {
        [employees removeObjectsAtIndexes:idxSet];
        [tableView reloadData];
    }
}

- (id) tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    NSString * identifier = [tableColumn identifier];

    Person * person = [employees objectAtIndex:row];
    return  [person valueForKey:identifier];
}

-(void) tableView:(NSTableView *)tableView setObjectValue:(id)object forTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    
    NSString * identifier = [tableColumn identifier];
    
    Person * person = [employees objectAtIndex:row];
    [person setValue:object forKey:identifier];

}

-(NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    return [employees count];
}

-(void) tableView:(NSTableView *)tableView sortDescriptorsDidChange:(NSArray *)oldDescriptors
{
    
    NSArray * newDescriptor = [tableView sortDescriptors];
    [employees sortUsingDescriptors:newDescriptor];
    [tableView reloadData];
}

@end
