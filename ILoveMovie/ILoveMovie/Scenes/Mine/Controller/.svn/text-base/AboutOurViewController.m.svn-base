//
//  AboutOurViewController.m
//  ILoveMovie
//
//  Created by lanou3g on 15/11/2.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import "AboutOurViewController.h"
#import "AnnounceViewController.h"  // 版本声明
#import "OpinionsObject.h"

@interface AboutOurViewController ()

@end

@implementation AboutOurViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
   [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    // 左返回
    UIBarButtonItem *imageBarButton = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"iconfont-fanhui(1)"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)] style:(UIBarButtonItemStylePlain) target:self action:@selector(actionImageBarButton:)];
    self.navigationItem.leftBarButtonItem = imageBarButton;
}

- (void)actionImageBarButton:(UIBarButtonItem *)imageBarButton
{
    [self.navigationController popViewControllerAnimated:YES];
}

// 意见反馈
- (IBAction)ActionShareUs:(UIButton *)sender {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"意见反馈 " message:@"您的支持是我们最大的动力" preferredStyle:(UIAlertControllerStyleAlert)];
    __block UIAlertController *alert = alertController;
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        UIAlertAction *actions = [UIAlertAction actionWithTitle:@"提交" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            if ([textField.text isEqual: @""]) {
                [self showAlterViewWithTitle:@"提示" Message:@"文本为空."];
                return;
            }
            OpinionsObject *object = [[OpinionsObject alloc]init];
            object.opinions = textField.text;
            [object saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (succeeded) {
                    AVUser *user = [AVUser currentUser];
                    if (user) {
                        AVRelation *relation = [user relationforKey:@"OpinionsObject"];
                        [relation addObject:object];
                        [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                            if (succeeded) {
                                [self showAlterViewWithTitle:@"提示" Message:@"提交成功,感谢您的反馈."];
                            } else {
                                [self showAlterViewWithTitle:@"提示" Message:@"未知原因,提交失败."];
                            }
                        }];
                    } else {
                        [self showAlterViewWithTitle:@"提示" Message:@"提交成功,感谢您的匿名反馈."];
                    }
                   
                   
                }
            }];
        }];
        [alert addAction:actions];
        UIAlertAction *actions1 = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
            [alert dismissViewControllerAnimated:YES completion:nil];
        }];
        [alert addAction:actions1];
 
    }];
    
    [self presentViewController:alertController animated:YES completion:nil];
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
// 版本声明
- (IBAction)ActionAnnounce:(UIButton *)sender {
    
    AnnounceViewController *announceVC = [[AnnounceViewController alloc] init];
    UINavigationController *naVC = [[UINavigationController alloc] initWithRootViewController:announceVC];
    // 模态跳转动画
    announceVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    // 跳转过去
    [self presentViewController:naVC animated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
