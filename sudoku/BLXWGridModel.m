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
    
}

- (int) getValueAtRow: (int)row Column: (int)column {
  return cells[row][column];
}

- (void) setValueAtRow: (int)row Column: (int)column to: (int)newValue {
  cells[row][column] = newValue;
}

- (BOOL) isMutableAtRow: (int)row Column: (int)column {
  if (initialCells[row][column] == 0) {
    return YES;
  } else {
    return NO;
  }
}

- (BOOL) isConsistentAtRow: (int)row Column: (int)column for: (int)value {
    
    // Check values in the selected row and column
    for (int i = 0; i < 9; ++i){
        if ((cells[row][i] == value) || (cells[i][column] == value)) {
            return NO;
        }
    }
    int subColumn = column/3;
    int subRow = row/3;
    
    // Check values in subgrid
    for (int currentColumn = 0; currentColumn < 3; ++currentColumn) {
        for (int currentRow = 0; currentRow < 3; ++currentRow) {
            if (cells[currentRow + 3*subRow][currentColumn + 3*subColumn] == value) {
                return NO;
            }
        }
    }
    
  return YES;
}

@end
