//
//  ERMovieSetVC.m
//  ILoveMovie
//
//  Created by lanou3g on 15/11/3.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import "ERMovieSetVC.h"
#import "RecommendCollectionViewCell.h"
#import "MovieSetTableViewCell.h"
// #import "ERCommentViewController.h"
#import "TwoViewController.h"

@interface ERMovieSetVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,retain)NSMutableArray *dataArray;
@property (nonatomic,retain)UITableView *tableView;
@end

@implementation ERMovieSetVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpData];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 5, self.view.frame.size.width, self.view.frame.size.height + 49) style:(UITableViewStylePlain)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView setSeparatorStyle:(UITableViewCellSeparatorStyleNone)];
    [self.view addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"MovieSetTableViewCell" bundle:nil] forCellReuseIdentifier:@"MovieSetTableViewCell"];
    
    // 左返回
    UIBarButtonItem *imageBarButton = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"iconfont-fanhui(1)"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)] style:(UIBarButtonItemStylePlain) target:self action:@selector(actionImageBarButton:)];
    self.navigationItem.leftBarButtonItem = imageBarButton;
}

// 左返回
- (void)actionImageBarButton:(UIBarButtonItem *)imageBarButton
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = YES;
}

- (void) viewWillDisappear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = NO;
    [SVProgressHUD dismiss];
}

- (void)setUpData
{
    // 加载时等待小菊花
    [SVProgressHUD show];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSURL *url = [NSURL URLWithString:self.urlString];
      
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
            // 初始化数组
            self.dataArray = [NSMutableArray array];
            // 遍历数组
            for (NSDictionary *dic in array) {
                MovieModel *model = [[MovieModel alloc]init];
                [model setValuesForKeysWithDictionary:dic];
                [self.dataArray addObject:model];
            }
            // 回到主线程
            dispatch_async(dispatch_get_main_queue(), ^{
                // 刷新页面
                [self.tableView reloadData];
                // 加载完成,菊花消失
                [SVProgressHUD dismiss];
            });
        }];
        [dataTask resume];
    });
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MovieSetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MovieSetTableViewCell" forIndexPath:indexPath];
    MovieModel *model = self.dataArray[indexPath.row];
    [cell.movieImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://apk.zdomo.com%@",model.PicURL]] placeholderImage:[UIImage imageNamed:@"c_placeHolder.jpg"]];
    NSLog(@"%@", model.PicURL);
    cell.movieLabel.text = model.Title;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TwoViewController *erCMVC = [[TwoViewController alloc]init];
    erCMVC.model = self.dataArray[indexPath.row];
    [self.navigationController pushViewController:erCMVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/* http://apk.zdomo.com/ueditor/net/upload/image/20150916/c115_3100F8300451.jpg
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
