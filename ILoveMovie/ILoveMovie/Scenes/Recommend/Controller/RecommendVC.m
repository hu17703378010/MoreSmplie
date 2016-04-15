//
//  RecommendVC.m
//  ILoveMovies(爱尚电影)
//
//  Created by lanou3g on 15/10/27.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import "RecommendVC.h"
#import "MovieRecommendViewController.h"
#import "CategoryViewController.h"
#import "CommentTableViewController.h"  // 电影说说
#import "MovieModel.h"
#import "MovieSetTableViewController.h" // 电影集合
#import "ERRelaxMomentViewController.h"  // 轻松一刻2


#import "ERMovieOriginalSoundViewController.h"  // 电影原声详情

#import "TwoViewController.h"


@interface RecommendVC ()<ViewPagerDataSource, ViewPagerDelegate, MovieRecommendDelegate>

@end

@implementation RecommendVC

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"SHUOSHUO" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"CATEGORY" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"MOVIESET" object:nil];

}


- (void)viewDidLoad {
    self.dataSource = self;
    self.delegate = self;
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0.8 green:0.247 blue:0.314 alpha:0.580]];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [super viewDidLoad];
    
    
    self.navigationItem.title = @"电影推荐";

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(actionNotification:) name:@"SHUOSHUO" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(actionNotification1:) name:@"CATEGORY" object:nil];
    //MOVIESET
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(actionNotification2:) name:@"MOVIESET" object:nil];
    
}


- (void)viewWillAppear:(BOOL)animated
{
    [self.tabBarController.tabBar setHidden:NO];
}

- (void)actionNotification:(NSNotification *)notification
{
    MovieModel *model = [notification.object objectForKey:@"model"];
    TwoViewController *erCommVC = [[TwoViewController alloc]init];
    erCommVC.model = model;
    [self.tabBarController.tabBar setHidden:YES];
    [self.navigationController pushViewController:erCommVC animated:YES];
}
- (void)actionNotification1:(NSNotification *)notification
{
    MovieModel *model = [notification.object objectForKey:@"model"];
    TwoViewController *erCaVC = [[TwoViewController alloc]init];
    erCaVC.model = model;
    [self.tabBarController.tabBar setHidden:YES];
    [self.navigationController pushViewController:erCaVC animated:YES];
}
- (void)actionNotification2:(NSNotification *)notification
{
    MovieSetTableViewController *erCaVC = [[MovieSetTableViewController alloc]init];
    [self.tabBarController.tabBar setHidden:YES];
    [self.navigationController pushViewController:erCaVC animated:YES];
}




#pragma mark - ViewPagerDataSource
- (NSUInteger)numberOfTabsForViewPager:(ViewPagerController *)viewPager {
    return 3;
}

- (UIView *)viewPager:(ViewPagerController *)viewPager viewForTabAtIndex:(NSUInteger)index {
    UILabel *label = [UILabel new];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:13.0];
    NSArray *array = @[@"电影分类",@"电影推荐",@"电影说说"];
    label.text = [NSString stringWithFormat:@"%@", array[index]];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor blackColor];
    [label sizeToFit];
    return label;
}
//,@"活动",@"场所"

- (UIViewController *)viewPager:(ViewPagerController *)viewPager contentViewControllerForTabAtIndex:(NSUInteger)index {
    if(index == 0){
        CategoryViewController *cateVC = [[CategoryViewController alloc]init];
        return cateVC;
    }else if (index == 1) {
        MovieRecommendViewController *dvc = [[MovieRecommendViewController alloc]init];
        // 设置代理,让代理干活
        dvc.delegate = self;
        return dvc;
    }else if (index == 2){
        CommentTableViewController *commentTVC = [[CommentTableViewController alloc]init];
        return commentTVC;
    } 
    return nil;
}


#pragma mark --- 电影推荐页面代理方法实现
- (void) pushViewControllerWithModel:(MovieModel *)model
{
    // 分辨类型
    /*
     1 - 电影分类
     2 - 电影说说
     3 - 海报欣赏
     4 - 电影原声
     5 - 轻松一刻
     */
    
    NSString *idStr = [NSString stringWithFormat:@"%@", model.ColumnID];
    self.tabBarController.tabBar.hidden = YES;
    // 辨别model,退出不同页面
    if ([idStr isEqualToString:@"1"]) {
        // 电影分类
        TwoViewController *categoryVC = [[TwoViewController alloc] init];
        categoryVC.model = model;
        [self.navigationController pushViewController:categoryVC animated:YES];
    } else if ([idStr isEqualToString:@"2"]) {
        // 电影说说
        TwoViewController *commVC = [[TwoViewController alloc] init];
        commVC.model = model;
        [self.navigationController pushViewController:commVC animated:YES];
    } else if ([idStr isEqualToString:@"3"]) {
        // 海报欣赏
        UIViewController *postVC = [[UIViewController alloc] init];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://apk.zdomo.com%@", model.PicURL]] placeholderImage:[UIImage imageNamed:@"f_placeHolder.jpg"]];
        [postVC.view addSubview:imageView];
        [self.navigationController pushViewController:postVC animated:YES];
    } else if ([idStr isEqualToString:@"4"]) {
        // 电影原声
        ERMovieOriginalSoundViewController *soundVC = [[ERMovieOriginalSoundViewController alloc] init];
        soundVC.model = model;
        [self.navigationController pushViewController:soundVC animated:YES];
        
    } else if ([idStr isEqualToString:@"5"]) {
        // 轻松一刻
        ERRelaxMomentViewController *relaxVC = [[ERRelaxMomentViewController alloc]init];
        relaxVC.model = model;
        [self.navigationController pushViewController:relaxVC animated:YES];
        
    }
}




#pragma mark - ViewPagerDelegate
- (CGFloat)viewPager:(ViewPagerController *)viewPager valueForOption:(ViewPagerOption)option withDefault:(CGFloat)value {
    switch (option) {
        case ViewPagerOptionStartFromSecondTab:
            return 1.0;
            break;
        case ViewPagerOptionCenterCurrentTab:
            return 0.0;
            break;
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
            return [[UIColor redColor] colorWithAlphaComponent:0.64];
            break;
        default:
            break;
    }
    
    return color;
}

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
