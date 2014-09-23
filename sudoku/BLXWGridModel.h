//
//  BLXWGridModel.h
//  sudoku
//
//  Created by Ben Leader on 9/18/14.
//  Copyright (c) 2014 Benjamin Leader and Hannah Long. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BLXWGridModel : NSObject

@property (nonatomic, retain) NSNumber* currentButtonTag;

- (void) generateGrid;
- (int) getValueAtRow: (int)row Column: (int)column;
- (void) setValueAtRow: (int)row Column: (int)column to: (int)newValue;
- (BOOL) isMutableAtRow: (int)row Column: (int)column;
- (BOOL) isConsistentAtRow: (int)row Column: (int)column for: (int)value;

@end
