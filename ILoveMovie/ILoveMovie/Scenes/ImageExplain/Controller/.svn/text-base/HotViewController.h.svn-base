//
//  HotViewController.h
//  ILoveMovies(爱尚电影)
//
//  Created by lanou3g on 15/10/27.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>

// 创建一个协议
@protocol HotViewDelegate <NSObject>

// 声明想要实现的方法
- (void)getWithVideoId:(NSString *)videoId VideoName:(NSString *)VideoName;

@end

@interface HotViewController : UIViewController

@property (nonatomic, strong)id <HotViewDelegate> delegate;
@end
