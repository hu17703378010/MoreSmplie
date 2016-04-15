//
//  MovieRecommendViewController.h
//  ILoveMovie
//
//  Created by lanou3g on 15/10/28.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MovieModel.h"   // model

// 代理
@protocol MovieRecommendDelegate <NSObject>

// 方法声明 - 携带model完成页面跳转
- (void) pushViewControllerWithModel:(MovieModel *)model;

@end



@interface MovieRecommendViewController : UIViewController

// 集合视图
@property (nonatomic, strong) UICollectionView *collectionView;
// 集合视图表头
@property (nonatomic, strong) UICollectionReusableView *headerView;

// 声明代理属性
@property (nonatomic, assign) id<MovieRecommendDelegate> delegate;

@end
