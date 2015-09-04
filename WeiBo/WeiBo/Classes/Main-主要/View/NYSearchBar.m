//
//  NYself.m
//  WeiBo
//
//  Created by Apple on 15/9/4.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "NYSearchBar.h"

@implementation NYSearchBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.font = [UIFont systemFontOfSize:14];
        self.placeholder = @"请输入搜索条件";
        UIImage *seacrhbarbg = [UIImage imageNamed:@"searchbar_textfield_background"];
        seacrhbarbg = [seacrhbarbg stretchableImageWithLeftCapWidth:seacrhbarbg.size.width * 0.5 topCapHeight:seacrhbarbg.size.height * 0.5];
        self.background =seacrhbarbg;
        /**
         *  设置左边的放大镜
         */
        UIImageView *searchIcon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"searchbar_textfield_search_icon"]];
        searchIcon.contentMode = UIViewContentModeCenter;
        self.leftView = searchIcon;
        self.leftViewMode = UITextFieldViewModeAlways;
    }
    return self;
}

+ (instancetype)searchBar
{
    return [[self alloc]init];
}
@end
