//
//  BSTableViewCell.h
//  ToDo
//
//  Created by Bi on 3/15/13.
//  Copyright (c) 2013 BiStudio. All rights reserved.
//

#import "BSToDoItem.h"
#import "BSTableViewCellDelegate.h"

// A custom table cell
@interface BSTableViewCell : UITableViewCell

// Rendering items
@property (nonatomic) BSToDoItem *todoItem;

// Cell delegate
@property (nonatomic, assign) id<BSTableViewCellDelegate> delegate;

@end