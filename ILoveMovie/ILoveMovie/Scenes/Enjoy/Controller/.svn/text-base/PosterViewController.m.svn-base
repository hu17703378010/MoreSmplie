//
//  PosterViewController.m
//  ILoveMovies(爱尚电影)
//
//  Created by lanou3g on 15/10/27.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import "PosterViewController.h"
// 海报
#define kPosterUrl @"http://apk.zdomo.com/api/apibasic?columnid=3&pageSize=180&pageNum="
// 0&sid=0


#import "PosterCell.h"  // Cell
// 上拉刷新 下拉加载
#import "MJRefresh.h"
#import "MJChiBaoZiHeader.h"
#import "MJChiBaoZiFooter.h"
#import "MJChiBaoZiFooter2.h"



// 遵守协议
@interface PosterViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

// 数组,接收解析数据
@property (nonatomic, strong) NSMutableArray *allDataArray;

// 用于判断是否加载完毕
@property (nonatomic, strong) NSMutableArray *loadDataArray;
// 用于刷新
@property (nonatomic, assign) NSInteger number;
@property (nonatomic, assign) BOOL isLoad;


@end



@implementation PosterViewController

- (void) viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = NO;
}


- (void) viewWillDisappear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = NO;
    // 视图即将消失时,进度圈也消失

    [SVProgressHUD dismiss];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 创建集合视图
    [self addSubViews];
    // 解析数据
    [self setUpData];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    
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


#pragma mark --- 解析数据
- (void) setUpData
{
    self.loadDataArray = [NSMutableArray arrayWithArray:self.allDataArray];
    
    // 加载时等待小菊花
    [SVProgressHUD show];
    
    // 互斥锁,如果正在加载数据,那么刷新操作,不能影响现在的数据加载
    if (_isLoad == NO) {
        _isLoad = YES;
        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%ld&sid=0", kPosterUrl, _number]];
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
                
                if (_number == 0) {
                    // 初始化数组
                    self.allDataArray = [NSMutableArray array];
                }
                
                // 遍历数组
                for (NSDictionary *dic in array) {
                    // 初始化model
                    MovieModel *posterModel = [[MovieModel alloc] init];
                    [posterModel setValuesForKeysWithDictionary:dic];
                    // 装进数组
                    [self.allDataArray addObject:posterModel];
                }
                
                // 回到主线程
                dispatch_async(dispatch_get_main_queue(), ^{
                    // 全部加载完毕
                    if ([self.allDataArray isEqualToArray:self.loadDataArray]) {
                        self.collectionView.footer.state = MJRefreshStateNoMoreData;
                    }
                    
                    // 刷新页面
                    [self.collectionView reloadData];
                    
                    _isLoad = NO;
                    
                    // 加载完,小菊花消失
                    [SVProgressHUD dismiss];
                });
            }];
            [dataTask resume];
        });
    }
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
    layout.itemSize = CGSizeMake((kScreenWidth - 5*2 - 5*2) / 3.0, 180);
    // 内边距
    layout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    // 设置代理
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    // collectionView默认为黑色
    self.collectionView.backgroundColor = [UIColor yellowColor];
    // 显示视图
    [self.view addSubview:self.collectionView];
    
    // 注册 要用到的cell
    [self.collectionView registerClass:[PosterCell class] forCellWithReuseIdentifier:@"PosterCell"];
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
    return self.allDataArray.count;
}

// cell样式
- (UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PosterCell *posterCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PosterCell" forIndexPath:indexPath];
    
    // 取出cell对应的model
    if (self.allDataArray.count > 0) {
        MovieModel *posterModel = self.allDataArray[indexPath.row];
        posterCell.posterModel = posterModel;
    }
    return posterCell;
}


// 点击事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // 让代理干活
    [self.delegate pushERPosterVCWithIndexPath:indexPath allDataArray:self.allDataArray];
}


#pragma mark --- 懒数据加载
- (NSMutableArray *) allDataArray
{
    if (!_allDataArray) {
        _allDataArray = [NSMutableArray array];
    }
    return _allDataArray;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
