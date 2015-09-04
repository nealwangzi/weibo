//
//  NYAccountTool.m
//  WeiBo
//
//  Created by Apple on 15/9/4.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "NYAccountTool.h"
#import "NYAccount.h"

// 账号的存储路径
#define NYAccountPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.archive"]
@implementation NYAccountTool
+ (void)saveAccount:(NYAccount *)account
{
    account.created_time = [NSDate date];
    [NSKeyedArchiver archiveRootObject:account toFile:NYAccountPath];
}

+ (NYAccount *)account
{
    NYAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:NYAccountPath];
    
    long long expires_in = [account.expires_in longLongValue];
    NSDate *expiresTime = [account.created_time dateByAddingTimeInterval:expires_in];
    
    NSDate *now = [NSDate date];
    
    NSComparisonResult result = [expiresTime compare:now];
    if (result != NSOrderedDescending) {
        return nil;
    }
    return  account;
}
@end
