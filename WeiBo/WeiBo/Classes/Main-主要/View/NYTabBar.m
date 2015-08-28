//
//  NYTabBar.m
//  WeiBo
//
//  Created by Apple on 15/8/28.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "NYTabBar.h"

@interface NYTabBar ()
/* plusbutton */
@property(nonatomic , weak) UIButton *plusButton;

@end
@implementation NYTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UIButton *plusButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:plusButton];
        self.plusButton = plusButton;
        [plusButton setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [plusButton setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
        [plusButton setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [plusButton setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        [plusButton sizeToFit];
        [plusButton addTarget:self action:@selector(plusButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}
- (void)plusButtonClick
{
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.plusButton.centerX = self.width * 0.5;
    self.plusButton.centerY = self.height * 0.5;
    CGFloat buttonW = self.width / 5;
    int i = 0;
    for (UIView *view in self.subviews) {
        if (![NSStringFromClass(view.class) isEqualToString:@"UITabBarButton"]) {
            continue;
        }
        view.width = buttonW;
        view.x = i *buttonW;
        if (i >1) {
            view.x +=buttonW;
        }
        i++;
    }
}
@end
