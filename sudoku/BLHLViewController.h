//
//  BLHLViewController.h
//  sudoku
//
//  Created by Ben Leader on 9/11/14.
//  Copyright (c) 2014 Benjamin Leader and Hannah Long. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BLHLViewController : UIViewController<UIAlertViewDelegate>
{
}

- (void) gridCellSelected: (BLHLGridView*) tag;
- (void) startNewGame:(UIButton*)sender;
- (void)clearGrid:(UIButton*)sender;
- (void)changeEasyMode:(UISwitch *)sender;

@end
