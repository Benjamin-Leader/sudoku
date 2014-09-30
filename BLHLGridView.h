//
//  BLHLGridView.h
//  sudoku
//
//  Created by Ben Leader on 9/12/14.
//  Copyright (c) 2014 Benjamin Leader and Hannah Long. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BLHLGridView : UIView

- (void) setValueAtRow: (int)row column: (int)column to: (NSInteger)value;
- (void)setInitialValueAtRow: (int)row column: (int)column to: (NSInteger)value;
- (UIImage *)imageWithColor:(UIColor *)color;
- (void) cellSelected: (UIButton*)sender;
- (void)setTarget: (id)target : (SEL)action;
- (void)setAllSameButtonHighlighted:(int)curValue;
- (void)setAllSameButtonNotHighlighted:(int)curValue;

@end
