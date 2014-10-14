//
//  BSToDoItem.m
//  ToDo
//
//  Created by Bi on 3/15/13.
//  Copyright (c) 2013 BiStudio. All rights reserved.
//

#import "BSToDoItem.h"

@implementation BSToDoItem

-(id) initWithText: (NSString*) description {
    if (self = [super init]) {
        self.itemDescription = description;
    }
    return self;
}

+(id) toDoItemWithText: (NSString *) description {
    return [[BSToDoItem alloc] initWithText:description];
}

@end
