//
//  NYNewFeatureCell.h
//  WeiBo
//
//  Created by Apple on 15/9/4.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NYNewFeatureCell : UICollectionViewCell
/* <#注释#> */
@property(nonatomic , strong) NSString *imagename;
- (void)setIndexPath:(NSIndexPath *)indexPath count:(NSInteger)count;
@end
