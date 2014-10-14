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

#define CELL_ITEM_HEIGHT 45.0

@implementation BSViewController {
    // To do items array
    NSMutableArray* _BSToDoItems;
}

-(id) initWithNibName: (NSString *)nibNameOrNil bundle: (NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Create a sample To do list
        _BSToDoItems = [[NSMutableArray alloc] init];
        [_BSToDoItems addObject:[BSToDoItem toDoItemWithText:@"Feed the pet"]];
        [_BSToDoItems addObject:[BSToDoItem toDoItemWithText:@"Buy Macbook Pro"]];
        [_BSToDoItems addObject:[BSToDoItem toDoItemWithText:@"Pack bags for travelling"]];
        [_BSToDoItems addObject:[BSToDoItem toDoItemWithText:@"Learn Javascript"]];
        [_BSToDoItems addObject:[BSToDoItem toDoItemWithText:@"Buy birthday cake"]];
        [_BSToDoItems addObject:[BSToDoItem toDoItemWithText:@"Write new blog post"]];
        [_BSToDoItems addObject:[BSToDoItem toDoItemWithText:@"Research HTML 5"]];
        [_BSToDoItems addObject:[BSToDoItem toDoItemWithText:@"Prepare for birthday party"]];
        [_BSToDoItems addObject:[BSToDoItem toDoItemWithText:@"Buy balloon"]];
        [_BSToDoItems addObject:[BSToDoItem toDoItemWithText:@"Read a book"]];
        [_BSToDoItems addObject:[BSToDoItem toDoItemWithText:@"Order Misfit Shine"]];
        [_BSToDoItems addObject:[BSToDoItem toDoItemWithText:@"Learn popping"]];
        [_BSToDoItems addObject:[BSToDoItem toDoItemWithText:@"Go to sleep"]];
        
    }
    return self;
}

-(void) viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.tableView.backgroundColor = [UIColor blackColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[BSTableViewCell class] forCellReuseIdentifier:@"cell"];
}

-(void) didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource protocol methods
-(NSInteger) tableView: (UITableView *)tableView numberOfRowsInSection: (NSInteger)section {
    return _BSToDoItems.count;
}

-(UITableViewCell*) tableView: (UITableView *)tableView cellForRowAtIndexPath: (NSIndexPath *)indexPath {
    NSString *ident = @"cell";
    
    // Reuse or create a new cell
    BSTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: ident forIndexPath: indexPath];
    cell.textLabel.backgroundColor = [UIColor clearColor];
    
    NSInteger index = [indexPath row];
    BSToDoItem *item = _BSToDoItems[index];
    //cell.textLabel.text = item.itemDescription;
    
    cell.delegate = self;
    cell.todoItem = item;
    
    return cell;
}

-(UIColor*) colorForIndex:(NSInteger) index {
    NSUInteger itemCount = _BSToDoItems.count - 1;
    float value = ((float)index / (float)itemCount) * 0.8;
    return [UIColor colorWithRed: 1.0 green:value blue: 0.0 alpha:1.0];
}

#pragma mark - UITableViewDataDelegate protocol methods
-(CGFloat) tableView: (UITableView *)tableView heightForRowAtIndexPath: (NSIndexPath *)indexPath {
    return CELL_ITEM_HEIGHT;
}

-(void) tableView: (UITableView *)tableView willDisplayCell: (UITableViewCell *)cell forRowAtIndexPath: (NSIndexPath *)indexPath {
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