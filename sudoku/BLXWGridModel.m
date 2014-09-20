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

- (void) generateGrid {
    
}

- (int) getValueAtRow: (int)row Column: (int)column {
  return 1;
}

- (void) setValueAtRow: (int)row Column: (int)column to: (int)newValue {
  
}

- (BOOL) isMutableAtRow: (int)row Column: (int)column {
  return YES;
}

- (BOOL) isConsistentAtRow: (int)row Column: (int)column {
  return YES;
}

@end
