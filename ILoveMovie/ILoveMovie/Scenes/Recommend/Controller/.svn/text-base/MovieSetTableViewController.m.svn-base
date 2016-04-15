//
//  MovieSetTableViewController.m
//  ILoveMovie
//
//  Created by lanou3g on 15/11/2.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import "MovieSetTableViewController.h"
#import "MovieSetModel.h"
#import "MovieSetTableViewCell.h"
#import "ERMovieSetVC.h"

// 上拉刷新 下拉加载
#import "MJRefresh.h"
#import "MJChiBaoZiHeader.h"
#import "MJChiBaoZiFooter.h"
#import "MJChiBaoZiFooter2.h"

#define kMovieSetUrl @"http://apk.zdomo.com/api/apiFilmAlbum?pageSize=10&pageNum="
// 0


@interface MovieSetTableViewController ()
@property (nonatomic,retain)NSMutableArray *dataArray;
// 用于刷新
@property (nonatomic, assign) NSInteger number;
@property (nonatomic, assign) BOOL isLoad;
@property (nonatomic, retain) NSMutableArray *loadDataArray;
@end



@implementation MovieSetTableViewController

- (void) viewWillDisappear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = NO;
    [SVProgressHUD dismiss];
}
- (void) viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidLoad {
    // self.edgesForExtendedLayout = UIRectEdgeNone;
    
    _number = 0;
    
    [super viewDidLoad];
    [self setUpData];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height + 49) style:(UITableViewStylePlain)];
    self.tableView.frame = [UIScreen mainScreen].bounds;
    [self.tableView registerNib:[UINib nibWithNibName:@"MovieSetTableViewCell" bundle:nil] forCellReuseIdentifier:@"MovieSetTableViewCell"];
    [self.tableView setSeparatorStyle:(UITableViewCellSeparatorStyleNone)];
    // 左返回
    UIBarButtonItem *imageBarButton = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"iconfont-fanhui(1)"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)] style:(UIBarButtonItemStylePlain) target:self action:@selector(actionImageBarButton:)];
    self.navigationItem.leftBarButtonItem = imageBarButton;
    
    // 下拉设置回调
    self.tableView.header = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    // 马上进入刷新状态
    [self.tableView.header beginRefreshing];
    
    // 上拉回调
    self.tableView.footer = [MJChiBaoZiFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}
// 左返回
- (void)actionImageBarButton:(UIBarButtonItem *)imageBarButton
{
    [self.navigationController popToRootViewControllerAnimated:YES];
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


- (void)setUpData
{
    self.loadDataArray = [NSMutableArray arrayWithArray:self.dataArray];

    [SVProgressHUD show];
    
    if (_isLoad == NO) {
        _isLoad = YES;
        dispatch_async(dispatch_get_global_queue(0,0), ^{
            
            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%ld", kMovieSetUrl, _number]];
            NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
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
                    self.dataArray = [NSMutableArray array];
                }
                
                for (NSDictionary *dic  in array) {
                    MovieSetModel *model = [[MovieSetModel alloc]init];
                    [model setValuesForKeysWithDictionary:dic];
                    model.ThePhoto = [NSString stringWithFormat:@"http://apk.zdomo.com/ueditor/net/%@",model.ThePhoto];
                    model.ThePhoto = [model.ThePhoto stringByReplacingOccurrencesOfString:@"net//" withString:@"net/"];
                    model.ThePhoto = [model.ThePhoto stringByReplacingOccurrencesOfString:@"http://apk.zdomo.com/ueditor/net/ueditor/net/upload/image/" withString:@"http://apk.zdomo.com/ueditor/net/upload/image/"];
                    [self.dataArray addObject:model];
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    // 全部加载完毕
                    if ([self.dataArray isEqualToArray:self.loadDataArray]) {
                        self.tableView.footer.state = MJRefreshStateNoMoreData;
                    }
                    
                    _isLoad = NO;
                    [self.tableView reloadData];
                    [SVProgressHUD dismiss];
                });
            }];
            [dataTask resume];
        });

    }
    
    }


#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MovieSetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MovieSetTableViewCell" forIndexPath:indexPath];
    MovieSetModel *model = self.dataArray[indexPath.row];
    cell.movieLabel.text = model.Title;
    [cell.movieImageView sd_setImageWithURL:[NSURL URLWithString:model.ThePhoto] placeholderImage:[UIImage imageNamed:@"c_placeHolder.jpg"]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // http://apk.zdomo.com/api/apiFilmAlbum?id=69
    ERMovieSetVC *erMSVC = [[ERMovieSetVC alloc]init];
    MovieSetModel *model = self.dataArray[indexPath.row];
    erMSVC.urlString = [NSString stringWithFormat:@"http://apk.zdomo.com/api/apiFilmAlbum?id=%@",model.FilmAlbumID];
    [self.navigationController pushViewController:erMSVC animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
