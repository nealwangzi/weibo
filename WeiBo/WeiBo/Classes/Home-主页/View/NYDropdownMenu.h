//
//  NYDropdownMenu.h
//  WeiBo
//
//  Created by Apple on 15/9/4.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NYDropdownMenu;
@protocol NYDropdownMenuDelegate <NSObject>

- (void)disMissdropdownMenu:(NYDropdownMenu *)dropdowmenu;

@end
@interface NYDropdownMenu : UIView
+(instancetype)dropdownMenu;

- (void)showFrom:(UIView *)from;
- (void)dismiss;
/**
 *  内容
 */
/* 内容 */
@property(nonatomic , strong) UIView *contentView;
/* 内容控制器 */
@property(nonatomic , strong) UIViewController *contentViewController;

/* daili */
@property(nonatomic , weak) id<NYDropdownMenuDelegate> delegate;


@end
