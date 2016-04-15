//
//  RelaxMomentCell.h
//  ILoveMovies(爱尚电影)
//
//  Created by lanou3g on 15/10/27.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MovieModel.h"  // Model

@interface RelaxMomentCell : UITableViewCell

// 图片
@property (nonatomic, strong) UIImageView *relaxImageView;
// 文字
@property (nonatomic, strong) UILabel *relaxLabel;
// model
@property (nonatomic, strong) MovieModel *relaxModel;

@end
