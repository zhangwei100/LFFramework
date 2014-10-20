//
//  LFTableViewBehavior.m
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

#import "LFTableViewBehavior.h"

@implementation LFTableViewBehavior

#pragma mark -
#pragma mark Propterties
@synthesize owner = _owner;
@synthesize requestModelPool = _requestModelPool;

- (void)dealloc {
    self.owner = nil;
    
}

#pragma mark -
#pragma mark Accessors
- (NSMutableArray *)requestModelPool {
    if (nil == _requestModelPool) {
        _requestModelPool = [[NSMutableArray alloc] init];
    }
    return _requestModelPool;
}

#pragma mark -
#pragma mark Life cycle

- (id)init {
    self = [super init];
    
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

#pragma mark -
#pragma mark Behavior methods
- (void)tableView:(LFTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath withCellItem:(LFTableCellItem *)cellItem {

}

- (void)tableView:(LFTableView *)tableView setItemforCell:(LFTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath withCellItem:(LFTableCellItem *)cellItem {

}

- (void)tableView:(LFTableView *)tableView actionOnTableCell:(LFTableViewCell *)lbCell atIndexPath:(NSIndexPath *)indexPath tableCellItem:(LFTableCellItem *)cellItem control:(id)control controlEvent:(UIControlEvents)event userInfo:(id)userInfo {

}


#pragma mark -
#pragma mark WebServiceCallerDeletage

- (void)webServiceCaller:(id)caller didGetResults:(id)results {

}

- (void)webServiceCaller:(id)caller didFailGetResultsWithError:(NSError*)error {

}

- (void)webServiceCallerDidNotFindResults:(id)caller {

}



@end
