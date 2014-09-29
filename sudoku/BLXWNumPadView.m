//
//  BLXWNumPadView.m
//  sudoku
//
//  Created by 王小天 on 14-9-19.
//  Copyright (c) 2014年 Benjamin Leader and Hannah Long. All rights reserved.
//

#import "BLXWNumPadView.h"

@implementation BLXWNumPadView

NSMutableArray* numPadButtons;
NSMutableArray* cells;
int currentValue;

CGFloat BLXWButtonSizeRatio = 12.0;
CGFloat BLXWLargeBoundaryRatio = 28.5;
CGFloat BLXWSmallBoundaryRatio = 44.0;


- (id)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    
    // Create array to hold cells
    numPadButtons = [NSMutableArray array];
    
    // Initialize ratios for cell placement
    CGFloat buttonSize = frame.size.width/BLXWButtonSizeRatio;
    CGFloat largeBoundary = frame.size.width/BLXWLargeBoundaryRatio;
    CGFloat smallBoundary = frame.size.width/BLXWSmallBoundaryRatio;
    CGFloat topBoundary = (frame.size.height-buttonSize)/2.0;
    
    CGFloat columnLeftMargin = 0.0;
    CGFloat rowTopMargin = topBoundary;
    
    // create each column of buttons
    for (int column = 1; column <= 9; ++column) {
      
      // Shift over by large boundary at the fisrt cell. Otherwise, shift by small boundary
      if (column == 1) {
        columnLeftMargin = columnLeftMargin + largeBoundary;
      } else {
        columnLeftMargin = columnLeftMargin + smallBoundary;
      }
      
      // create a button in the current cell ([col][row])
      UIButton *btn = [self makeButtonWithSize: buttonSize withXCoord:columnLeftMargin andYCoord:rowTopMargin];
      btn.tag = column;
      
      // Add button to the button array
      [numPadButtons addObject:(UIButton*) btn];
      btn.tag = column;
      
      columnLeftMargin = columnLeftMargin + buttonSize;
        
      [self highlightButton:numPadButtons[0]];
      currentValue = 1;
    }
  }
  
  return self;
}


- (UIButton*)makeButtonWithSize:(CGFloat)size withXCoord: (CGFloat)x andYCoord: (CGFloat)y
{
  UIButton *button;
  
  // initialize button with default cell properties
  CGRect buttonFrame = CGRectMake(x, y, size, size);
  button = [[UIButton alloc] initWithFrame:buttonFrame];
  button.backgroundColor = [UIColor whiteColor];
  [button setBackgroundImage:[self imageWithColor:[UIColor yellowColor]] forState:UIControlStateHighlighted];
  [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
  [button setImage:[self imageWithColor:[UIColor yellowColor]] forState:UIControlStateSelected];
  [self addSubview:button];
  
  // create target for button
  [button addTarget:self action:@selector(cellSelected:) forControlEvents:UIControlEventTouchUpInside];
  
  return button;
}


- (void)highlightButton:(UIButton *)b {
    if (!b.highlighted) {
        [b setHighlighted:YES];
    }
    UIButton* btn;
    for (btn in numPadButtons) {
        if (btn.tag != b.tag && btn.highlighted) {
            [btn setHighlighted:NO];
        }
    }
}


- (void)cellSelected:(UIButton*)sender
{
  UIButton *btn = (UIButton *)sender;
  [self performSelector:@selector(highlightButton:) withObject:sender afterDelay:0.0];
  NSString *buttonValue =[[NSString alloc]initWithFormat:@"%ld",(long)sender.tag];
  currentValue = [buttonValue intValue];
  NSLog(@"Current value is %d", currentValue);
}


- (void)setValueAtColumn: (int)column to: (NSInteger)value
{
  NSString *newVal = [NSString stringWithFormat:@"%ld", (long)value];
  
  // Insert new number into row if there is an appropriate value
  if (value > 0){
    [numPadButtons[column] setTitle:(newVal) forState:(UIControlState)UIControlStateNormal];
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


- (int) getCurrentValue
{
  return currentValue;
}

@end
