//
//  HeadLineTableViewCell.h
//  ILoveMovie
//
//  Created by lanou3g on 15/10/28.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeadLineModel.h"
@interface HeadLineTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
@property (weak, nonatomic) IBOutlet UILabel *contentLable;

@property (weak, nonatomic) IBOutlet UILabel *movieNameLable;

@property (nonatomic, strong)HeadLineModel *model;
@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@end
