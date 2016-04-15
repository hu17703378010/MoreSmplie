//
//  CollectViewController.m
//  ILoveMovie
//
//  Created by lanou3g on 15/11/2.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import "CollectViewController.h"
#import "MusicTableViewController.h"
#import "TopTableViewController.h"
#import "ChartTableViewController.h"
#import "HappyTableViewController.h"
#import "MovieCommentViewController.h"

@interface CollectViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong)UITableView *tableView;
@end

@implementation CollectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.view.backgroundColor = [UIColor whiteColor];
    [self addSubView];
    
    // 左返回
    UIBarButtonItem *imageBarButton = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"iconfont-fanhui(1)"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)] style:(UIBarButtonItemStylePlain) target:self action:@selector(actionImageBarButton:)];
    self.navigationItem.leftBarButtonItem = imageBarButton;
}
- (void)actionImageBarButton:(UIBarButtonItem *)imageBarButton
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.tabBarController.tabBar setHidden:YES];
}


- (void)viewWillDisappear:(BOOL)animated
{
    [SVProgressHUD dismiss];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)addSubView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 330) style:(UITableViewStylePlain)];
    [self.tableView setSeparatorStyle:(UITableViewCellSeparatorStyleNone)];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.scrollEnabled =NO; //设置tableview 不能滚动
    [self.view addSubview:self.tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *indefier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indefier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:indefier];
    }
    UIView *view1 = [[UIView alloc]init];
    view1.backgroundColor = [UIColor clearColor];
    cell.selectedBackgroundView = view1;
    if (indexPath.row == 0) {
        UIView *view1 = [[UIView alloc]init];
        view1.backgroundColor = [UIColor clearColor];
        cell.selectedBackgroundView = view1;
    }
    switch (indexPath.row) {
        case 1:
            cell.textLabel.text = @"专题";
            break;
        case 2:
            cell.textLabel.text = @"图解";
            break;
        case 3:
            cell.textLabel.text = @"音乐";
            break;
        case 4:
            cell.textLabel.text = @"轻松一刻";
            break;
        case 5:
            cell.textLabel.text = @"影评";
            break;

        default:
            break;
    }
    if (indexPath.row != 0) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 3) {
        MusicTableViewController *musicVC = [[MusicTableViewController alloc] init];
        musicVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:musicVC animated:YES];
    }  else if (indexPath.row == 2) {
        ChartTableViewController *chatVC = [[ChartTableViewController alloc] init];
        chatVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:chatVC animated:YES];
    } else if (indexPath.row == 4) {
        HappyTableViewController *happyVC = [[HappyTableViewController alloc] init];
        happyVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:happyVC animated:YES];
    } else if (indexPath.row == 5) {
        MovieCommentViewController *happyVC = [[MovieCommentViewController alloc] init];
        happyVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:happyVC animated:YES];
    } else if (indexPath.row == 1) {
        TopTableViewController *topVC = [[TopTableViewController alloc] init];
       topVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:topVC animated:YES];
    }
}

@end
