//
//  HeadLineViewController.m
//  ILoveMovies(爱尚电影)
//
//  Created by lanou3g on 15/10/27.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import "HeadLineViewController.h"
#import "HeadLineTableViewCell.h"
#import "HeadLineModel.h"
// 刷新
#import "MJRefresh.h"
#import "MJChiBaoZiHeader.h"
#import "MJChiBaoZiFooter.h"
#import "MJChiBaoZiFooter2.h"

// 头条接口
#define kHeadLineUrl @"http://sfzdy.yingyongjingling.com:20610/v2/video/headline?pageSize=10&versionCode=17&versionName=1.1.0&email=&pageNo="
#define kHeadUrl @"&clientType=ANDROID"
@interface HeadLineViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *dataArray;
@property (nonatomic, assign)NSInteger number;

// 用于刷新
@property (nonatomic, assign) BOOL isLoad;
@property (nonatomic, strong) NSMutableArray *allDataArray;
@end

@implementation HeadLineViewController
- (void) viewWillDisappear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = NO;
    [SVProgressHUD dismiss];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _number = 1;
    [self setTableView];
    [self setUpData];
    // 注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"HeadLineTableViewCell" bundle:nil] forCellReuseIdentifier:@"HeadLineCell"];
    [self.tableView setSeparatorStyle:(UITableViewCellSeparatorStyleNone)];
    // 下拉设置回调
     self.tableView.header = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    // 马上进入刷新状态
    [self.tableView.header beginRefreshing];
    
    // 上啦回调
    self.tableView.footer = [MJChiBaoZiFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
}

- (void)loadNewData
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        if (_number > 1) {
//            _number--;
//            [self setUpData];
//        }
        _number = 1;
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
        
        if (_isLoad == NO) {
            
            _number++;
            [self setUpData];
            // 刷新tableView
            [self.tableView reloadData];
            // 下拉结束刷新
            [self.tableView.footer endRefreshing];
        }
        _isLoad = YES;
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
// tableView
- (void)setTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 140) style:(UITableViewStylePlain)];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
}
// 数据解析
- (void)setUpData
{
    self.allDataArray = [NSMutableArray arrayWithArray:self.dataArray];
    
    // 加载时等待小菊花
    [SVProgressHUD show];
    // 子线程
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%ld%@", kHeadLineUrl, _number, kHeadUrl]];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30.0];
        [request setHTTPMethod:@"GET"];
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration ephemeralSessionConfiguration];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
        NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (!data) {
                [SVProgressHUD showErrorWithStatus:@"加载失败"];
                return;
            }
            NSMutableDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSMutableArray *array = [dic valueForKey:@"resultData"];
            
            if (_number == 1) {
                self.dataArray = [NSMutableArray array];
            }
            
            for (NSMutableDictionary *dic in array) {
                HeadLineModel *model = [[HeadLineModel alloc] init];
                [model setValuesForKeysWithDictionary:dic];
                [self.dataArray addObject:model];
            }
            // 主线程
            dispatch_async(dispatch_get_main_queue(), ^{
                
                // 加载完毕
                if ([self.dataArray isEqualToArray:self.allDataArray]) {
                    self.tableView.footer.state = MJRefreshStateNoMoreData;
                }
                
                [self.tableView reloadData];
                // 加载完成,菊花消失
                [SVProgressHUD dismiss];
                _isLoad = NO;
            });
        }];
        [dataTask resume];
    });
    
}


#pragma mark - tableView代理方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HeadLineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HeadLineCell" forIndexPath:indexPath];
    // 赋值保护
    if (self.dataArray.count > 0) {
        // 给model赋值
        cell.model = self.dataArray[indexPath.row];
    }
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 发送通知
    HeadLineModel *model = self.dataArray[indexPath.row];
    // 传递videoId
    [[NSNotificationCenter defaultCenter] postNotificationName:@"HEADLINE" object:@{@"videoId":model.videoId, @"videoName":model.videoName}];

    
}




@end
