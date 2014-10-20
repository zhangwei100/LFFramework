//
//  LFTableViewMoreCell.m
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

#import "LFTableViewMoreCell.h"
#import "LFTableMoreCellItem.h"

#define kTable_RefreshMore_MarginLeft  (17)

@implementation LFTableViewMoreCell

#pragma mark -
#pragma mark Accessors

- (UIButton *)moreButton {
    if (nil == _moreButton) {
        _moreButton = [[UIButton alloc] init];
    }
    return _moreButton;
}

- (UIActivityIndicatorView *)spinner {
    if (nil == _spinner) {
        _spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    }
    return _spinner;
}

#pragma mark -
#pragma mark Life cycle

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier item:(LFTableCellItem *)cellItem {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier item:cellItem];
    if (self) {
        // Initialization code
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self addSubview:self.moreButton];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setItem:(LFTableCellItem *)item {
    //  set values for UI elements

//    self.moreButton.frame = CGRectMake(kTable_RefreshMore_MarginLeft, 0, 320 - kTable_RefreshMore_MarginLeft, item.cellHeight);
    
    CGFloat width = 200;
    self.spinner.frame = CGRectMake(floorf((item.cellWidth - width) / 2), floorf((item.cellHeight - 20) / 2), width, width);

    if ([(LFTableMoreCellItem *)item showSpinner]) {
        [self.moreButton setTitle:@"正在加载..." forState:UIControlStateNormal];
        if (![self.spinner superview]) {
            [self addSubview:self.spinner];
            
            self.moreButton.enabled = NO;
        }
        [self.spinner startAnimating];
    } else {
        if ([(LFTableMoreCellItem *)item title].length > 0) {
            [self.moreButton setTitle:[(LFTableMoreCellItem *)item title] forState:UIControlStateNormal];
        }
        else{
            [self.moreButton setTitle:@"点击加载更多..." forState:UIControlStateNormal];
        }
        if ([self.spinner superview]) {
            [self.spinner removeFromSuperview];
            self.moreButton.enabled = YES;
        }
    }

}

#pragma mark -
#pragma mark Buttons
- (void)moreButtonPressed:(id)sender {
    if (self.moreButton.enabled == NO) {
        return;
    }
    
    if (![self.spinner superview]) {
        [self addSubview:self.spinner];
        [self.spinner startAnimating];
        self.moreButton.enabled = NO;
        [_moreButton setTitle:@"正在加载..." forState:UIControlStateNormal];
    }
    
    if ([self.delegate respondsToSelector:@selector(tableCell:actionOnControl:controlEvent:userInfo:)]) {
        [self.delegate tableCell:self 
                 actionOnControl:sender 
                    controlEvent:UIControlEventTouchUpInside
                        userInfo:nil];
    }
    
    return;
    
    // OR:
    
    if ([self.delegate respondsToSelector:@selector(tableCell:actionOnControl:controlEvent:userInfo:selector:)]) {
        [self.delegate tableCell:self actionOnControl:sender controlEvent:UIControlEventTouchUpInside userInfo:nil selector:@selector(moreCellMoreButtonPressed:)];
    }
}

@end
