//
//  LFTableView.m
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

#import "LFTableView.h"
#import "LFTableMoreCellItem.h"
#import "NSMutableDictionary+Safety.h"


@interface LFTableView ()

@end

@implementation LFTableView

- (void)dealloc {
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    self.delegate = nil;
    self.lfDelegate = nil;
    self.dataSource = nil;
    [self reloadData];
}

#pragma mark -
#pragma mark Life Cycle

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {    
    if ((self = [super initWithFrame:frame style:style])) {
        
        self.firstLoading = YES;
        
        self.backgroundColor = [UIColor clearColor];
        
        self.dataSource = self;
        self.delegate = self;
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    //  默认style为plain类型
    return [self initWithFrame:frame style:UITableViewStylePlain];
}

- (id)init {
    //  默认frame为zero, 默认style为plain类型
    return [self initWithFrame:CGRectZero style:UITableViewStylePlain];
}

#pragma mark -
#pragma mark Drag down refresh

- (void)reloadData {
    [super reloadData];
    [self setNeedsLayout];
}

- (void)delayReloadData {
    [self performSelector:@selector(reloadData) withObject:nil afterDelay:0.2f];
}

#pragma mark -
#pragma mark Data Source Loading / Reloading Methods

- (void)itemsDidReload {
    _reloading = NO;
}

- (void)reloadRowAtIndexPath:(NSIndexPath *)indexPath withRowAnimation:(UITableViewRowAnimation)animation {
    [self reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:animation];
}

- (void)reloadRowAtIndexPath:(NSIndexPath *)indexPath {
    [self reloadRowAtIndexPath:indexPath withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark -
#pragma mark UITableViewDataSource

- (LFTableCellItem *)itemForIndexPath:(NSIndexPath *)indexPath {
    LFTableCellItem *resItem = nil;
    return resItem;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // This table has at least 1 section.
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSUInteger itemsCount = [[self.lfDelegate itemsOfTableView:self] count];
	return MAX(itemsCount, 1);
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LFTableCellItem *item = [self itemForIndexPath:indexPath];
    
    //  以item的class name作为identifier
    LFTableViewCell *cell = (LFTableViewCell *)[tableView dequeueReusableCellWithIdentifier:item.identifier];
    
    //  Reuse same cell
    if (cell == nil && item.reuseSameCell && nil != item.cell) {
        cell = item.cell;
        cell.delegate = self;
    }
    
    
    if (cell == nil) {
        cell = [[item.cellClass alloc] initWithStyle:item.cellStyle reuseIdentifier:item.identifier item:item];
        cell.delegate = self;
    }

    //  处理behavior 行为
    if (self.behavior) {
        [self.behavior tableView:self setItemforCell:cell atIndexPath:indexPath withCellItem:item];
    }
        
    //  Set all kinds of types
    cell.accessoryType = item.cellAccessoryType;
    cell.selectionStyle = item.cellSelectionStyle;
    
    //  如果为more item, 根据网络状态自动处理
    if ([item isKindOfClass:[LFTableMoreCellItem class]] ) {
        //&& [Reachability isReachableViaWifi]
        ((LFTableMoreCellItem *)item).showSpinner = YES;
        if (((LFTableMoreCellItem *)item).shouldLoadMore && [self.lfDelegate respondsToSelector:@selector(moreItemsWillLoadWithTableView:)]) {
            
            double delayInSeconds = 0.35;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
            dispatch_after(popTime, dispatch_get_current_queue(), ^(void){
                [self.lfDelegate moreItemsWillLoadWithTableView:self];
            });
        }
    }
    
    //  所有cell都有setItem方法，用于重新对cell的UI进行调整
    if (nil != item) {
        [cell setItem:item];
        [cell itemDidSet:item];
    }
    
    cell.indexPath = indexPath;
    
    //  在setItem之后，允许程序员添加一些自定义的设定    
    if ([self.lfDelegate respondsToSelector:@selector(tableView:setItemforCell:atIndexPath:withCellItem:)]) {
        [self.lfDelegate tableView:self 
                    setItemforCell:cell 
                       atIndexPath:indexPath 
                      withCellItem:item];
    }

    //  标记为不是第一次加载，!!!: 这句话的位置很重要
    self.firstLoading = NO;
    [cell voiceOverSettings:item];
    return cell;
    
}

#pragma mark -
#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {    
    LFTableCellItem *item = [self itemForIndexPath:indexPath];
    
    //  如果item 不可选中，则直接返回
    if (!item.selectable) {
        return;
    }
        
    //  反馈效果
    if (item.selectable && item.deselectAfterSelecting) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
    
    //  处理behavior 行为
    if (self.behavior) {
        [self.behavior tableView:self didSelectRowAtIndexPath:indexPath withCellItem:item];
    }
    
    //  传递cell被选中事件
    if ([self.lfDelegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:withCellItem:)]) {
        [self.lfDelegate tableView:self didSelectRowAtIndexPath:indexPath withCellItem:item];
    }
    
}
-(void)setEditing:(BOOL)editing animated:(BOOL)animated{
	[super setEditing:editing animated:animated];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
        
    if ([self.lfDelegate respondsToSelector:@selector(tableView:willDisplayCell:forRowAtIndexPath:withCellItem:)]) {
        LFTableCellItem *item = [self itemForIndexPath:indexPath];
        [self.lfDelegate tableView:self 
                   willDisplayCell:(LFTableViewCell *)cell 
                 forRowAtIndexPath:indexPath
                      withCellItem:item];
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    LFTableCellItem *item = [self itemForIndexPath:indexPath];
    //  返回cell的高度
    return item.cellHeight;
}

#pragma mark -
#pragma mark LFTableViewActionDelegate
- (void)tableCell:(LFTableViewCell *)lbCell actionOnControl:(id)control controlEvent:(UIControlEvents)event userInfo:(id)userInfo selector:(SEL)selector {
    NSIndexPath *indexPath = lbCell.indexPath;
    LFTableCellItem *item = [self itemForIndexPath:indexPath];
    
    
    //  传递cell控件事件
    if (selector != nil && [self.lfDelegate respondsToSelector:@selector(tableView:actionWithSelector:info:)]) {
        if (lbCell && item && control && indexPath) {
            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
            [dict safetySetObject:lbCell forKey:kLFTableView_Action_Key_Cell];
            [dict safetySetObject:item forKey:kLFTableView_Action_Key_CellItem];
            [dict safetySetObject:control forKey:kLFTableView_Action_Key_Control];
            [dict safetySetObject:indexPath forKey:kLFTableView_Action_Key_IndexPath];
            [dict safetySetObject:userInfo forKey:kLFTableView_Action_Key_UserInfo];
            [self.lfDelegate tableView:self
                    actionWithSelector:selector
                                  info:dict];
        }
    } else if ([self.lfDelegate respondsToSelector:@selector(tableView:actionOnTableCell:atIndexPath:tableCellItem:control:controlEvent:userInfo:)]) {
        [self.lfDelegate tableView:self
                 actionOnTableCell:lbCell
                       atIndexPath:indexPath
                     tableCellItem:item
                           control:control
                      controlEvent:event
                          userInfo:userInfo];
    }
}

- (void)tableCell:(LFTableViewCell *)lbCell actionOnControl:(id)control controlEvent:(UIControlEvents)event userInfo:(id)userInfo{
    [self tableCell:lbCell actionOnControl:control controlEvent:event userInfo:userInfo selector:nil];
}

#pragma mark -
#pragma mark Operations
- (void)deleteCellAtIndexPaths:(NSArray *)indexPathArray withRowAnimation:(UITableViewRowAnimation)animation {
    
}

- (void)deleteCellAtIndexPath:(NSIndexPath *)indexPath withRowAnimation:(UITableViewRowAnimation)animation {
    
}

- (void)appendCellItem:(LFTableCellItem *)cellItem WithRowAnimation:(UITableViewRowAnimation)animation {
  
}

- (void)insertCellItem:(LFTableCellItem *)cellItem AtIndexPath:(NSIndexPath *)indexPath withRowAnimation:(UITableViewRowAnimation)animation {
    
}

- (void)insertCellItems:(NSArray *)cellItems atIndexPath:(NSIndexPath *)indexPath withRowAnimation:(UITableViewRowAnimation)animation {
    
}



#pragma mark -
#pragma mark UIResponder
///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event {
    [super touchesBegan:touches withEvent:event];
    
    if ([self.lfDelegate respondsToSelector:@selector(tableView:touchesBegan:withEvent:)]) {
        [self.lfDelegate tableView:self touchesBegan:touches withEvent:event];
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)touchesEnded:(NSSet*)touches withEvent:(UIEvent*)event {
    [super touchesEnded:touches withEvent:event];
    
    if ([self.lfDelegate respondsToSelector:@selector(tableView:touchesEnded:withEvent:)]) {
        [self.lfDelegate tableView:self touchesEnded:touches withEvent:event];
    }
    
}

#pragma mark -
#pragma mark UIScrollViewDelegate Methods
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if ([self.lfDelegate respondsToSelector:@selector(scrollViewWillBeginDragging:)]) {
        [self.lfDelegate scrollViewWillBeginDragging:scrollView];
    }
    
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    if ([self.lfDelegate respondsToSelector:@selector(scrollViewWillEndDragging:withVelocity:targetContentOffset:)]) {
        [self.lfDelegate scrollViewWillEndDragging:scrollView withVelocity:velocity targetContentOffset:targetContentOffset];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if ([self.lfDelegate respondsToSelector:@selector(scrollViewDidEndDragging:willDecelerate:)]) {
        [self.lfDelegate scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{	
    if ([self.lfDelegate respondsToSelector:@selector(scrollViewDidScroll:)]) {
        [self.lfDelegate scrollViewDidScroll:scrollView];
    }
}

- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView {
    if ([self.lfDelegate respondsToSelector:@selector(scrollViewDidScrollToTop:)]) {
        [self.lfDelegate scrollViewDidScrollToTop:scrollView];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if ([self.lfDelegate respondsToSelector:@selector(scrollViewDidEndDecelerating:)]) {
        [self.lfDelegate scrollViewDidEndDecelerating:scrollView];
    }
}

@end
