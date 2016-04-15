//
//  TopTableViewController.m
//  ILoveMovie
//
//  Created by lanou3g on 15/11/3.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import "TopTableViewController.h"
#import "TopDetalisViewController.h"
#import "TopObject.h"
#import "TopModel.h"
#import "MovieCommentTableViewCell.h"

@interface TopTableViewController ()
@property (nonatomic, retain)NSMutableArray *dataArray;

@end

@implementation TopTableViewController

- (void)viewWillDisappear:(BOOL)animated
{
    [SVProgressHUD dismiss];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
     [self.tableView setSeparatorStyle:(UITableViewCellSeparatorStyleNone)];
    [self.tableView registerNib:[UINib nibWithNibName:@"MovieCommentTableViewCell" bundle:nil] forCellReuseIdentifier:@"MovieCommentTableViewCell"];
    [self setUpData];
    [self.tabBarController.tabBar setHidden:YES];
    self.navigationItem.title =@"专题收藏";
    
    
    // 左返回
    UIBarButtonItem *imageBarButton = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"iconfont-fanhui(1)"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)] style:(UIBarButtonItemStylePlain) target:self action:@selector(actionImageBarButton:)];
    self.navigationItem.leftBarButtonItem = imageBarButton;
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
    AVRelation *relation = [user relationforKey:@"TopObject"];
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
    MovieCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MovieCommentTableViewCell" forIndexPath:indexPath];
    TopObject *object = self.dataArray[indexPath.row];
     cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    UIView *view1 = [[UIView alloc]init];
    view1.backgroundColor = [UIColor clearColor];
    cell.selectedBackgroundView = view1;
    cell.MovieTitleLabel.text = [object valueForKey:@"topicName"];
    [cell.MovieImageView sd_setImageWithURL:[NSURL URLWithString:[object valueForKey:@"previewImage"]] placeholderImage:[UIImage imageNamed:@"c_placeHolder.jpg"]];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TopDetalisViewController *mCDVC = [[TopDetalisViewController alloc]init];
    TopObject *object = self.dataArray[indexPath.row];
    TopModel *model = [[TopModel alloc]init];
    model.previewImage = [object valueForKey:@"previewImage"];
    model.topicName = [object valueForKey:@"topicName"];
    model.watchCount = [object valueForKey:@"watchCount"];
    model.detailIntroduction = [object valueForKey:@"detailIntroduction"];
    model.topicId = [object valueForKey:@"topicId"];
    mCDVC.model = model;
    mCDVC.flag = @"SHOUCANG";
    [self.navigationController pushViewController:mCDVC animated:YES];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        TopObject *model = self.dataArray[indexPath.row];
        [self.dataArray removeObject:model];
        [self.tableView reloadData];
        [SVProgressHUD showWithStatus:@"正在删除"];
        AVUser *user = [AVUser currentUser];
        if ([[model class] isSubclassOfClass:[TopObject class]]) {
            AVRelation *relation = [user relationforKey:@"TopObject"];
            [relation removeObject:model];
            [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (succeeded) {
                    [SVProgressHUD dismiss];
                }
            }];
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
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
