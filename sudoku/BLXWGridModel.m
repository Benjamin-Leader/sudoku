//
//  BLXWGridModel.m
//  sudoku
//
//  Created by Ben Leader on 9/18/14.
//  Copyright (c) 2014 Benjamin Leader and Hannah Long. All rights reserved.
//

#import "BLXWGridModel.h"

@implementation BLXWGridModel


int cells[9][9]={
    {7,0,0,4,2,0,0,0,9},
    {0,0,9,5,0,0,0,0,4},
    {0,2,0,6,9,0,5,0,0},
    {6,5,0,0,0,0,4,3,0},
    {0,8,0,0,0,6,0,0,7},
    {0,1,0,0,4,5,6,0,0},
    {0,0,0,8,6,0,0,0,2},
    {3,4,0,9,0,0,1,0,0},
    {8,0,0,3,0,2,7,4,0}
};

int initialCells[9][9]={
    {1,0,0,1,1,0,0,0,1},
    {0,0,1,1,0,0,0,0,1},
    {0,1,0,1,1,0,1,0,0},
    {1,1,0,0,0,0,1,1,0},
    {0,1,0,0,0,1,0,0,1},
    {0,1,0,0,1,1,1,0,0},
    {0,0,0,1,1,0,0,0,1},
    {1,1,0,1,0,0,1,0,0},
    {1,0,0,1,0,1,1,1,0}
};

- (void) generateGrid {
  
  NSString* file;
  
  if ((arc4random() % 2) == 1) {
    file = @"grid1";
  } else {
    file = @"grid2";
  }
  
  NSString* path = [[NSBundle mainBundle] pathForResource:file ofType:@"txt"];
  NSError* error;
  
  NSString* readString =[[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
  
  NSArray* possibleGrids = [readString componentsSeparatedByString:@"\n"];
  
  NSUInteger numberOfGrids = [possibleGrids count];
  
  NSInteger gridIndex = arc4random() % numberOfGrids;
  
  NSString* gridString = possibleGrids[gridIndex];
  
  for (int cell = 0; cell < 81; ++cell ) {
    NSString* oneCharSubstring = [gridString substringWithRange:NSMakeRange(cell, 1)];
    
    
    if ([oneCharSubstring isEqual: @"."]) {
      cells[cell%9][cell/9] = 0;
      initialCells[cell%9][cell/9] = 0;
    } else {
      cells[cell%9][cell/9] = [[gridString substringWithRange:NSMakeRange(cell, 1)] integerValue];
      initialCells[cell%9][cell/9] = 1;
    }
  }
}

- (int) getValueAtRow: (int)row Column: (int)column {

  return cells[column][row];
}

- (void) setValueAtRow: (int)row Column: (int)column to: (int)newValue {

  cells[column][row] = newValue;
  NSAssert(newValue < 10, @"Invalid: input is too large");
  NSAssert(newValue >= 0, @"Invalid: input is too small");
}

- (BOOL) isMutableAtRow: (int)row Column: (int)column {
  if (initialCells[column][row] == 0) {
    return YES;
  } else {
    return NO;
  }
}

- (BOOL) isConsistentAtRow: (int)row Column: (int)column for: (int)value
{
    
    NSAssert(value < 10, @"Invalid: input is too large");
    NSAssert(value > 0, @"Invalid: input is too small");
    
    // Check values in the selected row and column
    for (int i = 0; i < 9; ++i){
        if (cells[i][row] == value) {
            return NO;
        }
        // NSLog(@"number in the column box: %d", cells[column][i]);
    }
  
  // Check values in the selected row and column
  for (int i = 0; i < 9; ++i){
    if (cells[column][i] == value) {
      return NO;
    }
  }
  
    int subRow = column/3;
    int subColumn = row/3;
    
    // Check values in subgrid
    for (int currentRow = 0; currentRow < 3; ++currentRow) {
        for (int currentColumn = 0; currentColumn < 3; ++currentColumn) {
            if (cells[currentRow + 3*subRow][currentColumn + 3*subColumn] == value) {
                return NO;
            }
        }
    }
    
  return YES;
}

@end
