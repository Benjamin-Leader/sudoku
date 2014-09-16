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

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        gridButtons = [NSMutableArray array];
        
        // Initialization code
        CGFloat buttonSize = frame.size.width/12.0;
        CGFloat largeBoundary = frame.size.width/24.0;
        CGFloat smallBoundary = frame.size.width/72.0;
        
        NSInteger counter = 1;
        CGFloat colX = 0.0;
        // create each column of buttons
        while (counter <= 9) {
            
            
            if (counter%3 == 1) {
                colX = colX + largeBoundary;
            } else {
                colX = colX + smallBoundary;
            }
            
            NSInteger counter2 = 1;
            CGFloat rowY = 0.0;
            
                while (counter2 <= 9) {
                if (counter2%3 == 1) {
                    rowY = rowY + largeBoundary;
                } else {
                    rowY = rowY + smallBoundary;
                }
                
                UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                
                [self setButton:button withSize: buttonSize withXCoord:colX andYCoord:rowY];
                button.tag = counter*10+counter2;
                
                [gridButtons addObject:(UIButton*) button];
                //UIButton *btn = (UIButton *)gridButtons[(counter-1)*10 + counter2 - 1];
                //btn.tag = counter*10+counter2;
                
                NSLog(@"tag: %d", button.tag);

                
                counter2++;
                rowY = rowY + buttonSize;
            }
          
            counter++;
            colX = colX + buttonSize;
        }
    }
    
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)setButton: (UIButton*) button withSize:(CGFloat)size withXCoord: (CGFloat)x andYCoord: (CGFloat)y
{
    CGRect buttonFrame = CGRectMake(x, y, size, size);
    button = [[UIButton alloc] initWithFrame:buttonFrame];
    button.backgroundColor = [UIColor whiteColor];
    button.showsTouchWhenHighlighted = true;
    [button setTitle:(NSString *)@"1" forState:(UIControlState)UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self addSubview:button];
    
    // create target for button
    [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)buttonPressed:(UIButton*)sender
{
    UIButton *btn = (UIButton *)sender;
    NSLog(@"Button %d was pressed", btn.tag);
}


- (void)setValueAtRow: (int)row column: (int)column to: (NSInteger)value
{
    
    //[gridButtons[(row-1)*10+(column-1)] setTitle:(@"%d", value) forState:(UIControlState)UIControlStateNormal];
    
}

@end
