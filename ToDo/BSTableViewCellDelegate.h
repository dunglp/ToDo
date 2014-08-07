//
//  BSTableViewCellDelegate.h
//  ToDo
//
//  Created by Bi on 3/15/13.
//  Copyright (c) 2013 BiStudio. All rights reserved.
//

#import "BSToDoItem.h"

// A protocol that the SHCTableViewCell uses to inform of state change
@protocol BSTableViewCellDelegate <NSObject>

// indicates that the given item has been deleted
-(void) toDoItemDeleted:(BSToDoItem*)todoItem;

@end