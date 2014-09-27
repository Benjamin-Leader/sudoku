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
#import "BLXWGridModel.h"


@interface BLHLViewController () {
  BLHLGridView* _gridView;
  BLXWNumPadView* _numPadView;
  BLXWGridModel* _gridModel;
}

@end

@implementation BLHLViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  //create grid Model
  _gridModel = [[BLXWGridModel alloc] init];
  [_gridModel generateGrid];
  
  
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
  [_gridView setTarget:self :@selector(gridCellSelected:)];
  
  // put initial values into appropriate cells
  for (int col = 0; col < 9; ++col) {
    for (int row = 0; row < 9; ++row) {
      [_gridView setInitialValueAtRow: row column: col to: [_gridModel getValueAtRow:row Column:col]];
    }
  }
  
  //create numPad frame
  CGFloat numPadx = CGRectGetWidth(frame)*.1;
  CGFloat numPady = CGRectGetHeight(frame)*.15 + size;
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
  
  // create new game button
  CGFloat newGamePadx = CGRectGetWidth(frame)*.18;
  CGFloat newGamePady = CGRectGetHeight(frame)*.18 + size + numPadHeight;
  CGFloat newGamePadWidth = MIN(CGRectGetWidth(frame), CGRectGetHeight(frame))*.30;
  CGFloat newGamePadHeight = MIN(CGRectGetWidth(frame), CGRectGetHeight(frame))*.80/9.0;
  
  CGRect newGameFrame = CGRectMake(newGamePadx, newGamePady, newGamePadWidth, newGamePadHeight);
  
  UIButton* newGameButton = [[UIButton alloc] initWithFrame:newGameFrame];
  newGameButton.backgroundColor = [UIColor greenColor];
  [newGameButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
  [newGameButton setTitle:@"New Game" forState:UIControlStateNormal];
  [self.view addSubview:newGameButton];
  [newGameButton addTarget:self action:@selector(startNewGame:) forControlEvents:UIControlEventTouchUpInside];
  
  // create restart button
  CGFloat restartx = CGRectGetWidth(frame)*.22 + newGamePadWidth;
  CGFloat restarty = CGRectGetHeight(frame)*.18 + size + numPadHeight;
  CGFloat restartWidth = MIN(CGRectGetWidth(frame), CGRectGetHeight(frame))*.30;
  CGFloat restartHeight = MIN(CGRectGetWidth(frame), CGRectGetHeight(frame))*.80/9.0;
  
  CGRect restartFrame = CGRectMake(restartx, restarty, restartWidth, restartHeight);
  
  UIButton* restartButton = [[UIButton alloc] initWithFrame:restartFrame];
  restartButton.backgroundColor = [UIColor redColor];
  [restartButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
  [restartButton setTitle:@"Restart" forState:UIControlStateNormal];
  [self.view addSubview:restartButton];
  [restartButton addTarget:self action:@selector(clearGrid:) forControlEvents:UIControlEventTouchUpInside];
}


- (void) gridCellSelected: (NSNumber*)tag
{
  NSLog(@"gridCellSelected, %@", tag);
  int value = [_numPadView getCurrentValue];
  int tagInt = [tag integerValue];
  int column = tagInt/10-1;
  int row = tagInt%10-1;
  NSLog(@"Row is %d and column is %d", row, column);
  
  NSLog(@"\n");
  
  if ([_gridModel isConsistentAtRow: row Column: column for: value] && [_gridModel isMutableAtRow:row Column:column]){
    [_gridModel setValueAtRow:row Column:column to:value];
    [_gridView setValueAtRow:row column:column to:value];
  }
}

- (void)startNewGame:(UIButton*)sender
{
  [_gridModel generateGrid];
  
  // put initial values into appropriate cells
  for (int col = 0; col < 9; ++col) {
    for (int row = 0; row < 9; ++row) {
      [_gridView setValueAtRow:row column:col to:0];
      [_gridView setInitialValueAtRow: row column: col to: [_gridModel getValueAtRow:row Column:col]];
    }
  }
}

- (void)clearGrid:(UIButton*)sender
{
  for (int col = 0; col < 9; ++col) {
    for (int row = 0; row < 9; ++row) {
      //[_gridView setValueAtRow: row column: col to: 0];
      
      if ([_gridModel isMutableAtRow:row Column:col]) {
        //NSLog(@"grid at row: %d and col: %d is mutable, and is: %d",row, col, [_gridModel getValueAtRow:row Column:col] );
        [_gridModel setValueAtRow:row Column:col to:0];
        [_gridView setValueAtRow: row column: col to: 0];
      }
    }
  }
}


- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
}



@end
