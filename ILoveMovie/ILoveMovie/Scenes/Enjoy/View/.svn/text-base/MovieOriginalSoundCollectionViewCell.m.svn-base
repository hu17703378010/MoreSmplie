//
//  MovieOriginalSoundCollectionViewCell.m
//  ILoveMovie
//
//  Created by lanou3g on 15/10/28.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import "MovieOriginalSoundCollectionViewCell.h"

@implementation MovieOriginalSoundCollectionViewCell


#pragma mark --- 重写初始化方法
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubviews];
    }
    return self;
}

#pragma mark --- 添加布局
- (void) addSubviews
{
    // 图片
    self.soundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, (kScreenWidth - 10*2 - 10) / 2.0, (kScreenWidth - 10*2 - 10) / 2.0)];
    // 正方形变成圆形
    self.soundImageView.layer.cornerRadius = self.soundImageView.frame.size.width / 2;
    self.soundImageView.layer.masksToBounds = YES;
    
    
    // 标题
    self.soundLable = [[UILabel alloc] initWithFrame:CGRectMake(0, (kScreenWidth - 10*2 - 10) / 2.0, (kScreenWidth - 10*2 - 10) / 2.0, 30)];
    
    self.soundLable.backgroundColor = [UIColor colorWithRed:0.8 green:0.247 blue:0.314 alpha:0.580];
    // 字体居中
    self.soundLable.textAlignment = NSTextAlignmentCenter;
    // 字体大小
    self.soundLable.font = [UIFont fontWithName:@"Helvetica" size:14];
    // 字体颜色
    self.soundLable.textColor = [UIColor whiteColor];
    
    [self.contentView addSubview:self.soundImageView];
    [self.contentView addSubview:self.soundLable];
}


#pragma mark --- 重写model 进行赋值
- (void) setMovieSoundModel:(MovieModel *)movieSoundModel
{
    // 图片
    [self.soundImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://apk.zdomo.com%@", movieSoundModel.PicURL]] placeholderImage:[UIImage imageNamed:@"f_placeHolder.jpg"]];
    // 标题
    self.soundLable.text = movieSoundModel.Title;
}


@end
