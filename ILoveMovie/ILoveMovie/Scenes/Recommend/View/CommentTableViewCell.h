//
//  CommentTableViewCell.h
//  ILoveMovie
//
//  Created by lanou3g on 15/10/29.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MovieModel.h"

@interface CommentTableViewCell : UITableViewCell

// 图片
@property (nonatomic, strong) UIImageView *commentImageView;
// 描述
@property (nonatomic, strong) UILabel *commentLabel;
// model 用于cell赋值
@property (nonatomic, strong) MovieModel *commendModel;

@end
