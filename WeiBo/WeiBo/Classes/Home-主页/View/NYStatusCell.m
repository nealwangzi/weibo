//
//  NYStatusCell.m
//  WeiBo
//
//  Created by Apple on 15/9/5.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "NYStatusCell.h"
#import "NYStatus.h"
#import "NYUser.h"
#import <UIImageView+WebCache.h>

@interface NYStatusCell ()
@property (weak, nonatomic) IBOutlet UIImageView *profile_image_View;
@property (weak, nonatomic) IBOutlet UILabel *name_label;
@property (weak, nonatomic) IBOutlet UILabel *created_time_label;
@property (weak, nonatomic) IBOutlet UILabel *text_label;
@property (weak, nonatomic) IBOutlet UIButton *reposts_count_button;
@property (weak, nonatomic) IBOutlet UIButton *comments_count_button;
@property (weak, nonatomic) IBOutlet UIButton *attitudes_count_button;

@end
@implementation NYStatusCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setStatus:(NYStatus *)status
{
    _status = status;
    NYUser *user = status.user;
    [self.profile_image_View sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    self.name_label.text = user.name;
    self.created_time_label.text = status.created_at;
    
    self.text_label.text = status.text;
    
    [self.reposts_count_button setTitle:[NSString stringWithFormat:@"%zd",status.reposts_count] forState:UIControlStateNormal];
    [self.comments_count_button setTitle:[NSString stringWithFormat:@"%zd",status.comments_count] forState:UIControlStateNormal];
    [self.attitudes_count_button setTitle:[NSString stringWithFormat:@"%zd",status.attitudes_count] forState:UIControlStateNormal];

}
- (void)setFrame:(CGRect)frame
{
    frame.size.height -= 10;
    [super setFrame:frame];
}
@end
