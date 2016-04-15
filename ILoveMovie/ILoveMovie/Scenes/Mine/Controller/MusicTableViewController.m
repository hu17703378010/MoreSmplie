//
//  MusicTableViewController.m
//  ILoveMovie
//
//  Created by lanou3g on 15/11/3.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import "MusicTableViewController.h"
#import "MusicObject.h"
#import "MusicPlayerVC.h"
@interface MusicTableViewController ()
@property (nonatomic,retain)NSMutableArray *dataArray;
@end

@implementation MusicTableViewController


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return  self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpData];
    self.navigationItem.title =@"音乐收藏";
     [self.tableView setSeparatorStyle:(UITableViewCellSeparatorStyleNone)];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"reuseIdentifier"];
    
    // 左返回
    UIBarButtonItem *imageBarButton = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"iconfont-fanhui(1)"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)] style:(UIBarButtonItemStylePlain) target:self action:@selector(actionImageBarButton:)];
    self.navigationItem.leftBarButtonItem = imageBarButton;
}


- (void)viewWillDisappear:(BOOL)animated
{
    [SVProgressHUD dismiss];
    
}

- (void)actionImageBarButton:(UIBarButtonItem *)imageBarButton
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUpData
{
    [SVProgressHUD show];
    
    AVUser *user = [AVUser currentUser];
    AVRelation *relation = [user relationforKey:@"MusicObject"];
    [[relation query] findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        self.dataArray = [NSMutableArray arrayWithArray:objects];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
            [SVProgressHUD dismiss];
        });
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier" forIndexPath:indexPath];
     cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    UIView *view1 = [[UIView alloc]init];
    view1.backgroundColor = [UIColor clearColor];
    cell.selectedBackgroundView = view1;
    MusicObject *object = self.dataArray[indexPath.row];
    cell.textLabel.text = [object valueForKey:@"musicName"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MusicObject *object = self.dataArray[indexPath.row];
    MusicPlayerVC *mpVC = [[MusicPlayerVC alloc]init];
    mpVC.musicName = [object valueForKey:@"musicName"];
    mpVC.urlString = [object valueForKey:@"urlString"];
    mpVC.flag = @"SHOUCANG";
    [self.navigationController pushViewController:mpVC animated:YES];
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        MusicObject *model = self.dataArray[indexPath.row];
        [self.dataArray removeObject:model];
        [self.tableView reloadData];
        [SVProgressHUD showWithStatus:@"正在删除"];
        AVUser *user = [AVUser currentUser];
        if ([[model class] isSubclassOfClass:[MusicObject class]]) {
            AVRelation *relation = [user relationforKey:@"MusicObject"];
            [relation removeObject:model];
            [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (succeeded) {
                    [SVProgressHUD dismiss];
                }
            }];
        }
    }
}

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
