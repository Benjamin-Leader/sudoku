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
  UISwitch* _easyMode;
  int _totalSteps;
  int _leftSteps;
  UILabel* _statsLabel;
  NSMutableArray* _myStack;
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
  _gridView.backgroundColor = [UIColor clearColor];
  [self.view addSubview:_gridView];
  [_gridView setTarget:self :@selector(cellSelected:)];
  
  // put initial values into appropriate cells
  for (int col = 0; col < 9; ++col) {
    for (int row = 0; row < 9; ++row) {
      int gButtonValue = [_gridModel getValueAtRow:row Column:col];
      [_gridView setInitialValueAtRow: row column: col to: gButtonValue];
      if (gButtonValue == 0) {
        _totalSteps += 1;
      }
    }
  }
  
  // update total and left steps
  _leftSteps = _totalSteps;
  
  //create numPad frame
  CGFloat numPadx = CGRectGetWidth(frame)*.1;
  CGFloat numPady = CGRectGetHeight(frame)*.15 + size;
  CGFloat numPadWidth = MIN(CGRectGetWidth(frame), CGRectGetHeight(frame))*.80;
  CGFloat numPadHeight = MIN(CGRectGetWidth(frame), CGRectGetHeight(frame))*.80/9.0;
  
  CGRect myNumPadFrame = CGRectMake(numPadx, numPady, numPadWidth, numPadHeight);
  
  // create numpad view
  _numPadView = [[BLXWNumPadView alloc] initWithFrame:myNumPadFrame];
  _numPadView.backgroundColor = [UIColor clearColor];
  [self.view addSubview:_numPadView];
  
  for (int col = 1; col <= 9; ++col) {
    [_numPadView setValueAtColumn: col-1 to:col];
  }
  
  [_numPadView setTarget:self :@selector(cellSelected:)];
  
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
  
  _easyMode = [[UISwitch alloc] initWithFrame:switchFrame];
  [_easyMode addTarget:self action:@selector(changeEasyMode:) forControlEvents:UIControlEventValueChanged];
  
  [self.view addSubview:_easyMode];
  
  CGFloat switchLx = CGRectGetWidth(frame)*.26 + newGamePadWidth + restartWidth;
  CGFloat switchLy = CGRectGetHeight(frame)*.18 + size + numPadHeight;
  CGFloat switchLWidth = MIN(CGRectGetWidth(frame), CGRectGetHeight(frame))*.20;
  CGFloat switchLHeight = MIN(CGRectGetWidth(frame), CGRectGetHeight(frame))*.80/30.0;
  
  CGRect switchLFrame = CGRectMake(switchLx, switchLy, switchLWidth, switchLHeight);
  
  UILabel* switchL = [[UILabel alloc] initWithFrame:switchLFrame];
  switchL.text = @"Easy Mode";
  
  [self.view addSubview:switchL];
  
  // create stats label
  CGFloat statsLabelx = CGRectGetWidth(frame)*.30;
  CGFloat statsLabely = CGRectGetHeight(frame)*.113 + size;
  CGFloat statsLabelWidth = MIN(CGRectGetWidth(frame), CGRectGetHeight(frame))*.40;
  CGFloat statsLabelHeight = MIN(CGRectGetWidth(frame), CGRectGetHeight(frame))*.80/28.0;
  
  CGRect statsLabelFrame = CGRectMake(statsLabelx, statsLabely, statsLabelWidth, statsLabelHeight);
  
  _statsLabel = [[UILabel alloc] initWithFrame:statsLabelFrame];
  [_statsLabel setBackgroundColor:[UIColor clearColor]];
  [_statsLabel setAlpha:0.88];
  NSString* myStats = [[NSString alloc] initWithFormat:@"total: %d -- Left: %d" , _totalSteps, _leftSteps];
  _statsLabel.text = myStats;
  _statsLabel.font = [UIFont boldSystemFontOfSize:25.0f];
  _statsLabel.textColor = [UIColor yellowColor];
  _statsLabel.textAlignment =  NSTextAlignmentCenter;
  [self.view addSubview:_statsLabel];
  
  // create undo and redo button
  CGFloat undox = CGRectGetWidth(frame)*.1;
  CGFloat undoy = CGRectGetHeight(frame)*.113 + size;
  CGFloat undoWidth = MIN(CGRectGetWidth(frame), CGRectGetHeight(frame))*.10;
  CGFloat undoHeight = MIN(CGRectGetWidth(frame), CGRectGetHeight(frame))*.80/28.0;
  
  CGRect undoFrame = CGRectMake(undox, undoy, undoWidth, undoHeight);
  
  UIButton* undoButton = [[UIButton alloc] initWithFrame:undoFrame];
  [undoButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
  [undoButton setTitle:@"<- Undo" forState:UIControlStateNormal];
  [undoButton setTitleShadowColor:[UIColor grayColor] forState:UIControlStateNormal];
  undoButton.showsTouchWhenHighlighted = YES;
  [self.view addSubview:undoButton];
  [undoButton addTarget:self action:@selector(undoStep) forControlEvents:UIControlEventTouchUpInside];
  
  
  CGFloat redox = CGRectGetWidth(frame)*.1 + numPadWidth - undoWidth;
  CGFloat redoy = CGRectGetHeight(frame)*.113 + size;
  CGFloat redoWidth = MIN(CGRectGetWidth(frame), CGRectGetHeight(frame))*.10;
  CGFloat redoHeight = MIN(CGRectGetWidth(frame), CGRectGetHeight(frame))*.80/28.0;
  
  CGRect redoFrame = CGRectMake(redox, redoy, redoWidth, redoHeight);
  
  UIButton* redoButton = [[UIButton alloc] initWithFrame:redoFrame];
  [redoButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
  [redoButton setTitle:@"Redo ->" forState:UIControlStateNormal];
  [redoButton setTitleShadowColor:[UIColor grayColor] forState:UIControlStateNormal];
  redoButton.showsTouchWhenHighlighted = YES;
  [self.view addSubview:redoButton];
  //[redoButton addTarget:self action:@selector(clearGrid:) forControlEvents:UIControlEventTouchUpInside];
  
  // initialize the array
  _myStack = [[NSMutableArray alloc] init];
}


- (void) cellSelected: (NSNumber*)tag
{
  
  int tagInt = [tag integerValue];
  if (tagInt < 10) {
    if (_easyMode.on) {
      [_gridView setAllSameButtonHighlighted:tagInt];
    }
  } else {
    int value = [_numPadView getCurrentValue];
    int column = tagInt/10-1;
    int row = tagInt%10-1;
    
    // when some cell could change
    if ([_gridModel isConsistentAtRow: row Column: column for: value] && [_gridModel isMutableAtRow:row Column:column]){
      // update the stats
      if ([_gridModel getValueAtRow:row Column:column] == 0) {
        _leftSteps -= 1;
      }
      
      // push the button into the stack
      // we have to do before change value
      int buttonValue = row*100 + column*10 + [_gridModel getValueAtRow:row Column:column];
      NSNumber* stackNumber = [[NSNumber alloc] initWithInteger:buttonValue];
      [self myPush:stackNumber to:_myStack];
      int countnum = [_myStack count];
      
      [_gridModel setValueAtRow:row Column:column to:value];
      [_gridView setValueAtRow:row column:column to:value];
    }
    if (_easyMode.on) {
      int curValue = [_numPadView getCurrentValue];
      [_gridView setAllSameButtonHighlighted:curValue];
    }
  }
  
  NSString* myStats = [[NSString alloc] initWithFormat:@"total: %d -- Left: %d" , _totalSteps, _leftSteps];
  _statsLabel.text = myStats;
  
  // check if win
  BOOL winning = [_gridModel isWin];
  NSLog(@"Do you win?  %d", winning);
  
  
  // update stats label
  if (winning == 1) {
    _statsLabel.text = @"You win!";
  }
  
  if (_leftSteps == 0 && winning == 0) {
    _statsLabel.text = @"Something wrong ==";
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
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:5];
    
    [_gridModel generateGrid];
    
    // put initial values into appropriate cells
    _totalSteps = 0;
    for (int col = 0; col < 9; ++col) {
      for (int row = 0; row < 9; ++row) {
        [_gridView setValueAtRow:row column:col to:0];
        [_gridView setInitialValueAtRow: row column: col to: [_gridModel getValueAtRow:row Column:col]];
        int gButtonValue = [_gridModel getValueAtRow:row Column:col];
        if (gButtonValue == 0) {
          _totalSteps += 1;
        }
      }
    }
    int curValue = [_numPadView getCurrentValue];
    [_gridView setAllSameButtonNotHighlighted:curValue];
    [_easyMode setOn:NO];
    _leftSteps = _totalSteps;
    NSString* myStats = [[NSString alloc] initWithFormat:@"total: %d -- Left: %d" , _totalSteps, _leftSteps];
    _statsLabel.text = myStats;
    
    [UIView commitAnimations];
    
    _myStack = [[NSMutableArray alloc] init];
    
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
  int curValue = [_numPadView getCurrentValue];
  [_gridView setAllSameButtonNotHighlighted:curValue];
  [_easyMode setOn:NO];
  _leftSteps = _totalSteps;
  NSString* myStats = [[NSString alloc] initWithFormat:@"total: %d -- Left: %d" , _totalSteps, _leftSteps];
  _statsLabel.text = myStats;
  
  _myStack = [[NSMutableArray alloc] init];
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


- (void)myPush:(NSNumber *)object to:(NSMutableArray *)myStack
{
  [myStack addObject:object];
}


- (NSNumber *)myPop: (NSMutableArray *)myStack {
  id lastObject = [myStack lastObject];
  [myStack removeLastObject];
  return lastObject;
}

- (void)undoStep
{
  int myRow = 0;
  int myCol = 0;
  int myVal = 0;
  int intStackNumber = 0;
  NSNumber *myNum = [self myPop:_myStack];
  intStackNumber = [myNum intValue];
  myVal = intStackNumber % 10;
  myCol = (intStackNumber % 100) / 10;
  myRow = intStackNumber / 100;

  [_gridModel setValueAtRow:myRow Column:myCol to:myVal];
  [_gridView setValueAtRow:myRow column:myCol to:myVal];
  
  if (_easyMode.on) {
    int curValue = [_numPadView getCurrentValue];
    [_gridView setAllSameButtonHighlighted:curValue];
  }
  
  if ([_gridModel getValueAtRow:myRow Column:myCol] == 0) {
    _leftSteps += 1;
  }
}


- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
}


- (BOOL)prefersStatusBarHidden
{
  return YES;
}

@end
