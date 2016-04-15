//
//  PosterViewController.h
//  ILoveMovies(爱尚电影)
//
//  Created by lanou3g on 15/10/27.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MovieModel.h"  // model

// 设置代理
@protocol PosterViewControllerDelegate <NSObject>

// 方法声明 -- 携带model完成页面跳转
- (void)pushERPosterVCWithIndexPath:(NSIndexPath *)indexPath allDataArray:(NSMutableArray *)allDataAray;


@end



@interface PosterViewController : UIViewController

// 集合视图
@property (nonatomic, strong) UICollectionView *collectionView;
// 属性代理
@property (nonatomic, assign) id<PosterViewControllerDelegate> delegate;

@end
