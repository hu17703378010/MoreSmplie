//
//  TopThirdViewController.m
//  ILoveMovie
//
//  Created by lanou3g on 15/10/31.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import "TopThirdViewController.h"
#import "HeadLineModel.h"
#define kTopThirdUrl @"http://sfzdy.yingyongjingling.com:20610/video/download?videoNos=[1]&versionName=1.1.0&phoneNumber=&userToken=&videoDefinition=480P&videoId="
#define kTopThUrl @"&clientType=IPHONE"

@interface TopThirdViewController ()
@property (nonatomic, strong)NSMutableArray *dataArray;
@end

@implementation TopThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self setUpData];
}

- (void)viewWillAppear:(BOOL)animated
{
    // 视图将要显示隐藏tabBar
    [self.tabBarController.tabBar setHidden:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)setUpData
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // 拼接url
        NSString *DetailsUrl = [NSString stringWithFormat:@"%@%@%@", kTopThirdUrl, self.videoId, kTopThUrl];
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
                [self addSubView];
            });
        }];
        [dataTask resume];
    });
}


// WebView页面
- (void)addSubView
{
    UIWebView *detalisView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 70)];
    // [self addString] 返回的NSMutableString类型的参数
    NSMutableString *string = [self addString];
    
    [detalisView loadHTMLString:string baseURL:nil];
    // 不回弹
    detalisView.scrollView.bounces = NO;
    [self.view addSubview:detalisView];
}

// 解析html数据
- (NSMutableString *)addString
{
    NSMutableString *urlString = [NSMutableString stringWithFormat:@"<TABLE height = 20 cellPadding = 4 width = 360 align = center background =  border = 1 table> <TBODY> <TR> <TD> <p align = center> <FONT face = 隶书 size = 5>%@</TD></TR></TABLE>\n",self.videoName];
    // 便利数组装进model, 把url拼成html语言的网址,直接解析网址
    for (HeadLineModel *model in self.dataArray) {
        NSString *string = [NSString stringWithFormat:@"<p style=\"text-align: center;\"><img src=\"%@\"  width=""360"" style=\"\" title=\"1.gif\"/></p><p face = 楷书 size = 3>%@</p>", model.imageUrl, model.imageDesc];
        [urlString appendString:string];
    }
    [urlString appendString:@"<p align = right face = 楷书 size = 3>------素材来自网络</p>"];
    return urlString;
}


@end
