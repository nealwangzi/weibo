//
//  NYNewFeatureCell.m
//  WeiBo
//
//  Created by Apple on 15/9/4.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "NYNewFeatureCell.h"
#import "NYTabBarController.h"

@interface NYNewFeatureCell ()
@property (weak, nonatomic) IBOutlet UIImageView *image_view;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@end
@implementation NYNewFeatureCell
- (IBAction)shareButtonClick:(UIButton *)sender {
    self.shareButton.selected = !self.shareButton.selected;
}
- (IBAction)loginButtonClick:(UIButton *)sender {
    [UIApplication sharedApplication].keyWindow.rootViewController = [[NYTabBarController alloc]init];
}

- (void)awakeFromNib {
    // Initialization code
}
- (void)setImagename:(NSString *)imagename
{
    _imagename = imagename;
    self.image_view.image = [UIImage imageNamed:imagename];
}
- (void)setIndexPath:(NSIndexPath *)indexPath count:(NSInteger)count
{
    if (indexPath.item == count-1) {
        self.shareButton.hidden = NO;
        self.loginButton.hidden = NO;
    } else {
        self.shareButton.hidden = YES;
        self.loginButton.hidden = YES;

    }
}

@end
