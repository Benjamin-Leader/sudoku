//
//  BLXWNumPadView.h
//  sudoku
//
//  Created by 王小天 on 14-9-19.
//  Copyright (c) 2014年 Benjamin Leader and Hannah Long. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BLXWNumPadView: UIView

- (void)setValueAtColumn: (int)column to: (NSInteger)value;
- (int) getCurrentValue;

@end
