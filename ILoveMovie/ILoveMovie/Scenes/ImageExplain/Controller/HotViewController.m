//
//  HotViewController.m
//  ILoveMovies(爱尚电影)
//
//  Created by lanou3g on 15/10/27.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import "HotViewController.h"
#import "HotTableViewCell.h"
#import "HotModel.h"

@interface HotViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *dataArray; // 接受数据
@end

@implementation HotViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    [self setTableView];
    [self setUpData];
    // 注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"HotTableViewCell" bundle:nil] forCellReuseIdentifier:@"HotCell"];
}

- (void) viewWillDisappear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = NO;
    [SVProgressHUD dismiss];
}
- (void)setTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 140)];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
       [self.tableView setSeparatorStyle:(UITableViewCellSeparatorStyleNone)];
    [self.view addSubview:self.tableView];
}

// 数据局解析
- ( void)setUpData
{

    // 加载时等待小菊花
    [SVProgressHUD show];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSURL *url = [NSURL URLWithString:kHotUrl];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30.0];
        [request setHTTPMethod:@"GET"];
//        NSURLSessionConfiguration *config = [NSURLSessionConfiguration ephemeralSessionConfiguration];
        //3.创建会话（这里使用了一个全局会话）并且启动任务
        NSURLSession *session = [NSURLSession sharedSession];
        //从会话创建任务
        NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (!data) {
                [SVProgressHUD showErrorWithStatus:@"加载失败"];
                return;
            }
            NSMutableDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSMutableArray *array = [dic valueForKey:@"resultData"];
            self.dataArray = [NSMutableArray array];
            for (NSMutableDictionary *dic in array) {
                HotModel *model = [[HotModel alloc] init];
                [model setValuesForKeysWithDictionary:dic];
                [self.dataArray addObject:model];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                  [self.tableView reloadData];
                // 加载完成,菊花消失
                [SVProgressHUD dismiss];
            });
        }];

        //恢复线程，启动任务
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
    HotTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HotCell" forIndexPath:indexPath ];
    if (self.dataArray.count > 0) {
        // model赋值
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
    
    // HotViewController 是在pageController 没有navigationController, 所以无法跳转, 要发送通知到
    //  发送通知,
    // object:@{@"videoId":model.videoId}  一个字典, model.videoId字典的值value
    // @"REYINGONE" 标识符, 大写
    HotModel *model = self.dataArray[indexPath.row];
    [_delegate getWithVideoId:model.videoId VideoName:model.videoName];
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"REYINGONE" object:@{@"videoId":model.videoId,@"videoName":model.videoName}];
}

//- (void)getWithVideoId:(NSString *)videoId VideoName:(NSString *)VideoName
//{
//    [_HotDelegate ]
//}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
