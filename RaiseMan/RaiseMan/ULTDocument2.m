//
//  ULTDocument2.m
//  RaiseMan
//
//  Created by Deqiang Qiu on 1/8/15.
//  Copyright (c) 2015 Deqiang Qiu. All rights reserved.
//

#import "ULTDocument2.h"
#import "Person.h"

@implementation ULTDocument2

- (id)init
{
    self = [super init];
    if (self) {
        // Add your subclass-specific initialization here.
        employees = [[NSMutableArray alloc] init];
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
    
//    NSException *exception = [NSException exceptionWithName:@"UnimplementedMethod" reason:[NSString stringWithFormat:@"%@ is unimplemented", NSStringFromSelector(_cmd)] userInfo:nil];
//    @throw exception;
    [[tableView window] endEditingFor:nil];
    
    
    return [NSKeyedArchiver archivedDataWithRootObject:employees];
}

- (BOOL)readFromData:(NSData *)data ofType:(NSString *)typeName error:(NSError **)outError
{
    // Insert code here to read your document from the given data of the specified type. If outError != NULL, ensure that you create and set an appropriate error when returning NO.
    // You can also choose to override -readFromFileWrapper:ofType:error: or -readFromURL:ofType:error: instead.
//    // If you override either of these, you should also override -isEntireFileLoaded to return NO if the contents are lazily loaded.
//    NSException *exception = [NSException exceptionWithName:@"UnimplementedMethod" reason:[NSString stringWithFormat:@"%@ is unimplemented", NSStringFromSelector(_cmd)] userInfo:nil];
//    @throw exception;

    NSMutableArray * newArray = nil;
    @try {
        newArray = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
    @catch (NSException *exception) {
        if(outError)
        {
            NSDictionary * d = [NSDictionary dictionaryWithObject:@"The data is corrupted" forKey:NSLocalizedFailureReasonErrorKey];
            *outError = [NSError errorWithDomain:NSOSStatusErrorDomain code:unimpErr userInfo:d];
        }
        return NO;
    }

    [self setEmployees:newArray];
    return YES;
}

-(void) startObservingPerson: (Person*) p
{
    [p addObserver:self forKeyPath:@"personName" options:NSKeyValueObservingOptionOld context:NULL];
    [p addObserver:self forKeyPath:@"expectedRaise" options:NSKeyValueObservingOptionOld context:NULL];
}

-(void) stopObservingPerson: (Person*)p
{
    [p removeObserver:self forKeyPath:@"personName"];
      [p removeObserver:self forKeyPath:@"expectedRaise"];
}

- (void) insertObject: (Person *) p inEmployeesAtIndex: (int) index
{
    NSLog(@"adding %@ to %@", p, employees);
    NSUndoManager *undo = [self undoManager];
    
    [[undo prepareWithInvocationTarget:self] removeObjectFromEmployeesAtIndex: index ];
    if(![undo isUndoing])
    {
        [undo setActionName:@"Insert Person"];
    }
    
    
    [self startObservingPerson:p];
    [employees insertObject:p atIndex:index];
    
}

-(void) removeObjectFromEmployeesAtIndex: (int)index
{
    
    Person * p = [employees objectAtIndex:index];
    NSUndoManager * undo = [self undoManager];
    [[undo prepareWithInvocationTarget:self] insertObject:p inEmployeesAtIndex:index];
    
    if(![undo isUndoing])
    {
        [undo setActionName:@"Remove Person"];
    }
    [self stopObservingPerson:p];
    [employees removeObjectAtIndex:index];

}

-(void) changeKeyPath: (NSString *) keyPath ofObject: (id) obj toValue: (id)newValue
{
    [obj setValue:newValue forKey:keyPath];
}

- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    NSUndoManager * undo = [self undoManager];
    id oldValue = [change objectForKey:NSKeyValueChangeOldKey];
    [[undo prepareWithInvocationTarget:self] changeKeyPath:keyPath ofObject:object toValue:oldValue ];
    
    if(![undo isUndoing])
    {
        [undo setActionName:@"Change Value"];
    }
}


-(void) creatEmployee:(id)sender
{
    NSWindow * w = [tableView window];
    BOOL editingEnded = [w makeFirstResponder:w];
    if(!editingEnded)
    {
        NSLog(@"Unable to end editing");
        return;
    }
    NSWindow * w2 = [addEmployeeButton window];
    if([w isEqual:w2])
    {
        NSLog(@"Window from different view points to same object");
    }
    else{
        NSLog(@"Window from different view DO NOT points to same object");
    }
    
    NSUndoManager * undo = [self undoManager];
    //Has an edit occured already in this event, if so, create a new undo grouping level
    if([undo groupingLevel])
    {
        [undo endUndoGrouping];
        [undo beginUndoGrouping];
    }
    
    //create the object
    Person * p = [[Person alloc] init];
    [employeeArrayCountroller addObject:p];
    [p release];
    //re-sort (in case the user has sorted a column
    [employeeArrayCountroller rearrangeObjects];
    NSArray * a = [employeeArrayCountroller arrangedObjects];
    
    //find the object just added
    long row = [a indexOfObjectIdenticalTo:p];
    NSLog(@"starting edit of %@ in row %d", p, row );
    [tableView editColumn:0 row:row withEvent:nil select:YES];
}



@end
