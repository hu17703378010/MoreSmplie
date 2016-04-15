//
//  HeadLineTableViewCell.m
//  ILoveMovie
//
//  Created by lanou3g on 15/10/28.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import "HeadLineTableViewCell.h"

@implementation HeadLineTableViewCell

- (void)awakeFromNib {
    
    for (int i = 0; i < 70; i ++) {  // 50虚化的高度与颜色深浅
        CGFloat num = 1.0 / 70 *(70 - i);
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, _coverImageView.frame.size.height - i, kScreenWidth, 1)];   // _coverImageView背景图片
        view.backgroundColor = [UIColor colorWithRed:0 / 255.0 green:0 / 255.0 blue:0 / 255.0  alpha:num];
        [_coverImageView addSubview:view];
    }

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

- (void)setModel:(HeadLineModel *)model
{
    self.movieNameLable.text = model.videoName;
    self.contentLable.text = [NSString stringWithFormat:@"%@ 人观看", model.playCount];
    self.titleLable.text = model.videoBriefIntroduction;
    [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:model.coverFigure] placeholderImage:[UIImage imageNamed:@"c_placeHolder.jpg"]];
}

@end
