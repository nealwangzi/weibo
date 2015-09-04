//
//  NYAccountTool.h
//  WeiBo
//
//  Created by Apple on 15/9/4.
//  Copyright (c) 2015年 Apple. All rights reserved.
//  处理账号相关的所有操作:存储账号;取出账号;验证账号

#import <Foundation/Foundation.h>
@class NYAccount;
@interface NYAccountTool : NSObject
+ (void)saveAccount:(NYAccount *)account;

+ (NYAccount *)account;
@end
