//
//  RelaxMomentTableViewController.m
//  ILoveMovies(爱尚电影)
//
//  Created by lanou3g on 15/10/27.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import "RelaxMomentTableViewController.h"

// 轻松一刻 一级页面接口
#define kRelaxMomentUrl @"http://apk.zdomo.com/api/apibasic?columnid=5&pageSize=20&pageNum="
// 0&sid=0

#import "RelaxMomentCell.h"  // 自定义cell
#import "MovieModel.h"  // 自定义Model

// 加载等待小菊花
// [SVProgressHUD dismiss];
// [SVProgressHUD showErrorWithStatus:@"网络不稳定,加载失败"];


// 上拉刷新 下拉加载
#import "MJRefresh.h"
#import "MJChiBaoZiHeader.h"
#import "MJChiBaoZiFooter.h"
#import "MJChiBaoZiFooter2.h"



// 遵守协议
@interface RelaxMomentTableViewController ()<UITableViewDataSource, UITableViewDelegate>

// 用于判断是否加载完毕
@property (nonatomic, strong) NSMutableArray *loadDataArray;
// 定义数组,接收解析数据
@property (nonatomic, strong) NSMutableArray *allDataArray;

// 用于刷新
@property (nonatomic, assign) NSInteger number;
@property (nonatomic, assign) BOOL isLoad;
@end



@implementation RelaxMomentTableViewController
- (void) viewWillDisappear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = NO;
    [SVProgressHUD dismiss];
}

- (void) viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = NO;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    
        // 取消cell的分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // 解析数据
    [self setUpData];
    
    _number = 0;
    // 下拉设置回调
    self.tableView.header = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    // 马上进入刷新状态
    [self.tableView.header beginRefreshing];
    
    // 上拉回调
    self.tableView.footer = [MJChiBaoZiFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}

- (void)loadNewData
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        _number = 0;
        [self setUpData];
        
        // 刷新tableView
        [self.tableView reloadData];
        // 下拉结束刷新
        [self.tableView.header endRefreshing];
    });
}
- (void)loadMoreData
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        _number++;
        [self setUpData];
        // 刷新tableView
        [self.tableView reloadData];
        // 下拉结束刷新
        [self.tableView.footer endRefreshing];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark --- 解析数据
- (void) setUpData
{
    self.loadDataArray = [NSMutableArray arrayWithArray:self.allDataArray];
    
    // 加载时等待小菊花
    [SVProgressHUD show];
    
    if (_isLoad == NO) {
        _isLoad = YES;
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%ld&sid=0", kRelaxMomentUrl, _number]];
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
                    MovieModel *relaxModel = [[MovieModel alloc] init];
                    [relaxModel setValuesForKeysWithDictionary:dic];
                    // 装进数组
                    [self.allDataArray addObject:relaxModel];
                }
                // 回到主线程
                dispatch_async(dispatch_get_main_queue(), ^{
                    // 全部加载完毕
                    if ([self.allDataArray isEqualToArray:self.loadDataArray]) {
                        self.tableView.footer.state = MJRefreshStateNoMoreData;
                    }
                    
                    _isLoad = NO;
                    // 刷新页面
                    [self.tableView reloadData];
                    
                    // 加载完,小菊花消失
                    [SVProgressHUD dismiss];
                });
            }];
            [dataTask resume];
        });
    }
}



#pragma mark - Table view 协议方法实现
// 分区数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

// 分区行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.allDataArray.count;
}

// cell样式
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"relaxCell";
    RelaxMomentCell *relaxCell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (relaxCell == nil) {
        relaxCell = [[RelaxMomentCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
    }
    // 赋值
    if (self.allDataArray.count > 0) {
        relaxCell.relaxModel = self.allDataArray[indexPath.row];
    }

    return relaxCell;
}

// 行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}

// 跳转方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MovieModel *model  = self.allDataArray[indexPath.row];
    [SVProgressHUD show];
    [self.delegate pushWithModel:model];
}

#pragma mark --- 懒数据加载
- (NSMutableArray *) allDataArray
{
    if (!_allDataArray) {
        _allDataArray = [NSMutableArray array];
    }
    return _allDataArray;
}


@end