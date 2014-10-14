//
//  BSToDoItem.h
//  ToDo
//
//  Created by Bi on 3/15/13.
//  Copyright (c) 2013 BiStudio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BSToDoItem : NSObject

// Item Description
@property (nonatomic, copy) NSString *itemDescription;

// Item completed state
@property (nonatomic) BOOL completed;

// Init a new item with description
-(id) initWithText: (NSString*) description;

// Init a new item with description
+(id) toDoItemWithText: (NSString*) description;

@end

