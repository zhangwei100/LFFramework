//
//  LFTableView.h
//
//  Created by Wei Zhang on 08/01/14.
//  Copyright (c) 2014 WeiZhang. All rights reserved.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import <UIKit/UIKit.h>
#import "LFTableViewCell.h"
#import "LFTableCellItem.h"
#import "LFTableViewDelegate.h"
#import "LFTableViewBehavior.h"

#define kLFTableView_Action_Key_Cell            (@"LFTableCell")
#define kLFTableView_Action_Key_CellItem        (@"LFTableCellItem")
#define kLFTableView_Action_Key_IndexPath       (@"LFTableIndexPath")
#define kLFTableView_Action_Key_Control         (@"LFTableControl")
#define kLFTableView_Action_Key_UserInfo        (@"LFTableUserInfo")


@interface LFTableView : UITableView <UITableViewDataSource, UITableViewDelegate, LFTableViewCellActionDelegate>

/**
 * Delegate & Decorator
 */
@property (nonatomic, weak) id lfDelegate;
@property (nonatomic, strong) LFTableViewBehavior *behavior;

/**
 * Status
 */
@property (nonatomic, assign) BOOL firstLoading;
@property (nonatomic, assign) BOOL reloading;

/**
 * Properties & Default Behaviors
 */
@property (nonatomic, readonly) CGFloat totalCellItemHeight;

/**
 * UI Components
 */
//@property (nonatomic, strong) LFTableEmptyCellItem *emptyCellItem;

- (void)reloadRowAtIndexPath:(NSIndexPath *)indexPath withRowAnimation:(UITableViewRowAnimation)animation;
- (void)reloadRowAtIndexPath:(NSIndexPath *)indexPath;

- (LFTableCellItem *)itemForIndexPath:(NSIndexPath *)indexPath;

- (void)deleteCellAtIndexPaths:(NSArray *)indexPathArray withRowAnimation:(UITableViewRowAnimation)animation;
- (void)deleteCellAtIndexPath:(NSIndexPath *)indexPath withRowAnimation:(UITableViewRowAnimation)animation;
- (void)appendCellItem:(LFTableCellItem *)cellItem WithRowAnimation:(UITableViewRowAnimation)animation;
- (void)insertCellItem:(LFTableCellItem *)cellItem AtIndexPath:(NSIndexPath *)indexPath withRowAnimation:(UITableViewRowAnimation)animation;
- (void)insertCellItems:(NSArray *)cellItems atIndexPath:(NSIndexPath *)indexPath withRowAnimation:(UITableViewRowAnimation)animation;

@end
