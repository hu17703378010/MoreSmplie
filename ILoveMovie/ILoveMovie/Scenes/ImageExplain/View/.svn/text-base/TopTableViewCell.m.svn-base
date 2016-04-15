//
//  TopTableViewCell.m
//  ILoveMovie
//
//  Created by lanou3g on 15/10/28.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import "TopTableViewCell.h"

@implementation TopTableViewCell

- (void)awakeFromNib {
    for (int i = 0; i < 200; i ++) {  // 虚化的高度与颜色深浅
        CGFloat num = 1.0 / 200 *(200 - i);
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, _coverImage.frame.size.height - i, kScreenWidth, 1)];   // _coverImageView背景图片
        view.backgroundColor = [UIColor colorWithRed:100.0 / 255.0 green:100.0 / 255.0 blue:100.0 / 255.0  alpha:num];        
        [_coverImage addSubview:view];
    }

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(TopModel *)model
{
    [self.coverImage sd_setImageWithURL:[NSURL URLWithString:model.previewImage] placeholderImage:[UIImage imageNamed:@"c_placeHolder.jpg"]];
    self.topicNameLable.text = model.topicName;
    self.watchCountLable.text = [NSString stringWithFormat:@"%@ 人观看", model.watchCount];
}
@end
