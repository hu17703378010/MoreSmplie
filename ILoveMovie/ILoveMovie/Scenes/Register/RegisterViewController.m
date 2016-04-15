//
//  RegisterViewController.m
//  DouBan1.0
//
//  Created by lanou3g on 15/9/9.
//  Copyright (c) 2015年 Reiko. All rights reserved.
//

#import "RegisterViewController.h"
#import "RegisterView.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0.8 green:0.247 blue:0.314 alpha:0.580]];
     self.view.backgroundColor = [UIColor whiteColor];
    [self addBarItem];
    self.registerView = [[RegisterView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:self.registerView];
    [self.registerView.registerButton addTarget:self action:@selector(actionRegisterButton:) forControlEvents:UIControlEventTouchUpInside];
   
}
// 设置bar
- (void)addBarItem
{
    self.navigationItem.title = @"注册";
    
    // UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithTitle:@"取消注册" style:UIBarButtonItemStylePlain target:self action:@selector(actionBarButton)];
    // self.navigationItem.rightBarButtonItem = rightBarButton;
    
    
    // 左返回
    UIBarButtonItem *imageBarButton = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"iconfont-fanhui(1)"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)] style:(UIBarButtonItemStylePlain) target:self action:@selector(actionBarButton)];
    self.navigationItem.leftBarButtonItem = imageBarButton;
}

// 设置bar的点击事件
- (void)actionBarButton
{
    [self dismissViewControllerAnimated:YES completion:nil];

}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:NO];
}


- (void)actionRegisterButton:(UIButton *)button
{
    
    
    // 如果用户名,密码,邮箱为空
    if ([self.registerView.userNameTextField.text isEqualToString:@""] || [self.registerView.passWordTextField1.text isEqualToString:@""] || [self.registerView.passWordTextField2.text isEqualToString:@""] || [self.registerView.mailTextField.text isEqualToString:@""]){
        [self showAlterViewWithTitle:@"提示" Message:@"用户名,密码,邮箱不能为空"];
        // 如果不为空的话
    } else {
        if (self.registerView.passWordTextField1.text.length < 6 || self.registerView.passWordTextField2.text.length < 6) {
            [self showAlterViewWithTitle:@"提示" Message:@"密码必须大于6位"];
            return;
        }
        // 判断两个密码是不是一样
        if (![self.registerView.passWordTextField1.text isEqualToString:self.registerView.passWordTextField2.text])
        {
            [self showAlterViewWithTitle:@"提示" Message:@"两次输入的密码不一样"];
            // 输入的正确
        } else {
           
      [self registerWithUserName:self.registerView.userNameTextField.text UserPassWord:self.registerView.passWordTextField1.text UserMail:self.registerView.mailTextField.text UserPhone:self.registerView.phoneNumTextField.text];
            
        

            }
        }
}

// 注册
- (void)registerWithUserName:(NSString *)name UserPassWord:(NSString *)passWord UserMail:(NSString *)mail UserPhone:(NSString *)phone
{
    AVUser *user = [AVUser user];
    user.username = name;
    user.password = passWord;
    user.email = mail;
    if (![phone isEqualToString:@""]) {
        user.mobilePhoneNumber = phone;
    }
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (error) {
            NSInteger codeNum = [[error.userInfo valueForKey:@"code"] integerValue];
            switch (codeNum) {
                case 203:
                    [self showAlterViewWithTitle:@"提示" Message:@"该邮箱已经被占用"];
                    break;
                case 125:
                    [self showAlterViewWithTitle:@"提示" Message:@"该邮箱格式不正确"];
                    break;
                case 127:
                    [self showAlterViewWithTitle:@"提示" Message:@"请输入正确的手机号码"];
                    break;
                case 202:
                    [self showAlterViewWithTitle:@"提示" Message:@"用户名已经被占用"];
                    break;
                case 211:
                    [self showAlterViewWithTitle:@"提示" Message:@"没有这个用户,请核对后登录"];
                    break;
                    //
                default:
                    break;
            }
                
            } else {
            [self showAlterViewWithTitle1:@"提示" Message:@"注册成功"];
        }
    }];
}

// 封装一个alertView
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
// 封装一个alertView1
- (void)showAlterViewWithTitle1:(NSString *)title Message:(NSString *)message
{
    
    UIAlertController *alertView = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [self performSelector:@selector(closeAlter1:) withObject:alertView afterDelay:1];
    
    [self presentViewController:alertView animated:YES completion:nil];
}
// 设置1秒之后消失1
- (void)closeAlter1:(UIAlertController *)alert
{
    [alert dismissViewControllerAnimated:YES completion:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
}
//

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}



@end
