//
//  BLHLViewController.m
//  sudoku
//
//  Created by Ben Leader on 9/11/14.
//  Copyright (c) 2014 Benjamin Leader and Hannah Long. All rights reserved.
//

#import "BLHLGridView.h"
#import "BLXWNumPadView.h"
#import "BLHLViewController.h"


int initialGrid[9][9]={
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

@interface BLHLViewController () {
    BLHLGridView* _gridView;
  BLXWNumPadView* _numPadView;
}

@end

@implementation BLHLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //create grid frame
    CGRect frame = self.view.frame;
    CGFloat x = CGRectGetWidth(frame)*.1;
    CGFloat y = CGRectGetHeight(frame)*.1;
    CGFloat size = MIN(CGRectGetWidth(frame), CGRectGetHeight(frame))*.80;
    
    CGRect gridFrame = CGRectMake(x, y, size, size);
    
    // create grid view
    _gridView = [[BLHLGridView alloc] initWithFrame:gridFrame];
    _gridView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_gridView];
//    [_gridView addTarget:self action:@selector(gridCellSelected:) forUIEvent:cellSelected];
    
    // put initial values into appropriate cells
    for (int col = 1; col < 10; ++col) {
        for (int row = 1; row < 10; ++row) {
            [_gridView setValueAtRow: row column: col to: initialGrid[col-1][row-1]];
        }
    }
  
  //create numPad frame
  CGFloat numPadx = CGRectGetWidth(frame)*.1;
  CGFloat numPady = CGRectGetHeight(frame)*.2 + size;
  CGFloat numPadWidth = MIN(CGRectGetWidth(frame), CGRectGetHeight(frame))*.80;
  CGFloat numPadHeight = MIN(CGRectGetWidth(frame), CGRectGetHeight(frame))*.80/9.0;
  
  CGRect myNumPadFrame = CGRectMake(numPadx, numPady, numPadWidth, numPadHeight);
  
  // create numpad view
  _numPadView = [[BLXWNumPadView alloc] initWithFrame:myNumPadFrame];
  _numPadView.backgroundColor = [UIColor blackColor];
  [self.view addSubview:_numPadView];
  
  for (int col = 1; col <= 9; ++col) {
    [_numPadView setValueAtColumn: col-1 to:col];
  }
  
}

- (void) gridCellSelected: (BLHLGridView*)sender
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}



@end
