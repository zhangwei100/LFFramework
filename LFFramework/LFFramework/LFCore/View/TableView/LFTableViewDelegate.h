//
//  LFTableViewDelegate.h
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

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class LFTableView;
@class LFTableViewCell;
@class LFTableCellItem;

@protocol LFTableViewDelegate <NSObject>
@required
#pragma mark - Data Source
- (NSMutableArray *)itemsOfTableView:(LFTableView *)tableView;

@optional

#pragma mark - TableView delegate
- (void)tableView:(LFTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath withCellItem:(LFTableCellItem *)cellItem;
- (void)tableView:(LFTableView *)tableView willDisplayCell:(LFTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath withCellItem:(LFTableCellItem *)cellItem;
- (void)tableView:(LFTableView *)tableView setItemforCell:(LFTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath withCellItem:(LFTableCellItem *)cellItem;
- (void)tableView:(LFTableView *)tableView setCreatedItemforCell:(LFTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath withCellItem:(LFTableCellItem *)cellItem;


#pragma mark - Drag down refresh time
- (NSDate *)refreshDateWithTableView:(LFTableView *)tableView;

#pragma mark - Table Cell Actions
- (void)tableView:(LFTableView *)tableView 
actionOnTableCell:(LFTableViewCell *)lbCell
      atIndexPath:(NSIndexPath *)indexPath
    tableCellItem:(LFTableCellItem *)cellItem
          control:(id)control 
     controlEvent:(UIControlEvents)event 
         userInfo:(id)userInfo;
- (void)tableView:(LFTableView *)tableView actionWithSelector:(SEL)selector info:(NSDictionary *)info;

#pragma mark - Table cell edit operations
- (void)tableView:(LFTableView *)tableView cellItemDidDelete:(LFTableCellItem *)cellItem atIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(LFTableView *)tableView cellItemDidInsert:(LFTableCellItem *)cellItem atIndexPath:(NSIndexPath *)indexPath;
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath;
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath;
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath;


#pragma mark - Update data source methods
//  Drag down refresh. It becomes required when you set _dragDownRefresh as YES
- (void)itemsWillReloadWithTableView:(LFTableView *)tableView;
//  More button pressed
- (void)moreItemsWillLoadWithTableView:(LFTableView *)tableView;

#pragma mark - Touch Events
- (void)tableView:(LFTableView *)tableView touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)tableView:(LFTableView *)tableView touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;


#pragma mark - Scroll view delegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView;
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset;
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;
- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView;
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView;
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView;

@end