//
//  HotDetaliViewController.m
//  ILoveMovie
//
//  Created by lanou3g on 15/10/30.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import "HotDetaliViewController.h"
#import "HeadLineModel.h"
#define kDetailsUrl @"http://sfzdy.yingyongjingling.com:20610/video/download?videoNos=[1]&versionName=1.1.0&phoneNumber=&userToken=&videoDefinition=480P&videoId="
#define kDetailsPlusUrl   @"&clientType=IPHONE"

@interface HotDetaliViewController ()
@property (nonatomic,retain)NSMutableArray *dataArray;
@end

@implementation HotDetaliViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpData];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewWillDisappear:(BOOL)animated
{
    // 显示tabBar
    [self.tabBarController.tabBar setHidden:NO];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.tabBarController.tabBar setHidden:YES];
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
                [self addViews];
            });
        }];
        [dataTask resume];
    });
    
}


- (void)addViews
{
    UIWebView *view = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height+49)];
    NSMutableString *string = [self addString];
    [view loadHTMLString:string baseURL:nil];
    view.scrollView.bounces = NO;
    [self.view addSubview:view];
}

/*
 <p>你可能已经听说过这部“神剧”了……没错！它就是被无数网友戏称为见证日剧历史的百合&基佬剧集《伪装夫妇》！</p><p style=\"text-align: center;\"><img src=\"http://sfzdy.yingyongjingling.com:20620/videos/7370/480P/1/gm_3.jpg\" style=\"\" title=\"1.gif\"/></p>
 */

- (NSMutableString *)addString
{
    NSMutableString *URLtring = [NSMutableString stringWithFormat:@"<TABLE height = 20 cellPadding = 4 width = 360 align = center background =  border = 1 table> <TBODY> <TR> <TD> <p align = center> <FONT face = 隶书 size = 5>%@</TD></TR></TABLE>\n",self.videoName];
    for (HeadLineModel *model in self.dataArray) {
        NSString *string = [NSString stringWithFormat:@"<p style=\"text-align: center;\"><img src=\"%@\"  width=""360"" style=\"\" title=\"1.gif\"/></p><p face = 楷书 size = 3>%@</p>", model.imageUrl,model.imageDesc];
        // 可变字符串拼接用appendString
        [URLtring appendString:string];
    }
    [URLtring appendString:@"<p align = right face = 楷书 size = 3>------素材来自网络</p>"];
    return URLtring;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
