//
//  LFTableCellItem.h
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

@class LFTableViewCell;

@interface LFTableCellItem : NSObject

@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, assign) CGFloat cellWidth;
@property (nonatomic, assign) UITableViewCellStyle cellStyle;
@property (nonatomic, assign) UITableViewCellAccessoryType cellAccessoryType;
@property (nonatomic, assign) UITableViewCellSelectionStyle cellSelectionStyle;
@property (nonatomic, assign) Class cellClass;
@property (nonatomic, strong) id rawObject;
@property (nonatomic, copy) NSString *identifier;
@property (nonatomic, assign) BOOL selectable;
@property (nonatomic, assign) BOOL deselectAfterSelecting;
@property (nonatomic, assign) BOOL customHandle;
@property (nonatomic, assign) BOOL reuseSameCell;
@property (nonatomic, assign) BOOL didUseCachedResponse;
@property (nonatomic, weak) LFTableViewCell *cell;

- (void)reloadRawObject;

@end


