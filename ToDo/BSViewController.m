//
//  BSViewController.m
//  ToDo
//
//  Created by Bi on 3/15/13.
//  Copyright (c) 2013 BiStudio. All rights reserved.
//


#import "BSViewController.h"
#import "BSToDoItem.h"
#import "BSTableViewCell.h"

@implementation BSViewController {
    // an array of to-do items
    NSMutableArray* _BSToDoItems;
}

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // create a dummy to-do list
        _BSToDoItems = [[NSMutableArray alloc] init];
        [_BSToDoItems addObject:[BSToDoItem toDoItemWithText:@"Feed the pet"]];
        [_BSToDoItems addObject:[BSToDoItem toDoItemWithText:@"Buy Macbook Pro"]];
        [_BSToDoItems addObject:[BSToDoItem toDoItemWithText:@"Pack bags for travelling"]];
        [_BSToDoItems addObject:[BSToDoItem toDoItemWithText:@"Rule the web"]];
        [_BSToDoItems addObject:[BSToDoItem toDoItemWithText:@"Buy a new iPhone"]];
        [_BSToDoItems addObject:[BSToDoItem toDoItemWithText:@"Find missing socks"]];
        [_BSToDoItems addObject:[BSToDoItem toDoItemWithText:@"Write a new tutorial"]];
        [_BSToDoItems addObject:[BSToDoItem toDoItemWithText:@"Objective-C"]];
        [_BSToDoItems addObject:[BSToDoItem toDoItemWithText:@"Remember your wedding anniversary!"]];
        [_BSToDoItems addObject:[BSToDoItem toDoItemWithText:@"Drink less wine"]];
        [_BSToDoItems addObject:[BSToDoItem toDoItemWithText:@"Learn to draw"]];
        [_BSToDoItems addObject:[BSToDoItem toDoItemWithText:@"Take the car to the garage"]];
        [_BSToDoItems addObject:[BSToDoItem toDoItemWithText:@"Order Misfit Shine"]];
        [_BSToDoItems addObject:[BSToDoItem toDoItemWithText:@"Learn to juggle"]];
        [_BSToDoItems addObject:[BSToDoItem toDoItemWithText:@"Give up"]];
        
    }
    return self;
}

-(void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor blackColor];
    [self.tableView registerClass:[BSTableViewCell class] forCellReuseIdentifier:@"cell"];
}

-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource protocol methods
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _BSToDoItems.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *ident = @"cell";
    // re-use or create a cell
    BSTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ident forIndexPath:indexPath];
    //    cell.textLabel.backgroundColor = [UIColor clearColor];
    
    // find the to-do item for this index
    int index = [indexPath row];
    BSToDoItem *item = _BSToDoItems[index];
    // set the text
    //cell.textLabel.text = item.text;
    
    cell.delegate = self;
    cell.todoItem = item;
    
    return cell;
}

-(UIColor*)colorForIndex:(NSInteger) index {
    NSUInteger itemCount = _BSToDoItems.count - 1;
    float val = ((float)index / (float)itemCount) * 0.6;
    return [UIColor colorWithRed: 1.0 green:val blue: 0.0 alpha:1.0];
}

#pragma mark - UITableViewDataDelegate protocol methods
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50.0f;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.backgroundColor = [self colorForIndex:indexPath.row];
}

-(void) toDoItemDeleted:(id)toDoItem {
    // use the UITableView to animate the removal of this row
    NSUInteger index = [_BSToDoItems indexOfObject:toDoItem];
    [self.tableView beginUpdates];
    [_BSToDoItems removeObject:toDoItem];
    [self.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:index inSection:0]]
                          withRowAnimation:UITableViewRowAnimationFade];
    [self.tableView endUpdates];
}

@end