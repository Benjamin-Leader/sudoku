//
//  sudokuTests.m
//  sudokuTests
//
//  Created by Ben Leader on 9/11/14.
//  Copyright (c) 2014 Benjamin Leader and Hannah Long. All rights reserved.
//

#import "BLXWGridModel.h"
#import <XCTest/XCTest.h>

@interface sudokuTests : XCTestCase {
  BLXWGridModel* _model;
  BLXWGridModel* _model2;
}

@end

@implementation sudokuTests

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

int cells2[9][9]={
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

int initialCells2[9][9]={
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


- (void)setUp
{
  [super setUp];
  // Put setup code here. This method is called before the invocation of each test method in the class.
    
  _model = [[BLXWGridModel alloc] init];
  _model2 = [[BLXWGridModel alloc] init];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testMutable
{
  for (int column = 0; column < 9; ++column) {
    for (int row = 0; row < 9; ++row) {
      if ([_model2 getValueAtRow:row Column:column] == 0) {
        initialCells[column][row] = 0;
        NSLog(@"%d", initialCells[column][row]);
      } else {
        initialCells[column][row] = 1;
        NSLog(@"%d", initialCells[column][row]);
      }
    }
  }
  NSLog(@"-------------------");
  for (int column = 0; column < 9; ++column) {
    for (int row = 0; row < 9; ++row) {
      if ([_model2 isMutableAtRow:row Column:column]) {
        NSLog(@"%d", initialCells[column][row]);
        XCTAssertTrue(initialCells[column][row] == 0, @"Testing mutability of mutable cell");
      } else {
        NSLog(@"%d", initialCells[column][row]);
        XCTAssertTrue(initialCells[column][row] == 1, @"Testing mutability of non-mutable cell");
      }
    }
  }
}


- (void)testSetAndGetValue
{
    for (int column = 0; column < 9; ++column) {
        for (int row = 0; row < 9; ++row) {
            [_model setValueAtRow:row Column:column to:1];
        }
    }
    for (int column = 0; column < 9; ++column) {
        for (int row = 0; row < 9; ++row) {
            XCTAssertTrue([_model getValueAtRow:row Column:column] == 1, @"Testing setting value at row %d, col %d", row, column);
        }
    }
}


- (void)testConsistency
{
  for (int column = 0; column < 9; ++column) {
    for (int row = 0; row < 9; ++row) {
      [_model setValueAtRow:row Column:column to:cells2[column][row]];
    }
  }

  
    XCTAssertFalse([_model isConsistentAtRow:1 Column:0 for:5], @"Testing nonconsistent due to row repeat");
    XCTAssertFalse([_model isConsistentAtRow:0 Column:1 for:5], @"Testing nonconsistent due to column repeat");
    XCTAssertFalse([_model isConsistentAtRow:0 Column:4 for:5], @"Testing nonconsistent due to subgrid repeat");
    
    XCTAssertTrue([_model isConsistentAtRow:4 Column:4 for:1], @"Testing consistent");
    XCTAssertTrue([_model isConsistentAtRow:2 Column:0 for:1], @"Testing consistent");
    XCTAssertTrue([_model isConsistentAtRow:0 Column:6 for:1], @"Testing consistent");
}

//- (void)testIncorrectValues
//{
//    XCTAssertThrowsSpecific([_model setValueAtRow:1 Column:1 to:10], NSException, @"Converting more than max value");
//    XCTAssertThrowsSpecific([_model setValueAtRow:1 Column:1 to:0], NSException, @"Converting less than min value");
//    
//    XCTAssertThrowsSpecific([_model isConsistentAtRow:1 Column:1 for:10], NSException, @"Converting more than max value");
//    XCTAssertThrowsSpecific([_model isConsistentAtRow:1 Column:1 for:0], NSException, @"Converting less than min value");
//
//}

- (void)testGenerator
{
  
}

@end
