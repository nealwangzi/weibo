//
//  NYTitleViewButton.m
//  WeiBo
//
//  Created by Apple on 15/8/29.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "NYTitleViewButton.h"

@implementation NYTitleViewButton

- (void)layoutSubviews
{
    [super layoutSubviews];
    if (self.titleLabel.x>self.imageView.x) {
        
        self.titleLabel.x = self.imageView.x;
        self.imageView.x = CGRectGetMaxX(self.titleLabel.frame);

    }
    
}
- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    [self sizeToFit];
}
- (void)setImage:(UIImage *)image forState:(UIControlState)state
{
    [super setImage:image forState:state];
    [self sizeToFit];
}
@end
