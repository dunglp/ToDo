//
//  BSStrikeLabel.m
//  ToDo
//
//  Created by Bi on 3/15/13.
//  Copyright (c) 2013 BiStudio. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "BSStrikeLabel.h"

@implementation BSStrikeLabel {
    bool _strikethrough;
    CALayer* _strikethroughLayer;
}

const float STRIKEOUT_THICKNESS = 1.5f;

-(id) initWithFrame: (CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _strikethroughLayer = [CALayer layer];
        _strikethroughLayer.backgroundColor = [[UIColor whiteColor] CGColor];
        _strikethroughLayer.hidden = YES;
        [self.layer addSublayer:_strikethroughLayer];
    }
    return self;
}

-(void) layoutSubviews {
    [super layoutSubviews];
    [self resizeStrikeThrough];
}

-(void) setText: (NSString *)text {
    [super setText:text];
    [self resizeStrikeThrough];
}

// Resize the strikethrough layer to match the current label description
-(void) resizeStrikeThrough {
    CGSize textSize = [self.text sizeWithFont:self.font];
    _strikethroughLayer.frame = CGRectMake(0, self.bounds.size.height/2, textSize.width, STRIKEOUT_THICKNESS);
}

-(void) setStrikethrough: (bool)strikethrough {
    _strikethrough = strikethrough;
    _strikethroughLayer.hidden = !strikethrough;
}

@end