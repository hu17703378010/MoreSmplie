//
//  RelaxMomentCell.m
//  ILoveMovies(爱尚电影)
//
//  Created by lanou3g on 15/10/27.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import "RelaxMomentCell.h"




@implementation RelaxMomentCell


#pragma mark --- 重写初始化方法
- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubviews];
    }
    return self;
}


#pragma mark -- 布局
- (void) addSubviews
{
    // 图片
    self.relaxImageView = [[UIImageView alloc] initWithFrame:CGRectMake(3, 8, kScreenWidth - 6, 195)];
    self.relaxImageView.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:self.relaxImageView];
    CALayer *lay  =  self.relaxImageView.layer;//获取ImageView的层
    [lay setMasksToBounds:YES];
    [lay setCornerRadius:10.0];
    
    
    // 渐变虚化背景图片
//    for (int i = 0; i < 30; i ++) {  // 50虚化的高度与颜色深浅
//        CGFloat num = 1.0 / 50 *(50 - i);
//        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, _relaxImageView.height - i, kScreenWidth, 1)];   // _coverImageView背景图片
//        view.backgroundColor = [UIColor colorWithRed:80.0 / 255.0 green:80.0 / 255.0 blue:80.0 / 255.0  alpha:num];
//        [_relaxImageView addSubview:view];
//    }
//    
    // 文字
    self.relaxLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 180, kScreenWidth - 16, 20)];
     self.relaxLabel.backgroundColor = [UIColor blackColor];
//     背景随机色
  //  self.relaxLabel.backgroundColor = [UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%256/255.0 blue:arc4random()%256/255.0 alpha:0.7];
    // 字体
    self.relaxLabel.font = [UIFont systemFontOfSize:13.0];
    self.relaxLabel.textColor = [UIColor whiteColor];
    [self.contentView addSubview:self.relaxLabel];
}


#pragma mark --- set Model, 给Cell 赋值
- (void)setRelaxModel:(MovieModel *)relaxModel
{
    // 文字
    self.relaxLabel.text = [NSString stringWithFormat:@"  %@", relaxModel.Title];
    // 图片
    [self.relaxImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://apk.zdomo.com%@", relaxModel.PicURL]] placeholderImage:[UIImage imageNamed:@"c_placeHolder.jpg"]];
}

@end
