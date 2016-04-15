//
//  ViewController.m
//  ILoveMovies(爱尚电影)
//
//  Created by lanou3g on 15/10/27.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import "ViewController.h"
#import "ImageExplainVC.h"
#import "AFNetworking.h"
@interface ViewController ()

@property (nonatomic, strong) UIAlertController *alert;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addViewControllerClass:[RecommendVC class] title:@"推荐" image:@"nav_around_off@3x" selectImage:@"nav_around_on@3x"];
    [self addViewControllerClass:[ImageExplainVC class] title:@"图解" image:@"nav_musicians_off@3x" selectImage:@"nav_musicians_on@3x"];
    [self addViewControllerClass:[EnjoyVC class] title:@"影娱" image:@"nav_music_off@3x" selectImage:@"nav_music_on@3x"];
    [self addViewControllerClass:[MineViewController class] title:@"我的" image:@"nav_mine_off@3x" selectImage:@"nav_mine_on@3x"];
    self.selectedIndex = 1;
    // 判断连接的网络状态
    [self reach];
}

- (void)addViewControllerClass:(Class)class title:(NSString *)title image:(NSString *)image selectImage:(NSString *)selectImage
{
    UIViewController *viewVC = [[class alloc] init];
    UINavigationController *navC = [[UINavigationController alloc]initWithRootViewController:viewVC];
    navC.tabBarItem.title = title;
    navC.tabBarItem.image = [[UIImage imageNamed:image]imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    navC.tabBarItem.selectedImage = [[UIImage imageNamed:selectImage]imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    [self addChildViewController:navC];
    [navC.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor grayColor],NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
}

// 判断连接的网络状态
- (void)reach
{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager startMonitoring];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status == 0) {
            self.alert  = [UIAlertController alertControllerWithTitle:@"未连接网络" message:nil preferredStyle:UIAlertControllerStyleAlert];
            // 随后消失
            [self performSelector:@selector(dismissAlertView:) withObject:nil afterDelay:2.0];
            [self presentViewController:self.alert animated:YES completion:nil];
        } else if (status == 3) {
            self.alert  = [UIAlertController alertControllerWithTitle:@"正在使用移动网络" message:nil preferredStyle:UIAlertControllerStyleAlert];
            // 随后消失
            [self performSelector:@selector(dismissAlertView:) withObject:nil afterDelay:2.0];
            [self presentViewController:self.alert animated:YES completion:nil];
        }
    }];
}

- (void)dismissAlertView:(NSTimer *)timer
{
    [self.alert dismissViewControllerAnimated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
