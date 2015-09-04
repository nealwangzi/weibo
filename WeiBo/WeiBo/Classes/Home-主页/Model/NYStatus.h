//
//  NYStatus.h
//  WeiBo
//
//  Created by Apple on 15/9/5.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NYUser.h"

@interface NYStatus : NSObject
/* 创建时间 */
@property(nonatomic , copy) NSString *created_at;
/* ID */
@property(nonatomic , assign) NSInteger ID;
/* text */
@property(nonatomic , copy) NSString *text;
/* laiyuan */
@property(nonatomic , copy) NSString *source;
/* 转发数 */
@property(nonatomic , assign) NSInteger reposts_count;
/* 评论数 */
@property(nonatomic , assign) NSInteger comments_count;
/* 表态 */
@property(nonatomic , assign) NSInteger attitudes_count;
/* user */
@property(nonatomic , strong) NYUser *user;


@end
