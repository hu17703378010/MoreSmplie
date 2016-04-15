//
//  CommentTableViewCell.m
//  ILoveMovie
//
//  Created by lanou3g on 15/10/29.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import "CommentTableViewCell.h"

@implementation CommentTableViewCell

#pragma mark --- 重写初始化方法,自定义布局
- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubviews];
    }
    return  self;
}

#pragma mark --- 添加自定义布局
- (void) addSubviews
{
    // 图片
    self.commentImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 80, 115)];
    self.commentImageView.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:self.commentImageView];
    
    // 描述
    self.commentLabel = [[UILabel alloc] initWithFrame:CGRectMake(85, 5, kScreenWidth - 90, 115)];
    // 文字自动换行
    self.commentLabel.numberOfLines = 0;
    // 背景随机
   // self.commentLabel.backgroundColor = [UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%256/255.0 blue:arc4random()%256/255.0 alpha:1];
    self.commentLabel.backgroundColor = [UIColor colorWithRed:0.8 green:0.247 blue:0.314 alpha:0.580];
    // 字体
    self.commentLabel.font = [UIFont systemFontOfSize:14.0];
    self.commentLabel.textColor = [UIColor whiteColor];
    [self.contentView addSubview:self.commentLabel];
}

#pragma mark --- 重写model,用于cell赋值
- (void) setCommendModel:(MovieModel *)commendModel
{
    // 标题描述
    self.commentLabel.text = [NSString stringWithFormat:@"    %@", commendModel.Title];
    // 图片
    [self.commentImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://apk.zdomo.com%@", commendModel.PicURL]] placeholderImage:[UIImage imageNamed:@"f_placeHolder.jpg"]];
}

@end
