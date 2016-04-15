//
//  MovieRecommendViewController.m
//  ILoveMovie
//
//  Created by lanou3g on 15/10/28.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import "SDCycleScrollView.h"
#import "MovieRecommendViewController.h"
#import "RecommendScVModel.h"  // 轮播图的model
#import "RecommendCollectionViewCell.h"  // 集合视图自定义cell



// 轮播图的url
#define kMovieRecommendScUrl @"http://apk.zdomo.com/api/apiFilmAlbum?pageSize=4&pageNum=0&witch=228"
// 推荐的url
#define kMovieRecommendUrl @"http://apk.zdomo.com/api/apibasic?columnid=0&pageSize=20&pageNum="
// 0&sid=0

// 上拉刷新 下拉加载
#import "MJRefresh.h"
#import "MJChiBaoZiHeader.h"
#import "MJChiBaoZiFooter.h"
#import "MJChiBaoZiFooter2.h"



@interface MovieRecommendViewController ()<SDCycleScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (nonatomic,retain)NSMutableArray *dataArray;
@property (nonatomic,retain)SDCycleScrollView *scrollView;
@property (nonatomic,retain)NSMutableArray *scrollImageArray;  // 轮播图图片的数组
@property (nonatomic,retain)NSMutableArray *scrollTitleArray;  // 轮播图题目的数组
@property (nonatomic,retain)NSMutableArray *adsArray;  // 轮播图model的数组

// 用于刷新
@property (nonatomic, assign) NSInteger number;

// 刷新互斥锁
@property (nonatomic,assign)BOOL isRefreshing;
@end


@implementation MovieRecommendViewController
- (void) viewWillDisappear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = NO;
    [SVProgressHUD dismiss];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.isRefreshing = YES;
   [SVProgressHUD show];
    // 轮播图数据解析
    [self setupScrollViewData];
    
    // 集合视图
    [self addSubViews];
    
    
    // 刷新
    _number = 0;
    // 下拉设置回调
    self.collectionView.header = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    // 马上进入刷新状态
    [self.collectionView.header beginRefreshing];
    // 上拉回调
    self.collectionView.footer = [MJChiBaoZiFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}

#pragma mark --- 用于刷新
- (void)loadNewData
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        _number = 0;
        // 初始化数组
        self.dataArray = [NSMutableArray array];
        [self setUpData];
        // 刷新tableView
        [self.collectionView reloadData];
        // 下拉结束刷新
        [self.collectionView.header endRefreshing];
    });
}
- (void)loadMoreData
{
    if (self.isRefreshing) {
        self.isRefreshing = NO;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            _number++;
            [self setUpData];
            // 刷新tableView
            [self.collectionView reloadData];
            // 下拉结束刷新
            [self.collectionView.footer endRefreshing];
        });
    }
}


- (void)setUpData
{
    // 加载时等待小菊花
    [SVProgressHUD show];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%ld&sid=0", kMovieRecommendUrl, _number]];
        // 创建请求
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        // 设置请求
        [request setHTTPMethod:@"GET"];
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration ephemeralSessionConfiguration];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
        NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (!data) {
                [SVProgressHUD showErrorWithStatus:@"加载失败"];
                return;
            }
            NSMutableArray *array = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:nil];
            // 遍历数组
            for (NSDictionary *dic in array) {
                MovieModel *model = [[MovieModel alloc]init];
                [model setValuesForKeysWithDictionary:dic];
                [self.dataArray addObject:model];
            }
            // 回到主线程
            dispatch_async(dispatch_get_main_queue(), ^{
                // 刷新页面
                [self.collectionView reloadData];
                // 加载完成,菊花消失
                [SVProgressHUD dismiss];
                 self.isRefreshing = YES;
            });
        }];
        [dataTask resume];
    });
}

- (void)setupScrollViewData
{
    // 加载时等待小菊花
    [SVProgressHUD show];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSURL *url = [NSURL URLWithString:kMovieRecommendScUrl];
        // 创建请求
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        // 设置请求
        [request setHTTPMethod:@"GET"];
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration ephemeralSessionConfiguration];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
        NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            NSMutableArray *array = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:nil];
            // 初始化数组
            self.adsArray = [NSMutableArray array];
            // 遍历数组
            for (NSDictionary *dic in array) {
                RecommendScVModel *model = [[RecommendScVModel alloc]init];
                model.Title = [dic objectForKey:@"Title"];
                model.ThePhoto = [NSString stringWithFormat:@"http://apk.zdomo.com/ueditor/net/%@", [dic objectForKey:@"ThePhoto"]];
                [self.adsArray addObject:model];
            }
            // 回到主线程
            dispatch_async(dispatch_get_main_queue(), ^{
                // 添加滚动图
                [self addScrollView];
                // 刷新数据
                [self.collectionView reloadData];
                CATransition *animation = [CATransition animation];
                animation.duration = 1.5;
                animation.type = @"rippleEffect";
                animation.subtype = kCATransitionFromTop;
                animation.timingFunction = UIViewAnimationCurveEaseInOut;
                [self.scrollView.layer addAnimation:animation forKey:@"AppearAnimation"];
                [self.collectionView.layer addAnimation:animation forKey:@"AppearAnimation"];
                // 加载完成,菊花消失
                [SVProgressHUD dismiss];
            });
        }];
        [dataTask resume];
    });
}



#pragma mark --addScrollView
- (void)addScrollView
{
    self.scrollImageArray = [NSMutableArray array];
    self.scrollTitleArray = [NSMutableArray array];
    for (RecommendScVModel *ads in self.adsArray) {
        ads.ThePhoto = [ads.ThePhoto stringByReplacingOccurrencesOfString:@"net//" withString:@"net/"];
        ads.ThePhoto = [ads.ThePhoto stringByReplacingOccurrencesOfString:@"http://apk.zdomo.com/ueditor/net/ueditor/net/upload/image/" withString:@"http://apk.zdomo.com/ueditor/net/upload/image/"];
        [self.scrollImageArray addObject:ads.ThePhoto];
        [self.scrollTitleArray addObject:ads.Title];
    }
    for (int i = 0; i < self.scrollImageArray.count; i++) {
        self.scrollImageArray[i] = [self.scrollImageArray[i] stringByReplacingOccurrencesOfString:@"net//" withString:@"net/"];
        
    }
    
    self.scrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kScreenWidth, 150) imageURLStringsGroup:self.scrollImageArray];
    // 字体数组
    self.scrollView.titlesGroup = self.scrollTitleArray;
    // 背景颜色
    // self.scrollView.titleLabelBackgroundColor = [UIColor colorWithRed:0 green:0.3 blue:1 alpha:0.3];
    // 背景高度
    self.scrollView.titleLabelHeight = 30;
    // 字体大小  颜色
    self.scrollView.titleLabelTextFont = [UIFont systemFontOfSize:13.0];
    self.scrollView.titleLabelTextColor = [UIColor whiteColor];
    // 几秒钟换图片
    self.scrollView.autoScrollTimeInterval = 2;
    // 小圆点的颜色
    self.scrollView.dotColor = [[UIColor redColor] colorWithAlphaComponent:0.5];
    
    // 小圆点的位置在中间还是右边
    self.scrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    
    // 设置代理
    self.scrollView.delegate = self;
    
    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 150)];
    // 集合视图表头加滚动图
    [self.headerView addSubview:view1];
    
    [view1 addSubview:self.scrollView];
}

// SDCycleScrollView唯一的代理方法  选中图片执行
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"MOVIESET" object:nil];
}



#pragma mark --- 创建集合视图
- (void) addSubViews
{
    // 创建网状布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    // 利用layout创建一个集合视图
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 140) collectionViewLayout:layout];
    
    // 行间距
    layout.minimumLineSpacing = 10;
    // 列边
    layout.minimumInteritemSpacing = 5;
    // 上下滑动
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    // item宽高
    layout.itemSize = CGSizeMake((kScreenWidth - 5*2 - 5*2) / 3.0, (kScreenWidth - 5*2 - 5*2) / 3.0 + 20);
    // 内边距
    layout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    // 设置代理
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    // collectionView默认为黑色
    self.collectionView.backgroundColor = [UIColor whiteColor];

    // 表头
    layout.headerReferenceSize = CGSizeMake(0, 160);
    
    // 显示视图
    [self.view addSubview:self.collectionView];
    
    
    // 注册 要用到的cell
    [self.collectionView registerClass:[RecommendCollectionViewCell class] forCellWithReuseIdentifier:@"recommendCell"];
    // 注册 表头,用于存放轮播图
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"head"];
}


#pragma mark --- collectionView协议方法实现
// 分区数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


// 分区Item数
- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

// cell样式
- (UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    RecommendCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"recommendCell" forIndexPath:indexPath];
    
    // 取出cell对应的model
    if (self.dataArray.count > 0) {
        MovieModel *recommendModel = self.dataArray[indexPath.row];
        // 赋值
        cell.recommendModel = recommendModel;
    }
    return cell;
}


// 表头表尾
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    // 表头
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        self.headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"head" forIndexPath:indexPath];
        return self.headerView;
    }
    return nil;
}



// 点击事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    MovieModel *model = self.dataArray[indexPath.row];
    // 让代理干活
    [self.delegate pushViewControllerWithModel:model];
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
