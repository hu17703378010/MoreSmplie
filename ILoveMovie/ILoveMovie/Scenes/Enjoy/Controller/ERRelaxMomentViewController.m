//
//  ERRelaxMomentViewController.m
//  ILoveMovie
//
//  Created by lanou3g on 15/11/7.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import "ERRelaxMomentViewController.h"
#import "UIImage+CK_ShutScreen.h"  


// 分享
#import "AAShareBubbles.h"
#import "UMSocial.h"

#import "RelaxObject.h"

@interface ERRelaxMomentViewController ()<UIWebViewDelegate, UITableViewDelegate, UITableViewDataSource>
@property (nonatomic,retain) UIWebView *webView;
@property (nonatomic,assign)CGFloat height;
@property (nonatomic,retain)UIImageView *imageView;
@property (nonatomic,assign)BOOL isOpen;
@property (nonatomic,retain)UIBarButtonItem *item;
@property (nonatomic,retain)UIImage *capWebImage;
// 截屏 分享 收藏
@property (nonatomic, strong) UITableView *moreTableView;
@property (nonatomic,assign)int i;
@end


@implementation ERRelaxMomentViewController




- (instancetype)init
{
    self = [super init];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}


- (void)viewDidLoad {
    _i = 1;
    [super viewDidLoad];
    [SVProgressHUD show];
    self.view.backgroundColor = [UIColor whiteColor];
    //iconfont-10027   actionItem:
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"iconfont-fenlei(1)"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:(UIBarButtonItemStyleDone) target:self action:@selector(actionItemMore:)];
    
    // 左返回
    UIBarButtonItem *imageBarButton = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"iconfont-fanhui(1)"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)] style:(UIBarButtonItemStylePlain) target:self action:@selector(actionImageBarButton:)];
    self.navigationItem.leftBarButtonItem = imageBarButton;
     [SVProgressHUD show];
    // 内容以导航栏下方为起点
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-49)];
    [self addSubViews];
}
- (void)actionImageBarButton:(UIBarButtonItem *)imageBarButton
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark --- 更多框
- (void)addMoreButton
{
    // 更多框
    self.imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"moreKuang"]];
    self.imageView.frame = CGRectMake(self.view.frame.size.width - 110, -140, 100,140);
    self.isOpen = NO;
    [self.view addSubview:self.imageView];
    // 截屏等
    self.moreTableView = [[UITableView alloc] initWithFrame:CGRectMake(5, 25, 90, 110) style:(UITableViewStylePlain)];
    self.moreTableView.delegate = self;
    self.moreTableView.dataSource = self;
    // 取消分割线
    self.moreTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.imageView addSubview:self.moreTableView];
}

- (void)addSubViews
{
    
    NSString *str =[NSString stringWithFormat: @"<TABLE height = 50 cellPadding = 4 width = 360 align = center background =010101  border = 1 table> <TBODY> <TR> <TD> <p align = center> <FONT face = 隶书 size = 4>%@",self.model.Title];
    NSString *str2 = [NSString stringWithFormat:@"%@</TD></TR></TABLE>%@<p align = right>---素材来自网络</p>",str, self.model.Content];
    NSString *str1 = [str2 stringByReplacingOccurrencesOfString:@".jpg\"" withString:@".jpg\"  width=""350"""];
    str1 = [str1 stringByReplacingOccurrencesOfString:@".gif\"" withString:@".gif\"  width=""350"""];
//    str1 = [str1 stringByReplacingOccurrencesOfString:@"<embed" withString:@"<iframe"];
    //<embed
    str1 = [NSString stringWithFormat:@"<div id=""foo"" style=""background:clear;"">%@</div>",str1];
    [self.webView loadHTMLString:str1 baseURL:[NSURL URLWithString:@"http://apk.zdomo.com"]];
    self.webView.scrollView.bounces = NO;
    self.webView.delegate = self;
    self.webView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.webView];
    [SVProgressHUD show];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    if (_i == 1) {
        self.height = [[webView stringByEvaluatingJavaScriptFromString:@"document.getElementById(\"foo\").offsetHeight"] floatValue];
        [self reLoadWebView];
        _i++;
    }
    [SVProgressHUD dismiss];
}

- (void)reLoadWebView
{
    [SVProgressHUD show];
    self.webView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.height + 70);
    self.capWebImage = [UIImage captureWithView:self.webView];
    //[UIImage saveToPhotoAlbumWithImage:self.capWebImage];
    [self.webView removeFromSuperview];
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height+49)];
    [self addSubViews];
    // 更多框
    [self addMoreButton];
}

// 弹出更多框
- (void)actionItemMore:(UIBarButtonItem *)item
{
    self.isOpen = !self.isOpen;
    if (self.isOpen) {
        [UIView animateWithDuration:0.5 animations:^{
            self.imageView.frame = CGRectMake(self.view.frame.size.width - 110, -20, 100, 140);
            // 打开图片交互
            self.imageView.userInteractionEnabled = YES;
        }];
    } else {
        [UIView animateWithDuration:0.2 animations:^{
            self.imageView.frame = CGRectMake(self.view.frame.size.width - 110, -140, 100,140);
        }];
    }
}


// 分区数
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
// 分区行数
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
// 行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110/3.0;
}
// cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:identifier];
    
    // 每个Cell上的内容.图标
    if (indexPath.row == 0) {
        cell.textLabel.text = @"截屏";
        cell.imageView.image = [UIImage imageNamed:@"cut.jpg"];
    } else if (indexPath.row == 1) {
        cell.textLabel.text = @"分享";
        cell.imageView.image = [UIImage imageNamed:@"share.jpg"];
    } else {
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
        self.webView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.height + 70);
        [UIImage saveToPhotoAlbumWithImage:[UIImage captureWithView:self.webView]];
        [self.webView removeFromSuperview];
        self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height+49)];
        [self addSubViews];
        [self.view addSubview:self.imageView];
        // 截屏
        // 截屏成功提示框
        UIAlertController *cutAlert = [UIAlertController alertControllerWithTitle:@"截屏成功" message:nil preferredStyle:UIAlertControllerStyleAlert];
        // 随后消失
        [self performSelector:@selector(actionAlert) withObject:nil afterDelay:1.0];
        [self presentViewController:cutAlert animated:YES completion:nil];
        
    } else if (indexPath.row == 1) {

        // 判断是否登录, 如果没有登录, 就跳转到登录界面
        AVUser *user = [AVUser currentUser];
        if (user == nil) {
            LoginViewController *logVC = [[LoginViewController alloc] init];
            UINavigationController *naVC = [[UINavigationController alloc] initWithRootViewController:logVC];
            naVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
            [self presentViewController:naVC animated:YES completion:nil];
        } else{

        radius = 85;
        bubbleRadius = 32;
        _radiusSlider.value = radius;
        _bubbleRadiusSlider.value = bubbleRadius;
        
        _radiusLabel.text = [NSString stringWithFormat:@"%.0f", radius];
        _bubbleRadiusLabel.text = [NSString stringWithFormat:@"%.0f", bubbleRadius];
        if(shareBubbles) {
            shareBubbles = nil;
        }
        shareBubbles = [[AAShareBubbles alloc] initWithPoint:_shareButton.center radius:radius inView:self.view];
        shareBubbles.delegate = self;
        shareBubbles.bubbleRadius = bubbleRadius;
        shareBubbles.showFacebookBubble = YES;
        shareBubbles.showGooglePlusBubble = YES;
        shareBubbles.showTumblrBubble = YES;
        [shareBubbles show];
        
    }
    }else {
        AVUser *user = [AVUser currentUser];
        if (user == nil) {
            LoginViewController *logVC = [[LoginViewController alloc] init];
            UINavigationController *naVC = [[UINavigationController alloc] initWithRootViewController:logVC];
            naVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
            [self presentViewController:naVC animated:YES completion:nil];
        } else{


//        AVUser *user = [AVUser currentUser];
        AVRelation *relation = [user relationforKey:@"RelaxObject"];
        NSArray *array =  [[relation query] findObjects:nil];
        for (RelaxObject *object in array) {
            if ([self.model.Title isEqualToString:[object valueForKey:@"title"]]) {
                [self showAlterViewWithTitle:@"提示" Message:@"已收藏过了"];
                return;
            }
        }
        

        RelaxObject *object = [[RelaxObject alloc]init];
        object.PicURL = self.model.PicURL;
        object.Title = self.model.Title;
        object.Content = self.model.Content;
        [object saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                AVUser *user = [AVUser currentUser];
                AVRelation *relation = [user relationforKey:@"RelaxObject"];
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
// 提示框消失
- (void) actionAlert
{
    [self dismissViewControllerAnimated:YES completion:nil];
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

// 禁止屏幕旋转
- (BOOL)shouldAutorotate
{
    return NO;
}


// 分享
-(void)aaShareBubbles:(AAShareBubbles *)shareBubbles tappedBubbleWithType:(AAShareBubbleType)bubbleType
{
    switch (bubbleType) {
        case AAShareBubbleTypeFacebook:
        {
            // // 友盟分享到新浪微博
            [self sharesToWay:UMShareToSina];
            
            break;
        }
            
        case AAShareBubbleTypeGooglePlus:
        {
            // 友盟分享到豆瓣
            [self sharesToWay:UMShareToDouban];
            
            break;
        }
            
        case AAShareBubbleTypeTumblr:
        {
            // // 友盟分享到人人
            
            [self sharesToWay:UMShareToRenren];
            
            break;
        }
            
        default:
            break;
    }
}
- (void)sharesToWay: (NSString *)way
{
    // // 友盟分享到人人
    [UMSocialAccountManager isOauthAndTokenNotExpired:way];
    //进入授权页面
    [UMSocialSnsPlatformManager getSocialPlatformWithName:way].loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        if (response.responseCode == UMSResponseCodeSuccess) {
            //获取微博用户名、uid、token等
           // UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:way];
            NSString *string =  [self functionWithString:self.model.Content];
            UIImage *image = [self function2WithString:self.model.Content];
            string = [NSString stringWithFormat:@"%@ %@",self.model.Title, string];
            string = [string stringByReplacingOccurrencesOfString:@"(null)" withString:@""];
            [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[way] content:string image:image location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *shareResponse){
                if (shareResponse.responseCode == UMSResponseCodeSuccess) {
                    [self showAlterViewWithTitle:@"提示" Message:@"分享成功"];
                }
            }];
        }
    });
}


- (UIImage *)function2WithString:(NSString *)string
{
    if ([string containsString:@"iframe"]) {
        return nil;
    }
    NSString *str1 = [[string componentsSeparatedByString:@"<iframe src="] lastObject];
    str1 = [[str1 componentsSeparatedByString:@"frameborder"] firstObject];
    str1 = [str1 stringByReplacingOccurrencesOfString:@"\"" withString:@""];
    return self.capWebImage;
}

- (NSString *)functionWithString:(NSString *)string
{
    if (![string containsString:@"iframe"]) {
        return nil;
    }
    NSString *str1 = [[string componentsSeparatedByString:@"<iframe src="] lastObject];
    str1 = [[str1 componentsSeparatedByString:@"frameborder"] firstObject];
    str1 = [str1 stringByReplacingOccurrencesOfString:@"\"" withString:@""];
    
    if ([str1 containsString:@"http"]) {
        return str1;
    }
    return nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end