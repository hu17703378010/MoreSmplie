//
//  HotTableViewCell.h
//  ILoveMovie
//
//  Created by lanou3g on 15/10/27.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HotModel;

@interface HotTableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *contentLable;
@property (weak, nonatomic) IBOutlet UILabel *movieLable;
@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (weak, nonatomic) IBOutlet UIImageView *movieImageView;


@property (nonatomic, strong)HotModel *model;


@end
