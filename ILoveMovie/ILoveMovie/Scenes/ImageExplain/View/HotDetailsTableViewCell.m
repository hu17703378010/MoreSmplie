//
//  HotDetailsTableViewCell.m
//  ILoveMovie
//
//  Created by lanou3g on 15/10/29.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import "HotDetailsTableViewCell.h"
#import "HeadLineModel.h"
@implementation HotDetailsTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview];
    }
    return self;
}

- (void)addSubview
{
    self.coverImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 200)];
    [self.contentView addSubview:self.contentView];
    self.detailsLable = [[UILabel alloc] initWithFrame:CGRectMake(0, self.coverImage.bottom, kScreenWidth, 40)];
    [self.contentView addSubview:self.detailsLable];
}


- (void)setModel:(HeadLineModel *)model
{
    [self.coverImage sd_setImageWithURL:[NSURL URLWithString:model.imageUrl] placeholderImage:[UIImage imageNamed:@"c_placeHolder.jpg"]];
   
}





@end
