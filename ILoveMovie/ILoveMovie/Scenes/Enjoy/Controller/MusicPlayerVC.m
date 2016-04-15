//
//  MusicPlayerVC.m
//  ILoveMovie
//
//  Created by lanou3g on 15/10/30.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import "MusicPlayerVC.h"
// 分享
#import "AAShareBubbles.h"
#import "UMSocial.h"
#import "MusicObject.h"
@interface MusicPlayerVC ()<UIWebViewDelegate, UITableViewDataSource, UITableViewDelegate>
@property (nonatomic,assign)CGFloat height;
@property (nonatomic,retain)UIImageView *imageView;
@property (nonatomic,assign)BOOL isOpen;
@property (nonatomic,retain)UIBarButtonItem *item;
@property (nonatomic,retain)UIWebView *webView;

// 截屏 分享 收藏
@property (nonatomic, strong) UITableView *moreTableView;
@end



@implementation MusicPlayerVC

- (void)viewWillDisappear:(BOOL)animated
{
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@""]]];
    [SVProgressHUD dismiss];
}




- (void) viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 左返回
    UIBarButtonItem *imageBarButton = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"iconfont-fanhui(1)"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)] style:(UIBarButtonItemStylePlain) target:self action:@selector(actionImageBarButton:)];
    self.navigationItem.leftBarButtonItem = imageBarButton;
    
    self.item = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"iconfont-fenlei(1)"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:(UIBarButtonItemStyleDone) target:self action:@selector(actionItemMore:)];
    self.navigationItem.rightBarButtonItem = self.item;
    [self addViews];
    [self addMoreButton];
}


- (void)actionImageBarButton:(UIBarButtonItem *)imageBarButton
{
    [self.navigationController popViewControllerAnimated:YES];
}



#pragma mark --- 网页加载
- (void)addViews
{
    NSLog(@"self.view.frame.size.height = %f",self.view.frame.size.height);
    if ([self.flag isEqualToString:@"SHOUCANG"]) {
       self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, -80*KH, self.view.frame.size.width, self.view.frame.size.height+140*KH)];
    } else if([self.flag isEqualToString:@"YUANSHENG"]){
        self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, -80*KH, self.view.frame.size.width, self.view.frame.size.height+180*KH)];
    }
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString]]];
    [self.view addSubview:self.webView];
    self.webView.scrollView.bounces = NO;
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 250*KH)];
    [self.webView addSubview:view1];
    view1.backgroundColor = [UIColor clearColor];
    self.webView.delegate = self;
}


#pragma mark --- 更多框
- (void)addMoreButton
{
    // 更多框
    self.imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"moreKuang"]];
    self.imageView.frame = CGRectMake(self.view.frame.size.width - 110*KW, -140*KH, 100*KW,130*KH);
    self.isOpen = NO;
    [self.view addSubview:self.imageView];
    // 截屏等
    self.moreTableView = [[UITableView alloc] initWithFrame:CGRectMake(5*KW, 25*KH, 90*KW, 60*KH) style:(UITableViewStylePlain)];
    self.moreTableView.delegate = self;
    self.moreTableView.dataSource = self;
    // 取消分割线
    self.moreTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.imageView addSubview:self.moreTableView];
}

// 弹出更多框
- (void)actionItemMore:(UIBarButtonItem *)item
{
    self.isOpen = !self.isOpen;
    if (self.isOpen) {
        [UIView animateWithDuration:0.5 animations:^{
            self.imageView.frame = CGRectMake(self.view.frame.size.width - 110*KW, 51*KH, 100*KW, 100*KH);
            // 打开图片交互
            self.imageView.userInteractionEnabled = YES;
        }];
    } else {
        [UIView animateWithDuration:0.2 animations:^{
            self.imageView.frame = CGRectMake(self.view.frame.size.width - 110*KW, -140*KH, 100*KW,100*KH);
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
    return 2;
}
// 行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60/2.0;
}
// cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:identifier];
    
    // 每个Cell上的内容.图标
     if (indexPath.row == 0) {
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self actionItemMore:self.item];
    if (indexPath.row == 0) {
        // 分享
        AVUser *user = [AVUser currentUser];
        if (user == nil) {
            LoginViewController *logVC = [[LoginViewController alloc] init];
            UINavigationController *naVC = [[UINavigationController alloc] initWithRootViewController:logVC];
            naVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
            [self presentViewController:naVC animated:YES completion:nil];
            return;
        }
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
    } else if (indexPath.row == 1) {
        // 收藏
        AVUser *user = [AVUser currentUser];
        if (user == nil) {
            LoginViewController *logVC = [[LoginViewController alloc] init];
            UINavigationController *naVC = [[UINavigationController alloc] initWithRootViewController:logVC];
            naVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
            [self presentViewController:naVC animated:YES completion:nil];
            return;
        }

        AVRelation *relation = [user relationforKey:@"MusicObject"];
        NSArray *array =  [[relation query] findObjects:nil];
        for (MusicObject *object in array) {
            if ([self.musicName isEqualToString:[object valueForKey:@"musicName"]]) {
                [self showAlterViewWithTitle:@"提示" Message:@"已收藏过了"];
                return;
            }
        }
        
        

        MusicObject *object = [[MusicObject alloc]init];
        object.urlString = self.urlString;
        object.musicName = self.musicName;
        [object saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                AVUser *user = [AVUser currentUser];
                AVRelation *relation = [user relationforKey:@"MusicObject"];
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


- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [SVProgressHUD show];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [SVProgressHUD dismiss];
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
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:way];
            //进入你的分享内容编辑页面
            UMSocialUrlResource *resouse = [[UMSocialUrlResource alloc]init];
            resouse.url = self.urlString;
            [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[way] content:[NSString stringWithFormat:@"%@:%@",self.musicName,self.urlString] image:nil location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *shareResponse){
                if (shareResponse.responseCode == UMSResponseCodeSuccess) {
                    [self showAlterViewWithTitle:@"提示" Message:@"分享成功"];
                }
            }];
        }
    });
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
