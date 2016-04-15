//
//  ERMovieOriginalSoundViewController.m
//  ILoveMovie
//
//  Created by lanou3g on 15/10/30.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import "ERMovieOriginalSoundViewController.h"
#import "ERMovieOriginalSoundViewCell.h"
#import "MusicPlayerVC.h"
#define KW self.view.frame.size.width/375
#define KH self.view.frame.size.height/667

@interface ERMovieOriginalSoundViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,retain)UIImageView *bgImageView;
@property (nonatomic,retain)UIImageView *musicImageView;
@property (nonatomic,retain)UILabel *titleLabel;
@property (nonatomic,retain)UILabel *introductionLabel;
@property (nonatomic,retain)UITableView *tableView;
@property (nonatomic,retain)NSMutableArray *dataArray;

@end

@implementation ERMovieOriginalSoundViewController

- (void) viewWillDisappear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = NO;
}

- (void) viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpData];
    self.view.backgroundColor = [UIColor whiteColor];
    [self addTableViews];
    // 左返回
    UIBarButtonItem *imageBarButton = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"iconfont-fanhui(1)"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)] style:(UIBarButtonItemStylePlain) target:self action:@selector(actionImageBarButton:)];
    self.navigationItem.leftBarButtonItem = imageBarButton;
}

- (void)actionImageBarButton:(UIBarButtonItem *)imageBarButton
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)actionBACK:(UIBarButtonItem *)item
{
    [self.tabBarController.tabBar setHidden:NO];
    [self.navigationController popToRootViewControllerAnimated:YES];
}


- (void)addTableViews
{
    [self addHeadView];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:(UITableViewStyleGrouped)];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.tableHeaderView = self.bgImageView;
    [self.view addSubview:self.tableView];
    self.tableView.bounces = NO;
    [self.tableView setShowsVerticalScrollIndicator:NO];
    [self.tableView registerNib:[UINib nibWithNibName:@"ERMovieOriginalSoundViewCell" bundle:nil] forCellReuseIdentifier:@"ERMovieOriginalSoundViewCell"];
}

- (void)addHeadView
{
    self.bgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 20*KH, self.tableView.frame.size.width, 240*KH)];
    self.bgImageView.backgroundColor = [UIColor clearColor];
    self.musicImageView = [[UIImageView alloc]initWithFrame:CGRectMake(30*KW, 20*KH, 124*KH, 124*KH)];
    [self.musicImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://apk.zdomo.com%@",self.model.PicURL]] placeholderImage:[UIImage imageNamed:@"f_placeHolder.jpg"]];
    self.musicImageView.backgroundColor = [UIColor clearColor];
    [self.bgImageView addSubview:self.musicImageView];
    [self.view addSubview:self.bgImageView];
    
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(180*KW, 70*KH, 300*KW, 30*KH)];
    self.titleLabel.text = self.model.Title;
    self.titleLabel.font = [UIFont systemFontOfSize:22*KW];
    [self.bgImageView addSubview:self.titleLabel];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(30*KW, 154*KH, 50*KW, 30*KH)];
    label.text = @"简介:";
    [self.bgImageView addSubview:label];
    
    self.introductionLabel = [[UILabel alloc]initWithFrame:CGRectMake(90*KW, 154*KH, 270*KW, 90*KH)];
    self.introductionLabel.text = self.model.Introduction;
    self.introductionLabel.numberOfLines = 0;
    self.introductionLabel.font = [UIFont systemFontOfSize:12*KW];
    [self.bgImageView addSubview:self.introductionLabel];
}

- (void)setUpData
{

    NSString *string = self.model.Content;
    string = [string stringByReplacingOccurrencesOfString:@"{}?zjmoviezdomo=1" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"{}&zjmoviezdomo=1" withString:@""];
    NSArray *array = [string componentsSeparatedByString:@"{}"];
    self.dataArray = [NSMutableArray array];
    for(int i = 0; i < array.count; i++){
        NSString *string = array[i];
        NSArray *array = [string componentsSeparatedByString:@"<>"];
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setValue:array[0] forKey:@"name"];
        [dic setValue:array[1] forKey:@"url"];
        [self.dataArray addObject:dic];
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20*KH;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"歌曲列表";
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ERMovieOriginalSoundViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ERMovieOriginalSoundViewCell" forIndexPath:indexPath];
    cell.musicNameLabel.text = [self.dataArray[indexPath.row] objectForKey:@"name"];
    cell.musicNameLabel.font = [UIFont systemFontOfSize:15*KW];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50*KH;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MusicPlayerVC *mPVC = [[MusicPlayerVC alloc]init];
    mPVC.urlString = [self.dataArray[indexPath.row] objectForKey:@"url"];
    mPVC.musicName = [self.dataArray[indexPath.row] objectForKey:@"name"];
    mPVC.flag = @"YUANSHENG";
    [self.navigationController pushViewController:mPVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
