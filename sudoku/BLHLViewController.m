//
//  BLHLViewController.m
//  sudoku
//
//  Created by Ben Leader on 9/11/14.
//  Copyright (c) 2014 Benjamin Leader and Hannah Long. All rights reserved.
//

#import "BLHLGridView.h"
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
    
    // put initial values into appropriate cells
    for (int col = 1; col < 10; ++col) {
        for (int row = 1; row < 10; ++row) {
            [_gridView setValueAtRow: row column: col to: initialGrid[col-1][row-1]];
        }
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}



@end
