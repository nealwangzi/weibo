//
//  NYAccount.m
//  WeiBo
//
//  Created by Apple on 15/9/4.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "NYAccount.h"

@implementation NYAccount

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.access_token forKey:@"access_token"];
    [aCoder encodeObject:self.expires_in forKey:@"expires_in"];
    [aCoder encodeObject:self.uid forKey:@"uid"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.access_token = [aDecoder decodeObjectForKey:@"access_token"];
        self.expires_in = [aDecoder decodeObjectForKey:@"expires_in"];
        self.uid = [aDecoder decodeObjectForKey:@"uid"];
    }
    return self;
}
@end
