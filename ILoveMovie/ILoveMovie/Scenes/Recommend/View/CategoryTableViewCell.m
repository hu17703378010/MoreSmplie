//
//  CategoryTableViewCell.m
//  ILoveMovie
//
//  Created by lanou3g on 15/11/4.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import "CategoryTableViewCell.h"

@implementation CategoryTableViewCell

- (void)awakeFromNib {
    for (int i = 0; i < 50; i ++) {  // 50虚化的高度与颜色深浅
        CGFloat num = 1.0 / 30 *(30 - i);
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, _categoryImageView.frame.size.height - i, kScreenWidth - 15, 1)];   // _coverImageView背景图片
        view.backgroundColor = [UIColor colorWithRed:0 / 255.0 green:0 / 255.0 blue:0 / 255.0  alpha:num];
        [_categoryImageView addSubview:view];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
