//
//  RecommendTableViewCell.m
//  ILoveMovie
//
//  Created by lanou3g on 15/10/28.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import "RecommendTableViewCell.h"

@implementation RecommendTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(MovieModel *)model
{
    [self.picImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://apk.zdomo.com%@",model.PicURL]] placeholderImage:[UIImage imageNamed:@"c_placeHolder.jpg"]];
    self.titleLabel.text = model.Title;
    self.imtroductionLabel.text = model.Introduction;
    switch ([model.ColumnID integerValue]) {
        case 1:
            self.columnLabel.text = @"电影推荐";
            break;
        case 2:
            self.columnLabel.text = @"说说电影";
            break;
        case 3:
            self.columnLabel.text = @"海报欣赏";
            break;
        case 4:
            self.columnLabel.text = @"电影原声";
            break;
        case 5:
            self.columnLabel.text = @"轻松一刻";
            break;
        default:
            break;
    }
}

@end
