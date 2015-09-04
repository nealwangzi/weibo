//
//  NYDropdownMenu.m
//  WeiBo
//
//  Created by Apple on 15/9/4.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "NYDropdownMenu.h"

@interface NYDropdownMenu ()
/* 显示内容的容器 */
@property(nonatomic , weak) UIImageView *containerView;

@end
@implementation NYDropdownMenu
- (UIImageView *)containerView
{
    if (_containerView == nil) {
        UIImageView *containerView = [[UIImageView alloc]init];
        UIImage *containerViewbg = [UIImage imageNamed:@"popover_background"];
        containerViewbg = [containerViewbg stretchableImageWithLeftCapWidth:containerViewbg.size.width *0.5 topCapHeight:containerViewbg.size.height * 0.5];
        containerView.image= containerViewbg;

        containerView.userInteractionEnabled = YES;
        [self addSubview:containerView];
        _containerView = containerView;
    }
    return _containerView;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}
+(instancetype)dropdownMenu
{
    return [[self alloc]init];
}
-(void)setContentView:(UIView *)contentView
{
    _contentView = contentView;
    contentView.x = 10 ;
    contentView.y = 15;
    
    self.containerView.width =CGRectGetMaxX(contentView.frame) +10;
    self.containerView.height = CGRectGetMaxY(contentView.frame) +10;
    
    [self.containerView addSubview:contentView];
}
- (void)setContentViewController:(UIViewController *)contentViewController
{
    _contentViewController = contentViewController;
    self.contentView = contentViewController.view;
}
- (void)showFrom:(UIView *)from
{
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    [window addSubview:self];
    self.frame = window.bounds;

    CGRect newFrame = [from convertRect:from.bounds toView:window];
    self.containerView.centerX = CGRectGetMidX(newFrame);
    self.containerView.y = CGRectGetMaxY(newFrame);
}
- (void)dismiss
{
    [self removeFromSuperview];
    if ([_delegate respondsToSelector:@selector(disMissdropdownMenu:)]) {
        [_delegate disMissdropdownMenu:self];
    }
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event

{
    [self dismiss];
}
@end
