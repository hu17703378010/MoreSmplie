//
//  PosterCell.m
//  ILoveMovie
//
//  Created by lanou3g on 15/10/28.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import "PosterCell.h"

@implementation PosterCell

#pragma mark --- 重写初始化方法
- (instancetype) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 添加布局
        [self addSubviews];
    }
    return self;
}

#pragma mark --- 布局
- (void)addSubviews
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, (kScreenWidth - 5*2 - 5*2) / 3.0, 180)];
    
    // 图片
    self.posterImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width, 160)];
    self.posterImageView.backgroundColor = [UIColor grayColor];
    [view addSubview:self.posterImageView];
    
    // 标题
    self.postreLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 160, view.frame.size.width, 20)];
    self.postreLabel.textColor = [UIColor blackColor];
    // 字体
    self.postreLabel.font = [UIFont systemFontOfSize:12.0];
    self.postreLabel.textAlignment = NSTextAlignmentCenter;
    [view addSubview:self.postreLabel];
    
    [self.contentView addSubview:view];
}


#pragma mark --- 重写model,对cell赋值
- (void) setPosterModel:(MovieModel *)posterModel
{
    // 文字
    self.postreLabel.text = [NSString stringWithFormat:@"%@", posterModel.Title];
    // 图片
    [self.posterImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://apk.zdomo.com%@", posterModel.PicURL]] placeholderImage:[UIImage imageNamed:@"f_placeHolder.jpg"]];
}


@end
