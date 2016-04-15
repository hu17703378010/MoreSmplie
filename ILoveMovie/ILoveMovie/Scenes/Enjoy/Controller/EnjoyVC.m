//
//  EnjoyVC.m
//  ILoveMovies(爱尚电影)
//
//  Created by lanou3g on 15/10/27.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import "EnjoyVC.h"

#import "PosterViewController.h"  // 海报
#import "RelaxMomentTableViewController.h"  // 轻松一刻
#import "MovieOriginalSoundViewController.h"  // 电影原声
#import "ERPosterViewController.h"  // 海报二级页面
#import"ERRelaxMomentViewController.h"  // 轻松一刻二级页面

#import "ERMovieOriginalSoundViewController.h" // 电影原声2

#import "TwoViewController.h"

// 遵守ViewPagerController的协议
@interface EnjoyVC ()<ViewPagerDataSource, ViewPagerDelegate,RelaxMomentTableViewControllerDelegate, PosterViewControllerDelegate>

@end



@implementation EnjoyVC

- (void)viewDidLoad {
    
    // 第三方书写问题,代理在viewDidLoad前设置
    self.dataSource = self;
    self.delegate = self;
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0.8 green:0.247 blue:0.314 alpha:0.580]];
    [super viewDidLoad];
    
    // 导航栏标题
    self.navigationItem.title = @"电影娱乐";
    
    // 内容以导航栏下方为起点
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    // 跳转电影原声详情界面的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(actionNotification:) name:@"YUANSHENG" object:nil];
    
}


- (void)actionNotification:(NSNotification *)notification
{
    MovieModel *model = [notification.object objectForKey:@"model"];
    ERMovieOriginalSoundViewController *erMOVC = [[ERMovieOriginalSoundViewController alloc]init];
    erMOVC.model = model;
    
    [self.navigationController pushViewController:erMOVC animated:YES];
    [self.tabBarController.tabBar setHidden:YES];
}


#pragma mark --- ViewPagerDataSource 代理方法实现
// 页面个数
- (NSUInteger)numberOfTabsForViewPager:(ViewPagerController *)viewPager
{
    return 3;
}

// 页面题目
- (UIView *)viewPager:(ViewPagerController *)viewPager viewForTabAtIndex:(NSUInteger)index
{
    UILabel *label = [UILabel new];
    label.backgroundColor = [UIColor clearColor];
    // 页面题目数组
    NSArray *titleArray = @[@"海报欣赏", @"轻松一刻", @"电影原声"];
    label.text = [NSString stringWithFormat:@"%@", titleArray[index]];
    // 字体
    label.font = [UIFont systemFontOfSize:13.0];
    [label sizeToFit];
    return label;
}

// 各个页面
- (UIViewController *) viewPager:(ViewPagerController *)viewPager contentViewControllerForTabAtIndex:(NSUInteger)index
{
    if (index == 0) {
        // 海报欣赏
        PosterViewController *posterVC = [[PosterViewController alloc] init];
        // 设置代理,完成页面跳转
        posterVC.delegate = self;
        return posterVC;
    } else if (index == 1) {
        // 轻松一刻
        RelaxMomentTableViewController *relaxMomentTVC = [[RelaxMomentTableViewController alloc] init];
        relaxMomentTVC.delegate = self;
        return relaxMomentTVC;
    } else {
        // 电影原声
        MovieOriginalSoundViewController *movieOriginalSoundVC = [[MovieOriginalSoundViewController alloc] init];
        return movieOriginalSoundVC;
    }
}


#pragma mark --- 实现代理方法-页面跳转
// 海报页面
- (void) pushERPosterVCWithIndexPath:(NSIndexPath *)indexPath allDataArray:(NSMutableArray *)allDataAray
{
    ERPosterViewController *ERPosterVC = [[ERPosterViewController alloc] init];
    // 赋值
    ERPosterVC.indexPath = indexPath;
    ERPosterVC.allDataArray = allDataAray;
    // 跳转页面
    [self.navigationController pushViewController:ERPosterVC animated:YES];
}


// 轻松一刻
- (void)pushWithModel:(MovieModel *)model
{
    ERRelaxMomentViewController *twoRelaxVC = [[ERRelaxMomentViewController alloc] init];
    twoRelaxVC.model = model;
    [self.navigationController pushViewController:twoRelaxVC animated:YES];
}


#pragma mark --- ViewPagerDelegate代理方法
- (CGFloat) viewPager:(ViewPagerController *)viewPager valueForOption:(ViewPagerOption)option withDefault:(CGFloat)value{
    switch (option) {
            // 选择显示哪个视图
        case ViewPagerOptionStartFromSecondTab:
            return 1.0;
            break;
            
        case ViewPagerOptionCenterCurrentTab:
            return 0.0;
            break;
            
        // 索引在页面上方
        case ViewPagerOptionTabLocation:
            return 1.0;
            break;
        default:
            break;
    }
    return value;
}

// 索引条颜色
- (UIColor *)viewPager:(ViewPagerController *)viewPager colorForComponent:(ViewPagerComponent)component withDefault:(UIColor *)color {
    
    switch (component) {
        case ViewPagerIndicator:
            return [[UIColor redColor] colorWithAlphaComponent:0.64];
            break;
        default:
            break;
    }
    
    return color;
}

// 索引条宽度
- (CGFloat)viewPagerwidth
{
    return kScreenWidth/3;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
