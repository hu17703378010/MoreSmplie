//
//  RelaxMomentTableViewController.h
//  ILoveMovies(爱尚电影)
//
//  Created by lanou3g on 15/10/27.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MovieModel.h"

// 设置代理
@protocol RelaxMomentTableViewControllerDelegate <NSObject>

// 方法声明
- (void)pushWithModel:(MovieModel *)model;

@end


@interface RelaxMomentTableViewController : UITableViewController
// 代理属性
@property (nonatomic,assign)id<RelaxMomentTableViewControllerDelegate> delegate;

@end
