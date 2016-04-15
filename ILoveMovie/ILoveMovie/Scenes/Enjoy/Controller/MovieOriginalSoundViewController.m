//
//  MovieOriginalSoundViewController.m
//  ILoveMovies(爱尚电影)
//
//  Created by lanou3g on 15/10/27.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import "MovieOriginalSoundViewController.h"
#import "MovieOriginalSoundCollectionViewCell.h"
#import "MovieModel.h"

// 电影原声接口
#define kMovieOriginalSound @"http://apk.zdomo.com/api/apibasic?columnid=4&pageSize=20&pageNum="
// 0&sid=0

// 上拉刷新 下拉加载
#import "MJRefresh.h"
#import "MJChiBaoZiHeader.h"
#import "MJChiBaoZiFooter.h"
#import "MJChiBaoZiFooter2.h"



// 遵守协议
@interface MovieOriginalSoundViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong)NSMutableArray *dataArray;
// 用于判断是否加载完毕
@property (nonatomic, strong) NSMutableArray *loadDataArray;

// 用于刷新
@property (nonatomic, assign) NSInteger number;
@property (nonatomic, assign) BOOL isLoad;
@end




@implementation MovieOriginalSoundViewController

- (void) viewWillDisappear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = YES;
    [SVProgressHUD dismiss];
}

- (void) viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 创建集合视图
    [self addSubViews];
    [self setUpData];
    
    // 内容导航栏下方为起点
    // self.edgesForExtendedLayout = UIRectEdgeNone;
    
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
//        if (_number > 0) {
//            _number--;
//            [self setUpData];
//        }
        _number = 0;
        [self setUpData];
        // 刷新tableView
        [self.collectionView reloadData];
        // 下拉结束刷新
        [self.collectionView.header endRefreshing];
    });
}
- (void)loadMoreData
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        _number++;
        [self setUpData];
        // 刷新tableView
        [self.collectionView reloadData];
        // 下拉结束刷新
        [self.collectionView.footer endRefreshing];
    });
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
    // 列边距
    layout.minimumInteritemSpacing = 5;
    // 上下滑动
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    // layout.footerReferenceSize = CGSizeMake((kScreenWidth - 10*2 - 10) / 2.0, (kScreenWidth - 10*2 - 10) / 2.0 - 30);
    // item宽高
    layout.itemSize = CGSizeMake((kScreenWidth - 10*2 - 10) / 2.0, (kScreenWidth - 10*2 - 10) / 2.0 + 30);
    // 内边距
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    // 设置代理
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    // 显示视图
    [self.view addSubview:self.collectionView];
    
    // 注册 要用到的cell
    [self.collectionView registerClass:[MovieOriginalSoundCollectionViewCell class] forCellWithReuseIdentifier:@"MovieOSCell"];
    self.collectionView.backgroundColor = [UIColor whiteColor];
}

- (void)setUpData
{
    self.loadDataArray = [NSMutableArray arrayWithArray:self.dataArray];
    // 加载时等待小菊花
    [SVProgressHUD show];
    
    // 互斥锁,如果正在加载数据,那么刷新操作,不能影响现在的数据加载
    if (_isLoad == NO) {
        _isLoad = YES;
        dispatch_async(dispatch_get_main_queue(), ^{
            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%ld&sid=0", kMovieOriginalSound, _number]];
            NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30.0];
            [request setHTTPMethod:@"GET"];
            NSURLSessionConfiguration *config = [NSURLSessionConfiguration ephemeralSessionConfiguration];
            NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
            NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                if (!data) {
                    [SVProgressHUD showErrorWithStatus:@"加载失败"];
                    return;
                }
                NSMutableArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                
                if (_number == 0) {
                    self.dataArray = [NSMutableArray array];
                }
                
                for (NSMutableDictionary *dic in array) {
                    MovieModel *model = [[MovieModel alloc] init];
                    [model setValuesForKeysWithDictionary:dic];
                    [self.dataArray addObject:model];
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    // 全部加载完毕
                    if ([self.dataArray isEqualToArray:self.loadDataArray]) {
                        self.collectionView.footer.state = MJRefreshStateNoMoreData;
                    }
                    
                    [self.collectionView reloadData];
                    
                    _isLoad = NO;
                    
                    // 加载完成,菊花消失
                    [SVProgressHUD dismiss];
                });
            }];
            [dataTask resume];
            
        });

    }
    
}


#pragma mark --- 协议方法实现
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
    MovieOriginalSoundCollectionViewCell * soundCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MovieOSCell" forIndexPath:indexPath];
    // 背景随机色
    soundCell.contentView.backgroundColor = [UIColor colorWithRed:0.8 green:0.247 blue:0.314 alpha:0.580];
    
    if (self.dataArray.count > 0) {
        MovieModel *model = self.dataArray[indexPath.row];
        // cell赋值
        soundCell.movieSoundModel = model;
    }
   
    return soundCell;
}


// 选中操作
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    MovieModel *model = self.dataArray[indexPath.row];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"YUANSHENG" object:@{@"model":model}];
}




#pragma mark --- 数据懒加载
- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
