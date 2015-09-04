//
//  NYAccount.h
//  WeiBo
//
//  Created by Apple on 15/9/4.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NYAccount : NSObject<NSCoding>
/* accesstoken */
@property(nonatomic , copy) NSString *access_token;
/* <#注释#> */
@property(nonatomic , copy) NSNumber *expires_in;

/* uid */
@property(nonatomic , copy) NSString *uid;

@end
