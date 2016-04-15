//
//  HeadLineAndHotViewController.m
//  ILoveMovie
//
//  Created by lanou3g on 15/11/3.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import "HeadLineAndHotViewController.h"

#import "HeadLineModel.h"
#import "UIImage+CK_ShutScreen.h"
#import "ChartObject.h"
#define kDetailsUrl @"http://sfzdy.yingyongjingling.com:20610/video/download?videoNos=[1]&versionName=1.1.0&phoneNumber=&userToken=&videoDefinition=480P&videoId="
#define kDetailsPlusUrl   @"&clientType=IPHONE"

@interface HeadLineAndHotViewController ()<UITableViewDataSource, UITableViewDelegate,UIWebViewDelegate>
@property (nonatomic,retain)UIWebView *webView;
@property (nonatomic, strong)NSMutableArray *dataArray;
@property (nonatomic,retain)UIImageView *imageView;
@property (nonatomic,assign)BOOL isOpen;
@property (nonatomic,assign)CGFloat height;
@property (nonatomic,retain)UIImage *capWebImage;
// 截屏 分享 收藏
@property (nonatomic, strong) UITableView *moreTableView;
@property (nonatomic,assign)int i;
@property (nonatomic,retain)UIBarButtonItem *item;
@end

@implementation HeadLineAndHotViewController

- (void)viewDidLoad {
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    _i = 1;
    [self setUpData];
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth - 10*KW, kScreenHeight - 70*KH)];
   // [self loadWebView];
    [super viewDidLoad];
    self.item = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"iconfont-fenlei(1)"] style:(UIBarButtonItemStyleDone) target:self action:@selector(actionItemMore:)];
    self.navigationItem.rightBarButtonItem = self.item;
    
    // 左返回
    UIBarButtonItem *imageBarButton = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"iconfont-fanhui(1)"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)] style:(UIBarButtonItemStylePlain) target:self action:@selector(actionImageBarButton:)];
    self.navigationItem.leftBarButtonItem = imageBarButton;
    
    // 右
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"iconfont-fenlei(1)"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:(UIBarButtonItemStyleDone) target:self action:@selector(actionItemMore:)];
    }

- (void)actionImageBarButton:(UIBarButtonItem *)imageBarButton
{
    [self.navigationController popViewControllerAnimated:YES];
}

// 截屏,分享, 收藏按钮方法
- (void)actionItemMore:(UIBarButtonItem *)item
{    
    self.isOpen = !self.isOpen;
    if (self.isOpen) {
        [UIView animateWithDuration:0.5 animations:^{
            self.imageView.frame = CGRectMake(self.view.frame.size.width - 110, -10, 100, 70);
            // 打开图片交互
            self.imageView.userInteractionEnabled = YES;
        }];
    } else {
        [UIView animateWithDuration:0.2 animations:^{
            self.imageView.frame = CGRectMake(self.view.frame.size.width - 100, -200, 100, 70);
        }];
    }
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [SVProgressHUD dismiss];
  
}

//
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [SVProgressHUD dismiss];
}
// 数据解析
- (void)setUpData
{ 
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // 拼接url
        NSString *DetailsUrl = [NSString stringWithFormat:@"%@%@%@", kDetailsUrl, self.videoId, kDetailsPlusUrl];
        NSURL *url = [NSURL URLWithString:DetailsUrl];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:(NSURLRequestUseProtocolCachePolicy) timeoutInterval:30.0];
        [request setHTTPMethod:@"GET"];
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration ephemeralSessionConfiguration];
        NSURLSession *session = [NSURLSession
                                 sessionWithConfiguration:config];
        NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (!data) {
                [SVProgressHUD showErrorWithStatus:@"加载失败"];
                return;
            }
            NSMutableDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSMutableArray *array = [dic valueForKey:@"resultData"];
            NSMutableDictionary *dataDic = array[0];
            NSMutableArray *videoArray = [dataDic valueForKey:@"videoContents"];
            self.dataArray = [NSMutableArray array];
            for (NSMutableDictionary *dic in videoArray) {
                HeadLineModel *model = [[HeadLineModel alloc] init];
                [model setValuesForKeysWithDictionary:dic];
                [self.dataArray addObject:model];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                // 回到主线程加载页面
                [self loadWebView];
                [SVProgressHUD dismiss];
            });
        }];
        [dataTask resume];
    });
    
}

// 分区数
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
// 分区行数
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
// 行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}
// cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:identifier];
    
    // 每个Cell上的内容.图标
    if (indexPath.row == 0) {
        cell.textLabel.text = @"收藏";
        cell.imageView.image = [UIImage imageNamed:@"collect.jpg"];
    }
    cell.textLabel.font = [UIFont systemFontOfSize:12];
    // 选中
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

// 选中操作
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self actionItemMore:self.item];
      if (indexPath.row == 0) {
          
          // 判断是否登录, 如果没有登录, 就跳转到登录界面
          AVUser *user = [AVUser currentUser];
          if (user == nil) {
              LoginViewController *logVC = [[LoginViewController alloc] init];
              UINavigationController *naVC = [[UINavigationController alloc] initWithRootViewController:logVC];
              naVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
              [self presentViewController:naVC animated:YES completion:nil];
          } else{
          
//判断是否收藏过了
          AVUser *user = [AVUser currentUser];
          AVRelation *relation = [user relationforKey:@"ChartObject"];
          NSArray *array =  [[relation query] findObjects:nil];
          for (ChartObject *object in array) {
              if ([self.videoName isEqualToString:[object valueForKey:@"videoName"]]) {
                  [self showAlterViewWithTitle:@"提示" Message:@"已收藏过了"];
                  return;
              }
          }
          
//没收藏就去收藏
          ChartObject *object = [[ChartObject alloc]init];
          object.videoId = self.videoId;
          object.videoName = self.videoName;
          [object saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
              if (succeeded) {
                  AVUser *user = [AVUser currentUser];
                  AVRelation *relation = [user relationforKey:@"ChartObject"];
                  [relation addObject:object];
                  [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                      if (succeeded) {
                          [self showAlterViewWithTitle:@"提示" Message:@"收藏成功"];
                      }
                  }];
              }
          }];
          }
    }
}

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


// 提示框消失
- (void) actionAlert
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)loadWebView
{
    [SVProgressHUD show];
    NSString *string = [self addString];
    [self.webView loadHTMLString:string baseURL:nil];
    self.webView.scrollView.bounces = NO;
    self.webView.delegate = self;
    [self.view addSubview:self.webView];
    [self addSubView];
}



//WebView 页面
- (void)addSubView

{
    // 更多框
    self.imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"moreKuang"]];
    self.imageView.frame = CGRectMake(self.view.frame.size.width - 100, -200, 100, 100);
    self.isOpen = NO;
    [self.view addSubview:self.imageView];
    // 截屏等
    self.moreTableView = [[UITableView alloc] initWithFrame:CGRectMake(5, 25, 90, 30) style:(UITableViewStylePlain)];
    self.moreTableView.delegate = self;
    self.moreTableView.dataSource = self;
    // 取消分割线
    self.moreTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.imageView addSubview:self.moreTableView];
}

// 把数据解析成html,方法WebView 上展示
- (NSString *)addString
{
    NSMutableString *urlString = [NSMutableString stringWithFormat:@"<TABLE height = 20 cellPadding = 4 width = %f align = center background =  border = 1 table> <TBODY> <TR> <TD> <p align = center> <FONT face = 隶书 size = 5>%@</TD></TR></TABLE>\n",kScreenWidth - 20*KW, self.videoName];
    for (HeadLineModel *model in self.dataArray) {
        NSString *string = [NSString stringWithFormat:@"<p style=\"text-align: center;\"><img src=\"%@\"  width=""%f"" style=\"\" title=\"1.gif\"/></p><p face = 楷书 size = 3>%@</p>", model.imageUrl, kScreenWidth - 20*KW,model.imageDesc];
        // 可变字符串拼接用appendString
        [urlString appendString:string];
    }
    [urlString appendString:@"<p align = right face = 楷书 size = 3>------素材来自网络</p>"];
    NSString *urlString1 = [NSString stringWithFormat:@"<div id=""foo"" style=""background:clear;"">%@</div>",urlString];
    return urlString1;
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