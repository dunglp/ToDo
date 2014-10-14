//
//  BSViewController.h
//  ToDo
//
//  Created by Bi on 3/15/13.
//  Copyright (c) 2013 BiStudio. All rights reserved.
//

#import "BSTableViewCellDelegate.h"

@interface BSViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, BSTableViewCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
