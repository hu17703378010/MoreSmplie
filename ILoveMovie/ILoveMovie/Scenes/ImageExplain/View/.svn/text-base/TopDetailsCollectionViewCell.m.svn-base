//
//  TopDetailsCollectionViewCell.m
//  ILoveMovie
//
//  Created by lanou3g on 15/10/30.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import "TopDetailsCollectionViewCell.h"

@implementation TopDetailsCollectionViewCell

- (void)awakeFromNib {
  
}


- (void)setModel:(HeadLineModel *)model
{
    [self.coverImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", model.coverFigure]] placeholderImage:[UIImage imageNamed:@"f_placeHolder.jpg"]];
    self.playCountLable.text = [NSString stringWithFormat:@"%@ 人观看", model.playCount];
    self.videoLable.text = model.videoName;

}

@end
