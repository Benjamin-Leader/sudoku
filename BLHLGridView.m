//
//  BLHLGridView.m
//  sudoku
//
//  Created by Ben Leader on 9/12/14.
//  Copyright (c) 2014 Benjamin Leader and Hannah Long. All rights reserved.
//

#import "BLHLGridView.h"

@implementation BLHLGridView

NSMutableArray* gridButtons;

CGFloat BLHLButtonSizeRatio = 12.0;
CGFloat BLHLLargeBoundaryRatio = 24.0;
CGFloat BLHLSmallBoundaryRatio = 72.0;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // Create array to hold cells
        gridButtons = [NSMutableArray array];
        
        // Initialize ratios for cell placement
        CGFloat buttonSize = frame.size.width/BLHLButtonSizeRatio;
        CGFloat largeBoundary = frame.size.width/BLHLLargeBoundaryRatio;
        CGFloat smallBoundary = frame.size.width/BLHLSmallBoundaryRatio;
        
        CGFloat columnLeftMargin = 0.0;
        // create each column of buttons
        for (int column = 1; column <= 9; ++column) {
            
            // Shift over by large boundary every third cell. Otherwise, shift by small boundary
            if (column%3 == 1) {
                columnLeftMargin = columnLeftMargin + largeBoundary;
            } else {
                columnLeftMargin = columnLeftMargin + smallBoundary;
            }
            
            CGFloat rowTopMargin = 0.0;
            
            // create each row of buttons
            for (int row = 1; row <= 9; ++row) {
                
                // Shift down by large boundary every third cell. Otherwise, shift by small boundary
                if (row%3 == 1) {
                    rowTopMargin = rowTopMargin + largeBoundary;
                } else {
                    rowTopMargin = rowTopMargin + smallBoundary;
                }
                
                // create a button in the current cell ([col][row])
                UIButton *btn = [self makeButtonWithSize: buttonSize withXCoord:columnLeftMargin andYCoord:rowTopMargin];
                btn.tag = column*10+row;
                
                // Add button to the button array
                [gridButtons addObject:(UIButton*) btn];
                btn.tag = column*10+row;
                
                NSLog(@"tag: %d", btn.tag);
                
                
                rowTopMargin = rowTopMargin + buttonSize;
            }
            
            columnLeftMargin = columnLeftMargin + buttonSize;
        }
    }
    
    return self;
}

- (UIButton*)makeButtonWithSize:(CGFloat)size withXCoord: (CGFloat)x andYCoord: (CGFloat)y
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];

    // initialize button with default cell properties
    CGRect buttonFrame = CGRectMake(x, y, size, size);
    button = [[UIButton alloc] initWithFrame:buttonFrame];
    button.backgroundColor = [UIColor whiteColor];
    [button setBackgroundImage:[self imageWithColor:[UIColor greenColor]] forState:UIControlStateHighlighted];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self addSubview:button];
    
    // create target for button
    [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

- (void)buttonPressed:(UIButton*)sender
{
    UIButton *btn = (UIButton *)sender;
    NSLog(@"Button %d was pressed", btn.tag);
}


- (void)setValueAtRow: (int)row column: (int)column to: (NSInteger)value
{
    NSString *newVal = [NSString stringWithFormat:@"%d", value];
    
    // Insert new number into row if there is an appropriate value
    if (value > 0){
        [gridButtons[(column-1)*9+(row-1)] setTitle:(newVal) forState:(UIControlState)UIControlStateNormal];
    }
}

// used to create highlighted background for button
- (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
