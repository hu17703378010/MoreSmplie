//
//  ERCommentViewController.m
//  ILoveMovie
//
//  Created by lanou3g on 15/10/29.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import "ERCommentViewController.h"
#import "UIImage+CK_ShutScreen.h"
#define kLogoUrl @"http://chuantu.biz/t2/17/1446108917x-1376440153.png"


@interface ERCommentViewController ()<UIWebViewDelegate>
@property (nonatomic,retain) UIWebView *webView;
@property (nonatomic,assign)CGFloat height;
@property (nonatomic,retain)UIImageView *imageView;
@property (nonatomic,assign)BOOL isOpen;
@end

@implementation ERCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor]; //iconfont-10027   actionItem:
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"iconfont-10027"] style:(UIBarButtonItemStyleDone) target:self action:@selector(actionItemMore:)];
    self.navigationItem.rightBarButtonItem = item;
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height + 49)];
    [self addSubViews];
    
    // 更多框
    self.imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"moreKuang"]];
     self.imageView.frame = CGRectMake(self.view.frame.size.width - 100, 44, 100, 0);
    self.isOpen = NO;
    
    [self.view addSubview:self.imageView];
}

- (void)addSubViews
{
    NSString *str =[NSString stringWithFormat: @"<TABLE height = 50 cellPadding = 4 width = 360 align = center background =  border = 1 table> <TBODY> <TR> <TD> <p align = center> <FONT face = 隶书 size = 5>%@",self.model.Title];
    NSString *str2 = [NSString stringWithFormat:@"%@</TD></TR></TABLE>%@<p align = right>---素材来自网络</p>",str, self.model.Content];
    NSString *str1 = [str2 stringByReplacingOccurrencesOfString:@".jpg\"" withString:@".jpg\"  width=""350"""];
    str1 = [NSString stringWithFormat:@"<div id=""foo"" style=""background:clear;"">%@</div>",str1];
    [self.webView loadHTMLString:str1 baseURL:[NSURL URLWithString:@"http://apk.zdomo.com"]];
    self.webView.scrollView.bounces = NO;
    self.webView.delegate = self;
    self.webView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.webView];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.height = [[webView stringByEvaluatingJavaScriptFromString:@"document.getElementById(\"foo\").offsetHeight"] floatValue];
}
- (void)actionItemMore:(UIBarButtonItem *)item
{
    self.isOpen = !self.isOpen;
    if (self.isOpen) {
        [UIView animateWithDuration:0.5 animations:^{
            self.imageView.frame = CGRectMake(self.view.frame.size.width - 100, 44, 100, 140);
        }];
    } else {
        [UIView animateWithDuration:0.2 animations:^{
            self.imageView.frame = CGRectMake(self.view.frame.size.width - 100, 44, 100, 0);
        }];
    }
    
}

- (void)actionItem:(UIBarButtonItem *)item
{
    NSLog(@"%f",self.height);
    self.webView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.height + 70);
    [UIImage saveToPhotoAlbumWithImage:[UIImage captureWithView:self.webView]];
    [self.webView removeFromSuperview];
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64)];
    [self addSubViews];
}
- (void) transitionWithType:(NSString *) type WithSubtype:(NSString *) subtype ForView : (UIView *) view
{
    //创建CATransition对象
    CATransition *animation = [CATransition animation];
    //设置运动时间
    animation.duration = 0.7f;
    //设置运动type
    animation.type = type; //CameraIrisHollowClose
    if (subtype != nil) {
        //设置子类
        animation.subtype = subtype;
    }
    //设置运动速度
    animation.timingFunction = UIViewAnimationOptionCurveEaseInOut;
    [view.layer addAnimation:animation forKey:@"animation"];
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
