//
//  HappyTableViewController.m
//  ILoveMovie
//
//  Created by lanou3g on 15/11/3.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import "HappyTableViewController.h"
#import "MovieCommentTableViewCell.h"
#import "ERRelaxMomentViewController.h"
#import "RelaxObject.h"
@interface HappyTableViewController ()
@property (nonatomic, retain)NSMutableArray *dataArray;
@end

@implementation HappyTableViewController


- (void)viewWillDisappear:(BOOL)animated
{
    [SVProgressHUD dismiss];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView setSeparatorStyle:(UITableViewCellSeparatorStyleNone)];
    [self.tableView registerNib:[UINib nibWithNibName:@"MovieCommentTableViewCell" bundle:nil] forCellReuseIdentifier:@"MovieCommentTableViewCell"];
    [self setUpData];

    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.navigationItem.title =@"轻松一刻收藏";
    
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
    AVRelation *relation = [user relationforKey:@"RelaxObject"];
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MovieCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MovieCommentTableViewCell" forIndexPath:indexPath];
    RelaxObject *object = self.dataArray[indexPath.row];
     cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    UIView *view1 = [[UIView alloc]init];
    view1.backgroundColor = [UIColor clearColor];
    cell.selectedBackgroundView = view1;
    [cell.MovieImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://apk.zdomo.com%@",[object valueForKey:@"picURL"]]] placeholderImage:[UIImage imageNamed:@"c_placeHolder.jpg"]];
    cell.MovieTitleLabel.text = [object valueForKey:@"title"];
    return cell;
}



- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        RelaxObject *model = self.dataArray[indexPath.row];
        [self.dataArray removeObject:model];
        [self.tableView reloadData];
        [SVProgressHUD showWithStatus:@"正在删除"];
        AVUser *user = [AVUser currentUser];
        if ([[model class] isSubclassOfClass:[RelaxObject class]]) {
            AVRelation *relation = [user relationforKey:@"RelaxObject"];
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
    ERRelaxMomentViewController *mCDVC = [[ERRelaxMomentViewController alloc]init];
    RelaxObject *object = self.dataArray[indexPath.row];
    MovieModel *model1 = [[MovieModel alloc]init];
    model1.Title = [object valueForKey:@"title"];
    model1.Content = [object valueForKey:@"content"];
    model1.PicURL = [object valueForKey:@"picURL"];
    mCDVC.model = model1;
    [self.navigationController pushViewController:mCDVC animated:YES];
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

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
