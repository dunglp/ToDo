//
//  BSToDoItem.m
//  ToDo
//
//  Created by Bi on 3/15/13.
//  Copyright (c) 2013 BiStudio. All rights reserved.
//

#import "BSToDoItem.h"

@implementation BSToDoItem

-(id)initWithText:(NSString*)text {
    if (self = [super init]) {
        self.text = text;
    }
    return self;
}

+(id)toDoItemWithText:(NSString *)text {
    return [[BSToDoItem alloc] initWithText:text];
}

@end
