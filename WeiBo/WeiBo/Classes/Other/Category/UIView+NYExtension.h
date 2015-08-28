//
//  UIView+NYExtension.h
//  BS
//
//  Created by neal on 15/8/16.
//  Copyright (c) 2015年 Neal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (NYExtension)

@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;

+ (instancetype)viewFromXib;

@end
