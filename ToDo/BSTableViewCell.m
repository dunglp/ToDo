//
//  BSTableViewCell.m
//  ToDo
//
//  Created by Bi on 3/15/13.
//  Copyright (c) 2013 BiStudio. All rights reserved.
//


#import <QuartzCore/QuartzCore.h>
#import "BSStrikeLabel.h"
#import "BSTableViewCell.h"

@implementation BSTableViewCell

{
    CAGradientLayer* _gradientLayer;
    CGPoint _originalCenter;
	BOOL _deleted;
    BSStrikeLabel *_itemDescriptionLabel;
	CALayer *_itemCompletedLayer;
    BOOL _completed;
    
    UILabel *_tick;
	UILabel *_cross;
}

const float LABEL_LEFT_MARGIN = 15.0f;
const float UI_CUES_MARGIN = 10.0f;
const float UI_CUES_WIDTH = 50.0f;

-(void)setTodoItem:(BSToDoItem *)todoItem {
    _todoItem = todoItem;
    // we must update all the visual state associated with the model item
    _itemDescriptionLabel.text = todoItem.itemDescription;
    _itemDescriptionLabel.strikethrough = todoItem.completed;
    _itemCompletedLayer.hidden = !todoItem.completed;
}

// utility method for creating the contextual cues
-(UILabel*) createCueLabel {
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectNull];
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont boldSystemFontOfSize:32.0];
    label.backgroundColor = [UIColor clearColor];
    return label;
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        // Add a tick
        _tick = [self createCueLabel];
        _tick.text = @"\u2713";
        _tick.textAlignment = NSTextAlignmentRight;
        [self addSubview:_tick];
        
        // Add a cross
        _cross = [self createCueLabel];
        _cross.text = @"\u2717";
        _cross.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_cross];
        
        // Add a layer that overlays the cell adding a subtle gradient effect
        _gradientLayer = [CAGradientLayer layer];
        _gradientLayer.frame = self.bounds;
        _gradientLayer.colors = @[(id)[[UIColor colorWithWhite:1.0f alpha:0.2f] CGColor],
                                  (id)[[UIColor colorWithWhite:1.0f alpha:0.1f] CGColor],
                                  (id)[[UIColor clearColor] CGColor],
                                  (id)[[UIColor colorWithWhite:0.0f alpha:0.1f] CGColor]];
        _gradientLayer.locations = @[@0.00f, @0.01f, @0.95f, @1.00f];
        [self.layer insertSublayer:_gradientLayer atIndex:0];
        
        // Add a layer will show a green background when an item is completed
        _itemCompletedLayer = [CALayer layer];
        _itemCompletedLayer.backgroundColor = [[[UIColor alloc] initWithRed:0.0 green:0.6 blue:0.0 alpha:1.0] CGColor];
        _itemCompletedLayer.hidden = YES;
        [self.layer insertSublayer:_itemCompletedLayer atIndex:0];
        
        // Add a pan recognizer
        UIGestureRecognizer* recognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
        recognizer.delegate = self;
        [self addGestureRecognizer:recognizer];
    
    // Create a label that display item description
    _itemDescriptionLabel = [[BSStrikeLabel alloc] initWithFrame:CGRectNull];
    
    if (_itemDescriptionLabel) {
        _itemDescriptionLabel.textColor = [UIColor whiteColor];
        _itemDescriptionLabel.font = [UIFont boldSystemFontOfSize:16];
        _itemDescriptionLabel.backgroundColor = [UIColor clearColor];
        [self addSubview: _itemDescriptionLabel];
    }
    
    // Remove the default selected cells' blue highlight
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return self;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    // ensure the gradient layers occupies the full bounds
    _gradientLayer.frame = self.bounds;
    _itemCompletedLayer.frame = self.bounds;
    _itemDescriptionLabel.frame = CGRectMake(LABEL_LEFT_MARGIN, 0,
                              self.bounds.size.width - LABEL_LEFT_MARGIN,self.bounds.size.height);
    
    _tick.frame = CGRectMake(-UI_CUES_WIDTH - UI_CUES_MARGIN, 0,
                                  UI_CUES_WIDTH, self.bounds.size.height);
    _cross.frame = CGRectMake(self.bounds.size.width + UI_CUES_MARGIN, 0,
                                   UI_CUES_WIDTH, self.bounds.size.height);
}

#pragma mark - horizontal pan gesture methods
-(BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer {
    CGPoint translation = [gestureRecognizer translationInView:[self superview]];
    // Check for horizontal gesture
    if (fabsf(translation.x) > fabsf(translation.y)) {
        return YES;
    }
    return NO;
}

-(void)handlePan:(UIPanGestureRecognizer *)recognizer {
    
    // Gesture just start
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        // Record the current center position
        _originalCenter = self.center;
    }
    
    // Gesture changed state
    if (recognizer.state == UIGestureRecognizerStateChanged) {
        // Get the current center position
        CGPoint translation = [recognizer translationInView:self];
        self.center = CGPointMake(_originalCenter.x + translation.x, _originalCenter.y);
        
        _completed = self.frame.origin.x > self.frame.size.width / 3;
        
        // Check whether the item has been dragged far enough to initiate a delete / complete
        _deleted = self.frame.origin.x < -self.frame.size.width / 3;
        
        // fade the contextual cues
        float cueAlpha = fabsf(self.frame.origin.x) / (self.frame.size.width / 3);
        _tick.alpha = cueAlpha;
        _cross.alpha = cueAlpha;
        
        // Change action state based on condition
        _tick.textColor = _completed ? [UIColor greenColor] : [UIColor whiteColor];
        _cross.textColor = _deleted ? [UIColor redColor] : [UIColor whiteColor];
    }
    
    // Gesture ended
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        // The original cell frame
        CGRect originalFrame = CGRectMake(0, self.frame.origin.y, self.bounds.size.width, self.bounds.size.height);
        
        if (!_deleted) {
            // Move to original position if not deleted
            [UIView animateWithDuration:0.2 animations:^{
                                                            self.frame = originalFrame;
                                                        }
             ];
        }
        
        if (_completed) {
            // Mark the item as completed and update the UI
            self.todoItem.completed = YES;
            _itemCompletedLayer.hidden = NO;
            _itemDescriptionLabel.strikethrough = YES;
        }
        
        if (_deleted) {
            // delete selected cell item
            [self.delegate toDoItemDeleted:self.todoItem];
        }
    }
}

@end
