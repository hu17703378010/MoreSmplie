//
//  ERPosterViewController.m
//  ILoveMovie
//
//  Created by lanou3g on 15/10/29.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import "ERPosterViewController.h"

#import "MovieModel.h"


@interface ERPosterViewController ()<UIScrollViewDelegate>

{
    int number;
}
@end



@implementation ERPosterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    // 添加布局
    [self addSubViews];
    
    
    
    // 显示标题-用于第一次点击进去显示
    NSInteger page = self.bgScrollView.contentOffset.x / kScreenWidth;
    MovieModel *titleModel = self.allDataArray[page];
    self.navigationItem.title = titleModel.Title;
    
    // 左返回
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"iconfont-fanhui(1)"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)] style:(UIBarButtonItemStylePlain) target:self action:@selector(actionImageBarButton:)];
}
- (void)actionImageBarButton:(UIBarButtonItem *)imageBarButton
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark --- 视图tabBar的隐藏,出现
- (void) viewWillAppear:(BOOL)animated
{
    [self.tabBarController.tabBar setHidden:YES];
}

- (void) viewWillDisappear:(BOOL)animated
{
    [self.tabBarController.tabBar setHidden:NO];
}

#pragma mark --- 添加布局
- (void) addSubViews
{
    // 接收数组个数
    NSInteger count = self.allDataArray.count;
    
   // 创建一个大S(与屏幕等大,显示滑动区域为数组个数的宽度)
    self.bgScrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    // 滑动区域
    self.bgScrollView.contentSize = CGSizeMake(kScreenWidth * count, kScreenHeight);
    // 偏移量,用来显示点击图片
    self.bgScrollView.contentOffset = CGPointMake(kScreenWidth *(self.indexPath.row), 0);
    // 整屏滑动
    self.bgScrollView.pagingEnabled = YES;
    // 设置代理
    self.bgScrollView.delegate = self;
    
    // 循环创建小S
    for (int i = 0; i < count; i++) {
        UIScrollView *smallScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0 + kScreenWidth * i, 0, kScreenWidth, kScreenHeight)];
        smallScrollView.backgroundColor = [UIColor grayColor];
        // 代理
        smallScrollView.delegate = self;
        // 设置缩放属性
        smallScrollView.maximumZoomScale = 2.0;
        smallScrollView.minimumZoomScale = 0.5;
        
        smallScrollView.tag = 666 + i;
        
        // 创建显示图片的ImageView
        // 获取model
        MovieModel *model = self.allDataArray[i];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        // 显示图片
        [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://apk.zdomo.com%@", model.PicURL]] placeholderImage:[UIImage imageNamed:@"f_placeHolder.jpg"]];
        [smallScrollView addSubview:imageView];
        
        [self.bgScrollView addSubview:smallScrollView];
    }
    
    
    
    [self.view addSubview:self.bgScrollView];
}


#pragma mark --- ScrollView协议方法实现
// 缩的时候,一直触发
- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    // 让缩放以中心点进行
    UIImageView *imageView = scrollView.subviews[0];
    imageView.center = self.view.center;
}

// 缩放对象
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return scrollView.subviews[0];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    number = scrollView.contentOffset.x / kScreenWidth;
}

// 结束减速,图片回复原样大小
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    for (int i = 0; i < self.allDataArray.count; i++) {
        if (number != scrollView.contentOffset.x / kScreenWidth) {
            UIScrollView *scrollView = (UIScrollView *)[self.view viewWithTag:666 + i];
            scrollView.zoomScale = 1;

        }
    }
    
    // 显示标题-用于滑动时显示
    NSInteger page = self.bgScrollView.contentOffset.x / kScreenWidth;
    MovieModel *titleModel = self.allDataArray[page];
    self.navigationItem.title = titleModel.Title;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
