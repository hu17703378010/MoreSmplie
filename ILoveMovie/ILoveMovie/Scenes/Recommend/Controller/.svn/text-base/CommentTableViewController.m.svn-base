//
//  CommentTableViewController.m
//  ILoveMovie
//
//  Created by lanou3g on 15/10/29.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import "CommentTableViewController.h"
#import "CommentTableViewCell.h"  // 自定义cell
#import "MovieModel.h"  // model

// 上拉刷新 下拉加载
#import "MJRefresh.h"
#import "MJChiBaoZiHeader.h"
#import "MJChiBaoZiFooter.h"
#import "MJChiBaoZiFooter2.h"

// 电影说说
#define kCommentUrl @"http://apk.zdomo.com/api/apibasic?columnid=2&pageSize=20&pageNum="
// 0&sid=0


@interface CommentTableViewController ()
// 定义数组,接收解析数据
@property (nonatomic, strong) NSMutableArray *allDataArray;
// 用于刷新
@property (nonatomic, assign) NSInteger number;


// 刷新互斥锁
@property (nonatomic,assign)BOOL isRefreshing;
@end



@implementation CommentTableViewController

- (void) viewWillDisappear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = NO;
    [SVProgressHUD dismiss];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.isRefreshing = YES;
    // 解析数据
    [self setUpData];
    // 去掉cell分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
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
//        if (_number > 1) {
//            _number--;
//            [self setUpData];
//        }
        _number = 0;
        // 初始化数组
        self.allDataArray = [NSMutableArray array];
        [self setUpData];
        // 刷新tableView
        [self.tableView reloadData];
        // 下拉结束刷新
        [self.tableView.header endRefreshing];
    });
}
- (void)loadMoreData
{
    if (self.isRefreshing) {
        self.isRefreshing = NO;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            _number++;
            [self setUpData];

            // 下拉结束刷新
            [self.tableView.footer endRefreshing];
        });
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark --- 数据解析
- (void)setUpData
{
    // 加载时等待小菊花
    [SVProgressHUD show];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%ld&sid=0", kCommentUrl, _number]];
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
                // 初始化model
                MovieModel *commendModel = [[MovieModel alloc]init];
                [commendModel setValuesForKeysWithDictionary:dic];
                [self.allDataArray addObject:commendModel];
            }
            // 回到主线程
            dispatch_async(dispatch_get_main_queue(), ^{
                // 刷新数据
                [self.tableView reloadData];
                self.isRefreshing = YES;
                // 加载完成,菊花消失
                [SVProgressHUD dismiss];
            });
        }];
        [dataTask resume];
    });
}


#pragma mark - TableView协议方法实现
// 分区数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

// 分区行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.allDataArray.count;
}

// 行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"commentCell";
    CommentTableViewCell *commentCell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (commentCell == nil) {
        commentCell = [[CommentTableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
    }
    // cell赋值
    if (self.allDataArray.count > 0) {
        MovieModel *model = self.allDataArray[indexPath.row];
        commentCell.commendModel = model;
        UIView *view = [[UIView alloc]initWithFrame:commentCell.commentLabel.frame];
        view.backgroundColor = commentCell.commentLabel.backgroundColor;
        commentCell.selectedBackgroundView = view;
    }
    return commentCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     MovieModel *model = self.allDataArray[indexPath.row];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SHUOSHUO" object:@{@"model": model}];
}




@end
