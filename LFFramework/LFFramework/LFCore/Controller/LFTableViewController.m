//
//  LFTableViewController.m
//  LFFramework
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

#import "LFTableViewController.h"
#import "LFTableViewMoreCell.h"

/**
 * fix performSelector leaks warning
 */

#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)

@interface LFTableViewController () <LFTableViewMoreCellActions>

@end

@implementation LFTableViewController

- (LFTableView *)tableView {
    if (nil == _tableView) {
        _tableView = [[LFTableView alloc] initWithFrame:CGRectMake(0, 0, 320, 480) style:UITableViewStyleGrouped];
        _tableView.lfDelegate = self;
    }
    return _tableView;
}

- (id)init {
    
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.dataSource = [NSMutableArray array];
    
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    if ([self.dataSource count]) {
        [self.tableView reloadData];
    }
}

#pragma mark -
#pragma mark LFTableViewDelegate

- (NSMutableArray *)itemsOfTableView:(LFTableView *)tableView {
    return self.dataSource;
}

- (void)tableView:(LFTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath withCellItem:(LFTableCellItem *)cellItem {
}

- (void)tableView:(LFTableView *)tableView willDisplayCell:(LFTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath withCellItem:(LFTableCellItem *)cellItem {
}

- (void)tableView:(LFTableView *)tableView setItemforCell:(LFTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath withCellItem:(LFTableCellItem *)cellItem {
}

- (void)tableView:(LFTableView *)tableView setCreatedItemforCell:(LFTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath withCellItem:(LFTableCellItem *)cellItem {
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {

    if ([self.dataSource count] > indexPath.row) {
        LFTableCellItem *cellItem = [self.tableView itemForIndexPath:indexPath];
    }
    return NO;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
    return NO;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleNone;
}

#pragma mark - 
#pragma Table Cell Actions

- (void)tableView:(LFTableView *)tableView actionWithSelector:(SEL)selector info:(NSDictionary *)info {
    UIViewController *firstResponderViewController = self;
    BOOL found = NO;
    while (firstResponderViewController.parentViewController && !found) {
        firstResponderViewController = firstResponderViewController.parentViewController;
        if ([firstResponderViewController respondsToSelector:selector]) {
            found = YES;
        }
    }
    if (found) {
        SuppressPerformSelectorLeakWarning([firstResponderViewController performSelector:selector withObject:info]);
    } else if ([self respondsToSelector:selector]) {
        SuppressPerformSelectorLeakWarning([self performSelector:selector withObject:info]);
    }
}
- (void)tableView:(LFTableView *)tableView actionOnTableCell:(LFTableViewCell *)lbCell atIndexPath:(NSIndexPath *)indexPath tableCellItem:(LFTableCellItem *)cellItem control:(id)control controlEvent:(UIControlEvents)event userInfo:(id)userInfo {
}

- (void)tableView:(LFTableView *)tableView cellItemDidDelete:(LFTableCellItem *)cellItem atIndexPath:(NSIndexPath *)indexPath {
}

#pragma mark -
#pragma mark Cell Actions

- (void)moreCellMoreButtonPressed:(NSDictionary *)userInfo {
    // response to ui event
}

@end
