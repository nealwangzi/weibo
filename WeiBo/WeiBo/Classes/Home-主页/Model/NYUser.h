//
//  NYUser.h
//  WeiBo
//
//  Created by Apple on 15/9/5.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NYUser : NSObject
/* uid */
@property(nonatomic , copy) NSString *idstr;
/* name */
@property(nonatomic , copy) NSString *name;
/* 头像 */
@property(nonatomic , copy) NSString *profile_image_url;


@end
