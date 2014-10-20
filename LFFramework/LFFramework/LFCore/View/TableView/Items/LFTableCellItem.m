//
//  LFTableCellItem.m
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

#import "LFTableCellItem.h"
#import "LFTableViewCell.h"

@implementation LFTableCellItem

#pragma mark -
#pragma mark Properties
@synthesize cellHeight = _cellHeight;
@synthesize cellWidth = _cellWidth;
@synthesize cellStyle = _cellStyle;
@synthesize cellAccessoryType = _cellAccessoryType;
@synthesize cellSelectionStyle = _cellSelectionStyle;
@synthesize cellClass = _cellClass;
@synthesize rawObject = _rawObject;
@synthesize selectable = _selectable;
@synthesize deselectAfterSelecting = _deselectAfterSelecting;
@synthesize identifier = _identifier;


#pragma mark -
#pragma mark Accessors

//  Generate the identifier based on the cell's class
- (NSString *)identifier {
    if (_identifier == nil) {
        _identifier = [[NSString alloc] initWithFormat:@"Cell%@Identifier", self.cellClass];
    }
    return _identifier;
}

#pragma mark -
#pragma mark Life cycle
- (id)init {
    self = [super init];

    if (self) {
        
        self.cellStyle = UITableViewCellStyleDefault;
        self.cellAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.cellSelectionStyle = UITableViewCellSelectionStyleBlue;
        self.cellClass = [LFTableViewCell class];
        self.selectable = YES;
        self.deselectAfterSelecting = YES;
        self.cellHeight = 44;   // Default cell height is 44
        
        // FIXME: related to UIDevice or user constant
        self.cellWidth = 320;
    }
    
    return self;
}

#pragma mark -
#pragma mark description

#pragma mark -
#pragma mark Logic
- (void)reloadRawObject {
    self.rawObject = self.rawObject;
}


@end
