//
//  LFTableMoreCellItem.m
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

#import "LFTableMoreCellItem.h"
#import "LFTableViewMoreCell.h"

@implementation LFTableMoreCellItem

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
        self.cellClass = [LFTableViewMoreCell class];
        self.shouldLoadMore = YES;
        self.selectable = NO;
        self.showSpinner = NO;
        self.cellAccessoryType = UITableViewCellAccessoryNone;
        self.cellSelectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return self;
}

- (void)reset {
    self.showSpinner = NO;
}

+ (LFTableMoreCellItem *)fakeLoadMoreCellItem {
    LFTableMoreCellItem *shouldNotLoadMoreCellItem = [[LFTableMoreCellItem alloc] init];
    shouldNotLoadMoreCellItem.shouldLoadMore = NO;
    return shouldNotLoadMoreCellItem;
}

+ (LFTableMoreCellItem *)cellItem {
    return [[LFTableMoreCellItem alloc] init];
}

+ (LFTableMoreCellItem *)cellItemWithTitle:(NSString *)title {
    LFTableMoreCellItem *cellItem = [[LFTableMoreCellItem alloc] init];
    cellItem.title = title;
    return cellItem; 
}

@end
