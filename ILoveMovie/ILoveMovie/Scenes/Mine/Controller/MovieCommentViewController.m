//
//  MovieCommentViewController.m
//  ILoveMovie
//
//  Created by lanou3g on 15/11/5.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import "MovieCommentViewController.h"
#import "MovieObject.h"
#import "MovieCommentTableViewCell.h"
#import "MovieModel.h"
#import "TwoViewController.h"
@interface MovieCommentViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,retain)NSMutableArray *dataArray;
@property (nonatomic,retain)UITableView *tableView;
@end

@implementation MovieCommentViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpData];
    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:(UITableViewStylePlain)];
    [self.tableView setSeparatorStyle:(UITableViewCellSeparatorStyleNone)];
    self.navigationItem.title =@"影评";
     self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"MovieCommentTableViewCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    
    // 左返回
    UIBarButtonItem *imageBarButton = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"iconfont-fanhui(1)"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)] style:(UIBarButtonItemStylePlain) target:self action:@selector(actionImageBarButton:)];
    self.navigationItem.leftBarButtonItem = imageBarButton;
}
- (void)actionImageBarButton:(UIBarButtonItem *)imageBarButton
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) viewWillDisappear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = NO;
    [SVProgressHUD dismiss];
}
- (void)setUpData
{
    [SVProgressHUD show];
    AVUser *user = [AVUser currentUser];
    AVRelation *relation = [user relationforKey:@"MovieObject"];
    [[relation query] findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        self.dataArray = [NSMutableArray arrayWithArray:objects];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
            [SVProgressHUD dismiss];
        });
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MovieCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
     cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    UIView *view1 = [[UIView alloc]init];
    view1.backgroundColor = [UIColor clearColor];
    cell.selectedBackgroundView = view1;
    MovieObject *object = self.dataArray[indexPath.row];
    [cell.MovieImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://apk.zdomo.com%@",[object valueForKey:@"picURL"]]] placeholderImage:[UIImage imageNamed:@"c_placeHolder.jpg"]];
    cell.MovieTitleLabel.text = [object valueForKey:@"title"];
    return cell;
}



- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        MovieObject *model = self.dataArray[indexPath.row];
        [self.dataArray removeObject:model];
        [self.tableView reloadData];
        [SVProgressHUD showWithStatus:@"正在删除"];
        AVUser *user = [AVUser currentUser];
        if ([[model class] isSubclassOfClass:[MovieObject class]]) {
            AVRelation *relation = [user relationforKey:@"MovieObject"];
            [relation removeObject:model];
            [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (succeeded) {
                   [SVProgressHUD dismiss];
                }
            }];
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TwoViewController *mCDVC = [[TwoViewController alloc]init];
    MovieObject *object = self.dataArray[indexPath.row];
    MovieModel *model1 = [[MovieModel alloc]init];
    model1.Title = [object valueForKey:@"title"];
    model1.Content = [object valueForKey:@"content"];
    model1.PicURL = [object valueForKey:@"picURL"];
    mCDVC.model = model1;
    [self.navigationController pushViewController:mCDVC animated:YES];
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
