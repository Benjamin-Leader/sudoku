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
  
  self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ipad-wallpaper4.png"]];
  
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
  
  // Create Sudoku Label
  CGFloat labelx = CGRectGetWidth(frame)*.30;
  CGFloat labely = CGRectGetHeight(frame)*.02;
  CGFloat labelWidth = MIN(CGRectGetWidth(frame), CGRectGetHeight(frame))*.40;
  CGFloat labelHeight = MIN(CGRectGetWidth(frame), CGRectGetHeight(frame))*.80/9.0;
  
  CGRect labelFrame = CGRectMake(labelx, labely, labelWidth, labelHeight);
  
  UILabel* SudokuLabel = [[UILabel alloc] initWithFrame:labelFrame];
  [SudokuLabel setBackgroundColor:[UIColor clearColor]];
  [SudokuLabel setAlpha:0.88];
  SudokuLabel.text = @"~ Sudoku Fun ~";
  SudokuLabel.font = [UIFont boldSystemFontOfSize:36.0f];
  SudokuLabel.textColor = [UIColor yellowColor];
  SudokuLabel.textAlignment =  NSTextAlignmentCenter;
  [self.view addSubview:SudokuLabel];
  
  // create new game button
  CGFloat newGamePadx = CGRectGetWidth(frame)*.15;
  CGFloat newGamePady = CGRectGetHeight(frame)*.18 + size + numPadHeight;
  CGFloat newGamePadWidth = MIN(CGRectGetWidth(frame), CGRectGetHeight(frame))*.25;
  CGFloat newGamePadHeight = MIN(CGRectGetWidth(frame), CGRectGetHeight(frame))*.80/9.0;
  
  CGRect newGameFrame = CGRectMake(newGamePadx, newGamePady, newGamePadWidth, newGamePadHeight);
  
  UIButton* newGameButton = [[UIButton alloc] initWithFrame:newGameFrame];
  [newGameButton setBackgroundImage:[UIImage imageNamed:@"rainbow1.png"] forState:UIControlStateNormal];
  [newGameButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
  [newGameButton setTitle:@"New Game" forState:UIControlStateNormal];
  [newGameButton setTitleShadowColor:[UIColor grayColor] forState:UIControlStateNormal];
  [newGameButton setBackgroundImage:[UIImage imageNamed:@"rainbow1H.png"] forState:UIControlStateHighlighted];
  [self.view addSubview:newGameButton];
  [newGameButton addTarget:self action:@selector(startNewGame:) forControlEvents:UIControlEventTouchUpInside];
  
  // create restart button
  CGFloat restartx = CGRectGetWidth(frame)*.20 + newGamePadWidth;
  CGFloat restarty = CGRectGetHeight(frame)*.18 + size + numPadHeight;
  CGFloat restartWidth = MIN(CGRectGetWidth(frame), CGRectGetHeight(frame))*.25;
  CGFloat restartHeight = MIN(CGRectGetWidth(frame), CGRectGetHeight(frame))*.80/9.0;
  
  CGRect restartFrame = CGRectMake(restartx, restarty, restartWidth, restartHeight);
  
  UIButton* restartButton = [[UIButton alloc] initWithFrame:restartFrame];
  [restartButton setBackgroundImage:[UIImage imageNamed:@"rainbow2.png"] forState:UIControlStateNormal];
  [restartButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
  [restartButton setTitle:@"Restart" forState:UIControlStateNormal];
  [restartButton setTitleShadowColor:[UIColor grayColor] forState:UIControlStateNormal];
  [restartButton setBackgroundImage:[UIImage imageNamed:@"rainbow2H.png"] forState:UIControlStateHighlighted];
  [self.view addSubview:restartButton];
  [restartButton addTarget:self action:@selector(clearGrid:) forControlEvents:UIControlEventTouchUpInside];
  
  // Easy mode switch
  CGFloat switchx = CGRectGetWidth(frame)*.28 + newGamePadWidth + restartWidth;
  CGFloat switchy = CGRectGetHeight(frame)*.18 + size + numPadHeight + 29;
  CGFloat switchWidth = MIN(CGRectGetWidth(frame), CGRectGetHeight(frame))*.25;
  CGFloat switchHeight = MIN(CGRectGetWidth(frame), CGRectGetHeight(frame))*.80/9.0;
  
  CGRect switchFrame = CGRectMake(switchx, switchy, switchWidth, switchHeight);
  
  UISwitch* easyMode = [[UISwitch alloc] initWithFrame:switchFrame];
  [easyMode addTarget:self action:@selector(changeEasyMode:) forControlEvents:UIControlEventValueChanged];
  
  [self.view addSubview:easyMode];
  
  CGFloat switchLx = CGRectGetWidth(frame)*.26 + newGamePadWidth + restartWidth;
  CGFloat switchLy = CGRectGetHeight(frame)*.18 + size + numPadHeight;
  CGFloat switchLWidth = MIN(CGRectGetWidth(frame), CGRectGetHeight(frame))*.20;
  CGFloat switchLHeight = MIN(CGRectGetWidth(frame), CGRectGetHeight(frame))*.80/30.0;
  
  CGRect switchLFrame = CGRectMake(switchLx, switchLy, switchLWidth, switchLHeight);
  
  UILabel* switchL = [[UILabel alloc] initWithFrame:switchLFrame];
  switchL.text = @"Easy Mode";
  
  [self.view addSubview:switchL];
  
}


- (void) gridCellSelected: (NSNumber*)tag
{
  int value = [_numPadView getCurrentValue];
  int tagInt = [tag integerValue];
  int column = tagInt/10-1;
  int row = tagInt%10-1;
  
  if ([_gridModel isConsistentAtRow: row Column: column for: value] && [_gridModel isMutableAtRow:row Column:column]){
    [_gridModel setValueAtRow:row Column:column to:value];
    [_gridView setValueAtRow:row column:column to:value];
  }
}


- (void)startNewGame:(UIButton*)sender
{
  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"My Alert"
                                                  message:@"Are you sure to start a new game?"
                                                 delegate:self
                                        cancelButtonTitle:@"YES"
                                        otherButtonTitles:@"NO", nil];
  [alert show];
}


-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
  if (buttonIndex == 0) {
    [_gridModel generateGrid];
    
    // put initial values into appropriate cells
    for (int col = 0; col < 9; ++col) {
      for (int row = 0; row < 9; ++row) {
        [_gridView setValueAtRow:row column:col to:0];
        [_gridView setInitialValueAtRow: row column: col to: [_gridModel getValueAtRow:row Column:col]];
      }
    }
  } else {
    NSLog(@"cancel");
  }
}


- (void)clearGrid:(UIButton*)sender
{
  for (int col = 0; col < 9; ++col) {
    for (int row = 0; row < 9; ++row) {
      
      if ([_gridModel isMutableAtRow:row Column:col]) {
        [_gridModel setValueAtRow:row Column:col to:0];
        [_gridView setValueAtRow: row column: col to: 0];
      }
    }
  }
}


- (void)changeEasyMode:(UISwitch *)sender
{
  int curValue = [_numPadView getCurrentValue];
  
  if (sender.on) {
    [_gridView setAllSameButtonHighlighted:curValue];
    
  } else {
    [_gridView setAllSameButtonNotHighlighted:curValue];
  }
}


- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
}


- (BOOL)prefersStatusBarHidden {
  return YES; }

@end
