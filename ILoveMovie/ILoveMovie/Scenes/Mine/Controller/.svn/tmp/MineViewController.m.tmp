//
//  MineViewController.m
//  ILoveMovies(爱尚电影)
//
//  Created by lanou3g on 15/10/27.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import "MineViewController.h"
#import "CollectViewController.h"
#import "AboutOurViewController.h"
#define KW self.view.frame.size.width/375
#define KH self.view.frame.size.height/667
@interface MineViewController ()<UITableViewDataSource, UITableViewDelegate,LoginViewControllerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic,retain)UIButton *nameLableButton; // 登录的button

@property (nonatomic,retain)UIButton *headerImageViewButton;

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的电影院";
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0.8 green:0.247 blue:0.314 alpha:0.580]];
    [self addSubView];
}

- (void)viewDidDisappear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewWillAppear:(BOOL)animated
{
    // 隐藏导航栏
    self.navigationController.navigationBarHidden = YES;
    [self.tabBarController.tabBar setHidden:NO];
   [self refreshMyView];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)addSubView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, -20, kScreenWidth, kScreenHeight) style:(UITableViewStyleGrouped)];
                      
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.scrollEnabled =NO; //设置tableview 不能滚动
    // 添加表头
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 240*KH)];
    // 背景图片
    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 250*KH)];
    // 打开图片交互
     bgImageView.userInteractionEnabled=YES;
    UIImage *bgHeaderImage = [UIImage imageNamed:@"bgHeader.jpg"];
    bgImageView.image = bgHeaderImage;
    [headerView addSubview:bgImageView];
    // 头像
    self.headerImageViewButton = [[UIButton alloc] initWithFrame:CGRectMake((kScreenWidth - 80*KW) / 2, (200*KH - 120*KH) / 2*KH, 80*KW, 80*KW)];
   self.headerImageViewButton.layer.cornerRadius = self.headerImageViewButton.frame.size.width / 2*KW; //把正方形变成圆形
   self.headerImageViewButton.layer.masksToBounds = YES;
    [bgImageView addSubview:self.headerImageViewButton];
    [self.headerImageViewButton addTarget:self action:@selector(headerButton:) forControlEvents:(UIControlEventTouchUpInside)];
    // 用户名
    self.nameLableButton = [[UIButton alloc] initWithFrame:CGRectMake((kScreenWidth - 200*KW) / 2, self.headerImageViewButton.bottom + 10*KH, 200*KW, 40*KH)];
    [self.nameLableButton addTarget:self action:@selector(loginButton:) forControlEvents:(UIControlEventTouchUpInside)];
    // 字体居中
   // nameLable.textAlignment = NSTextAlignmentCenter;
    [bgImageView addSubview:self.nameLableButton];
    [self refreshMyView];
    // 更换夜间模式
    UIButton *dayAndNightButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    dayAndNightButton.frame = CGRectMake((bgImageView.right - 60*KW), 40*KH, 30*KH, 30*KH);
    [dayAndNightButton setImage:[UIImage imageNamed:@"day.png"] forState:(UIControlStateNormal)];
    [dayAndNightButton setImage:[UIImage imageNamed:@"night.png"] forState:(UIControlStateSelected)];
    [dayAndNightButton addTarget:self action:@selector(dayButton:) forControlEvents:(UIControlEventTouchUpInside)];
    [bgImageView addSubview:dayAndNightButton];
    headerView.backgroundColor = [UIColor redColor];
    self.tableView.tableHeaderView = headerView;
    
    [self.view addSubview:self.tableView];
}
// 夜间模式切换点击模式
- (void)dayButton:(UIButton *)dayButton
{
    dayButton.selected = !dayButton.selected;
    if (dayButton.selected) {
        // 夜间模式
        [[[UIApplication sharedApplication] delegate]window].alpha = 0.5;
    } else {
        [[[UIApplication sharedApplication] delegate]window].alpha = 1;
    }
}


//刷新界面
- (void)refreshMyView
{
    AVUser *user = [AVUser currentUser];
    if (user) {
        NSString *userName = user.username;
        [self.nameLableButton setTitle:userName forState:(UIControlStateNormal)];
        [self.nameLableButton setTitle:userName forState:(UIControlStateHighlighted)];
        
        if ([[user valueForKey:@"photoImage"] isEqual:[NSNull null]]) {
            UIImage *headerImage = [UIImage imageNamed:@"header.png"];
            [self.headerImageViewButton setImage:headerImage forState:(UIControlStateNormal)];
        } else {
            [[user valueForKey:@"photoImage"] getThumbnail:NO width:300*KW height:300*KH withBlock:^(UIImage *image, NSError *error) {
                UIImage *headerImage = image;
                [self.headerImageViewButton setImage:headerImage forState:(UIControlStateNormal)];
                [self.headerImageViewButton setImage:headerImage forState:(UIControlStateHighlighted)];
            }];
        }
    } else {
        UIImage *headerImage = [UIImage imageNamed:@"header.png"];
        [self.headerImageViewButton setImage:headerImage forState:(UIControlStateNormal)];
        [self.nameLableButton setTitle:@"点击登录" forState:(UIControlStateNormal)];
        [self.nameLableButton setTitle:@"点击登录" forState:(UIControlStateHighlighted)];
    }
}


//登录方法
- (void)loginButton:(UIButton *)button
{
    AVUser *user = [AVUser currentUser];
    if (user) {
        [self showAlterViewWithTitle:@"提示" Message:@"已登录"];
    } else {
        LoginViewController *loginVC = [[LoginViewController alloc]init];
        UINavigationController *navC = [[UINavigationController alloc]initWithRootViewController:loginVC];
        loginVC.delegate = self;
        navC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        [self presentViewController:navC animated:YES completion:nil];
    }
}

- (void)changeMineVC
{
    [self showAlterViewWithTitle:@"提示" Message:@"已登录成功"];
    [self refreshMyView];
}

//上传图片方法
- (void)headerButton:(UIButton *)button
{
    AVUser *user = [AVUser currentUser];
    if (user) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;
            picker.allowsEditing = YES;
            // 打开相册选择图片
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            // 模态进入相册
            [self presentViewController:picker animated:NO completion:nil];
        }
    } else {
        [self showAlterViewWithTitle:@"提示" Message:@"请先登录"];
    }
}

//选择相册完成后自动调用的方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
   
    NSData *imageData = UIImagePNGRepresentation(image);
    AVUser *user = [AVUser currentUser];
    [self.headerImageViewButton setBackgroundImage:image forState:UIControlStateNormal];
    AVFile *photoImage = [AVFile fileWithName:[NSString stringWithFormat:@"%@.png",user.username] data:imageData];
    [user setObject:photoImage forKey:@"photoImage"];
    
    [user saveInBackground];
    [self refreshMyView];
    [self dismissViewControllerAnimated:YES completion:nil];
}

//退出登录方法
- (void)actionButton:(UIButton *)button
{
   AVUser *user = [AVUser currentUser];
    if (user) {
        [AVUser logOut];
        [self showAlterViewWithTitle:@"提示" Message:@"已经退出登录"];
        [self.nameLableButton setTitle:@"点击登录" forState:(UIControlStateNormal)];
        [self.nameLableButton setTitle:@"点击登录" forState:(UIControlStateHighlighted)];
        UIImage *headerImage = [UIImage imageNamed:@"header.png"];
        [self.headerImageViewButton setImage:headerImage forState:(UIControlStateNormal)];
        [self.headerImageViewButton setImage:headerImage forState:(UIControlStateHighlighted)];
        self.tableView.tableFooterView = nil;
        [self.tableView reloadData];
    } else {
        [self showAlterViewWithTitle:@"提示" Message:@"未登录状态"];
    }
}


//封装一个alertView
- (void)showAlterViewWithTitle:(NSString *)title Message:(NSString *)message
{
    UIAlertController *alertView = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [self performSelector:@selector(closeAlter:) withObject:alertView afterDelay:1];
    [self presentViewController:alertView animated:YES completion:nil];
}

// 设置1秒之后消失
- (void)closeAlter:(UIAlertController *)alert
{
    [alert dismissViewControllerAnimated:YES completion:nil];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *indefier = @"MineCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indefier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:indefier];
    }
    UIView *view1 = [[UIView alloc]init];
    view1.backgroundColor = [UIColor clearColor];
    cell.selectedBackgroundView = view1;
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    float cacheSize = [self folderSizeAtPath:path];
    switch (indexPath.section) {
        case 0:
            cell.textLabel.text = @"我的收藏";
            
            cell.imageView.image = [UIImage imageNamed:@"save.png"];
            break;
        case 1:
            cell.textLabel.text = [NSString stringWithFormat:@"清除缓存(%.2fM)",cacheSize];
            cell.imageView.image = [UIImage imageNamed:@"clean.png"];
            break;
        case 2:
            cell.textLabel.text = @"关于我们";
            cell.imageView.image = [UIImage imageNamed:@"aboutUs.png"];
            break;
        default:
            break;
    }
    // 右边辅助按钮的样式
    if (indexPath.section != 1) {
          cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
 
    return cell;
}

//// 表头
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
//    
//    return headerView;
//}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 60*KH;
    }
    return 10*KH;
}

// 表尾
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 2) {
        UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 30*KH)];
        UIButton *button = [UIButton buttonWithType:(UIButtonTypeSystem)];
        button.frame = CGRectMake(kScreenWidth / 4, 40*KH, kScreenWidth / 2, 40*KH);
        button.backgroundColor = [UIColor colorWithRed:0.957 green:0.267 blue:0.357 alpha:1.000];
        [button setTintColor:[UIColor whiteColor]];
        [button.layer setMasksToBounds:YES];//设置按钮的圆角半径不会被遮挡
        [button.layer setCornerRadius:10]; // 设置圆角的大小
        [button.layer setBorderWidth:0.1];//设置边界的宽度
        [button setTitle:@"退出登录" forState:(UIControlStateNormal)];
        [button addTarget:self action:@selector(actionButton:) forControlEvents:(UIControlEventTouchUpInside)];
        [footView addSubview:button];
        return footView;
    } else
        return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 2) {
        return 100*KH;
    }
    return 10*KH;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        AVUser *user = [AVUser currentUser];
        if (user) {
            CollectViewController *collecVC = [[CollectViewController alloc] init];
            [self.navigationController pushViewController:collecVC animated:YES];
             [self.tabBarController.tabBar setHidden:YES];
 
        } else {
            [self showAlterViewWithTitle:@"提示" Message:@"请先登录"];
        }
    } else if (indexPath.section == 2) {
       
        // Storyboard 的跳转
        UIStoryboard *AboutStoryBord = [UIStoryboard storyboardWithName:@"AboutUsStoryboard" bundle:nil];
        AboutOurViewController *aboutVC = [AboutStoryBord instantiateViewControllerWithIdentifier:@"About"];
        [self.navigationController pushViewController:aboutVC animated:YES];
        [self.tabBarController.tabBar setHidden:YES];
    }
    else if (indexPath.section == 1) {
        // 清理缓存
        NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
        [self clearCache:path];
        NSIndexPath *index1 =  [NSIndexPath indexPathForItem:0 inSection:1];
        UITableViewCell *cell1 =  [self.tableView cellForRowAtIndexPath:index1];
        float cacheSize = [self folderSizeAtPath:path];
        cell1.textLabel.text = [NSString stringWithFormat:@"清除缓存(%.2fM)",cacheSize];
        [self showAlterViewWithTitle:@"提示" Message:@"清除缓存成功"];
        UIView *view1 = [[UIView alloc]init];
        view1.backgroundColor = [UIColor clearColor];
        cell1.selectedBackgroundView = view1;
    }
}

//清理缓存
// 计算目录大小
- (float)folderSizeAtPath:(NSString *)path{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    float folderSize;
    if ([fileManager fileExistsAtPath:path]) {
        NSArray *childerFiles = [fileManager subpathsAtPath:path];
        for (NSString *fileName in childerFiles) {
            NSString *absolutePath = [path stringByAppendingPathComponent:fileName];
            folderSize += [self fileSizeAtPath:absolutePath];
        }
        //SDWebImage框架自身计算缓存的实现
        folderSize += [[SDImageCache sharedImageCache] getSize] /1024.0/1024.0;
        return folderSize;
    }
    return 0;
}

// 计算单个文件
- (float)fileSizeAtPath:(NSString *)path{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if([fileManager fileExistsAtPath:path]){
        long long size = [fileManager attributesOfItemAtPath:path error:nil].fileSize;
        return size/1024.0/1024.0;
    }
    return 0;
}

// 清理缓存文件
- (void)clearCache:(NSString *)path{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        NSArray *childerFiles=[fileManager subpathsAtPath:path];
        for (NSString *fileName in childerFiles) {
            //如有需要，加入条件，过滤掉不想删除的文件
            //            if ([fileName isEqualToString:@"com.Lanou.OrangeAmusement"]) {
            //                break;
            //            }
            NSString *absolutePath=[path stringByAppendingPathComponent:fileName];
            [fileManager removeItemAtPath:absolutePath error:nil];
        }
    }
    [[SDImageCache sharedImageCache] cleanDisk];
}

@end
