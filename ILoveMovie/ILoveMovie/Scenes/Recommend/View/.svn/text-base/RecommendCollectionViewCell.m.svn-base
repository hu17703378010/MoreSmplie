//
//  RecommendCollectionViewCell.m
//  ILoveMovie
//
//  Created by lanou3g on 15/10/29.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import "RecommendCollectionViewCell.h"

@implementation RecommendCollectionViewCell


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
    self.recommendImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width, view.frame.size.width)];
    self.recommendImageView.backgroundColor = [UIColor grayColor];
    [view addSubview:self.recommendImageView];
    
    
    // 标题
    self.recommendLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, view.frame.size.width, view.frame.size.width, 20)];
    self.recommendLabel.textColor = [UIColor blackColor];
    
    // 字体
    self.recommendLabel.font = [UIFont systemFontOfSize:12.0];
    self.recommendLabel.textAlignment = NSTextAlignmentCenter;
    [view addSubview:self.recommendLabel];
    
    [self.contentView addSubview:view];
}


#pragma mark --- 重写model,对cell赋值
- (void) setRecommendModel:(MovieModel *)recommendModel
{
    [self.recommendImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://apk.zdomo.com%@", recommendModel.PicURL]] placeholderImage:[UIImage imageNamed:@"f_placeHolder.jpg"]];
    self.recommendLabel.text = recommendModel.Title;
}


@end
