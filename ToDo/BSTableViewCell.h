//
//  BSTableViewCell.h
//  ToDo
//
//  Created by Bi on 3/15/13.
//  Copyright (c) 2013 BiStudio. All rights reserved.
//

#import "BSToDoItem.h"
#import "BSTableViewCellDelegate.h"

// A custom table cell that renders SHCToDoItem items.
@interface BSTableViewCell : UITableViewCell

// The item that this cell renders.
@property (nonatomic) BSToDoItem *todoItem;

// The object that acts as delegate for this cell.
@property (nonatomic, assign) id<BSTableViewCellDelegate> delegate;

@end