//
//  ImageExplainVC.m
//  ILoveMovies(爱尚电影)
//
//  Created by lanou3g on 15/10/27.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import "ImageExplainVC.h"
#import "HotViewController.h"
#import "TopViewController.h"
#import "HeadLineViewController.h"
#import "TopDetalisViewController.h"
#import "HeadLineAndHotViewController.h"
@interface ImageExplainVC ()<ViewPagerDataSource, ViewPagerDelegate, HotViewDelegate>

@end

@implementation ImageExplainVC

- (void)viewDidLoad {
    // 代理必须放在 [super viewDidLoad] 前面
    self.dataSource = self;
    self.delegate = self;
    
    [super viewDidLoad];
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0.8 green:0.247 blue:0.314 alpha:0.580]];
    // 接收通知
//     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(actionNotification:) name:@"REYINGONE" object:nil];
    // 接收通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(actionNotification:) name:@"TOPDETALIS" object:nil];
    // 接收头条通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(actionNotification:) name:@"HEADLINE" object:nil];
    // 接收TopThirdViewController的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(actionNotification:) name:@"TOPTHIRD" object:nil];
    
    // 从导航下计算
      self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationItem.title = @"图解电影";
    
}

// 代理
- (void)getWithVideoId:(NSString *)videoId VideoName:(NSString *)VideoName
{
    HeadLineAndHotViewController *headLinAndHotVC = [[HeadLineAndHotViewController alloc] init];
    headLinAndHotVC.videoId = videoId;
    headLinAndHotVC.videoName = VideoName;
    headLinAndHotVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:headLinAndHotVC animated:YES];
}

// 跳转方法
- (void)actionNotification:(NSNotification *)notification
{
//    if ([notification.name isEqualToString:@"REYINGONE"]) {
//        HotDetaliViewController *hotdVC = [[HotDetaliViewController alloc]init];
//        NSDictionary *dic = notification.object;
//        // 取到详情页面所需的videoId , videoName
//        hotdVC.videoId = [dic objectForKey:@"videoId"];
//        hotdVC.videoName= [dic objectForKey:@"videoName"];
//        // 隐藏tabBar
//        [self.tabBarController.tabBar setHidden:YES];
//        [self.navigationController pushViewController:hotdVC animated:YES];
    if ([notification.name isEqualToString:@"TOPDETALIS"]) {
        
        TopDetalisViewController *topDetaVC = [[TopDetalisViewController alloc] init];
        // 得到通知传的model
        TopModel *model = [notification.object objectForKey:@"topModel"];
        //[self.tabBarController.tabBar setHidden:YES];
        topDetaVC.hidesBottomBarWhenPushed = YES;
        // 把model赋值给 二级页面的model
        topDetaVC.model = model;
        topDetaVC.flag = @"TUJIE";
        [self.navigationController pushViewController:topDetaVC animated:YES];
    } else if ([notification.name isEqualToString:@"HEADLINE"]) {
        
        HeadLineAndHotViewController *headLinAndHotVC = [[HeadLineAndHotViewController alloc] init];
        // 得到通知传递的videoId, videoName
        NSDictionary *dic = notification.object;
        headLinAndHotVC.videoId = [dic objectForKey:@"videoId"];
        headLinAndHotVC.videoName = [dic objectForKey:@"videoName"];
        // 隐藏tabBar
        headLinAndHotVC.hidesBottomBarWhenPushed = YES;
       // [self.tabBarController.tabBar setHidden:NO];
        // 跳转
        [self.navigationController pushViewController:headLinAndHotVC animated:YES];
    } else if ([notification.name isEqualToString:@"TOPTHIRD"]) {
        HeadLineAndHotViewController *headLinAndHotVC = [[HeadLineAndHotViewController alloc] init];
        NSDictionary *dic = notification.object;
       headLinAndHotVC.videoId = [dic objectForKey:@"videoId"];
        headLinAndHotVC.videoName = [dic objectForKey:@"videoName"];
        headLinAndHotVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:headLinAndHotVC animated:YES];
    }
    
}

#pragma mark - ViewPagerDataSource
- (NSUInteger)numberOfTabsForViewPager:(ViewPagerController *)viewPager {
    return 3;
}

- (UIView *)viewPager:(ViewPagerController *)viewPager viewForTabAtIndex:(NSUInteger)index {
    UILabel *label = [UILabel new];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:13.0];
    NSArray *array = @[@"热映",@"专题",@"头条"];
    label.text = [NSString stringWithFormat:@"%@", array[index]];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor blackColor];
    [label sizeToFit];
    return label;
}

- (UIViewController *)viewPager:(ViewPagerController *)viewPager contentViewControllerForTabAtIndex:(NSUInteger)index {
    
    // index 与对应的Controller 对应起来
    if (index == 0) {
        HotViewController *hotVC = [[HotViewController alloc]init];
        // 遵循代理
        hotVC.delegate = self;
        return hotVC;
    }else if (index == 2){
        HeadLineViewController *topVC = [[HeadLineViewController alloc]init];

        return topVC;
    }else {
       TopViewController *headVC = [[TopViewController alloc]init];
        return headVC;
    }
    return nil;
}


#pragma mark - ViewPagerDelegate
- (CGFloat)viewPager:(ViewPagerController *)viewPager valueForOption:(ViewPagerOption)option withDefault:(CGFloat)value {
    switch (option) {
            // 视图显示选中出现的Controller
        case ViewPagerOptionStartFromSecondTab:
            return 1.0;
            break;
        case ViewPagerOptionCenterCurrentTab:
            return 1.0;
            break;
            // pageController 的位置
        case ViewPagerOptionTabLocation:
            return 1.0;
            break;
        default:
            break;
    }
    return value;
}


- (UIColor *)viewPager:(ViewPagerController *)viewPager colorForComponent:(ViewPagerComponent)component withDefault:(UIColor *)color {
    switch (component) {
        case ViewPagerIndicator:
            // 滑动条的颜色
            return [[UIColor redColor] colorWithAlphaComponent:0.64];
            break;
        default:
            break;
    }
    return color;
}


- (CGFloat)viewPagerwidth
{
    // pageController的大小
    return kScreenWidth/3;
    return kScreenWidth / 3;

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
