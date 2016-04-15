//
//  LoginViewController.m
//  DouBan1.0
//
//  Created by lanou3g on 15/9/9.
//  Copyright (c) 2015年 Reiko. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginView.h"
#import "RegisterViewController.h"

#import <AVOSCloud.h>

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0.8 green:0.247 blue:0.314 alpha:0.580]];
    [self addBarItem];
    self.view.backgroundColor = [UIColor whiteColor];
    self.loginView = [[LoginView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    // 登录按钮
    [self.loginView.loginButton addTarget:self action:@selector(actionLoginButton:) forControlEvents:UIControlEventTouchUpInside];
    // 注册按钮
    [self.loginView.registerButton addTarget:self action:@selector(actionRegisterButton:) forControlEvents:UIControlEventTouchUpInside];
    
    // 找回密码按钮
    [self.loginView.findPasswordButton addTarget:self action:@selector(actionResetPasswordButton:) forControlEvents:(UIControlEventTouchUpInside)];
    
    [self.view addSubview:self.loginView];
    
    
}


// 注册按钮的点击事件
- (void)actionRegisterButton:(UIButton *)registerButton
{
     RegisterViewController *registerVC = [[RegisterViewController alloc] init];
     [self.navigationController pushViewController:registerVC animated:YES];
    
}
// 登陆按钮的点击事件
- (void)actionLoginButton:(UIButton *)loginButton
{

  [AVUser logInWithUsernameInBackground:self.loginView.userNameTextField.text password:self.loginView.passWordTextField.text block:^(AVUser *user, NSError *error) {
      if (error) {
          NSInteger codeNum = [[error.userInfo valueForKey:@"code"] integerValue];
          if (codeNum == 210){
              [self showAlterViewWithTitle:@"提示" Message:@"用户名和密码错误"];
          } else if (codeNum == 211){
              [self showAlterViewWithTitle:@"提示" Message:@"用户名和密码不存在"];
          }
    
      } else {
          if (_delegate&&[_delegate respondsToSelector:@selector(changeMineVC)]) {
              [self.delegate changeMineVC];
          }
          [self dismissViewControllerAnimated:YES completion:nil];
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

#pragma mark -- 找回密码
- (void)actionResetPasswordButton:(UIButton *)reset
{
    // 自定义提示框输入注册邮箱地址
    UIAlertController * resetAlertC = [UIAlertController alertControllerWithTitle:@"请输入注册邮箱地址:" message:@"输入邮箱地址" preferredStyle:(UIAlertControllerStyleAlert)];
    // 用户输入邮箱文本框
    [resetAlertC addTextFieldWithConfigurationHandler:^(UITextField * textField) {
        textField.placeholder = @"请输入邮箱地址";
        textField.textColor = [UIColor redColor];
        textField.alpha = 1;
    }];
    // 添加确定按钮
    UIAlertAction * doneAction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
        
        // 修改密码
        [AVUser requestPasswordResetForEmailInBackground:resetAlertC.textFields.firstObject.text block:^(BOOL succeeded, NSError *error) {
            
            if (succeeded) {
                // 提醒用户去邮箱更改密码
                UIAlertController * alertC = [UIAlertController alertControllerWithTitle:@"提示" message:@"请登录您的邮箱,进行更改密码.欢迎再次回来哦." preferredStyle:(UIAlertControllerStyleAlert)];
                UIAlertAction * doneAction = [UIAlertAction actionWithTitle:@"好说" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * action) {
                }];
                [alertC addAction:doneAction];
                [self presentViewController:alertC animated:YES completion:nil];
            } else {
                // 发送失败 提醒用户输入正确的邮箱地址
                UIAlertController * alertC = [UIAlertController alertControllerWithTitle:@"提示" message:@"发送失败,请填写正确的邮箱地址." preferredStyle:(UIAlertControllerStyleAlert)];
                UIAlertAction * alertAction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:nil];
                [alertC addAction:alertAction];
                [self presentViewController:alertC animated:YES completion:nil];
            }
        }];
    }];
    [resetAlertC addAction:doneAction];
    // 将通知添加到屏幕上
    [self presentViewController:resetAlertC animated:YES completion:nil];
    UIAlertAction *actions1 = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        [resetAlertC dismissViewControllerAnimated:YES completion:nil];
    }];
    [resetAlertC addAction:actions1];

}

// 设置bar
- (void)addBarItem
{
    // 左返回
    UIBarButtonItem *imageBarButton = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"iconfont-fanhui(1)"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)] style:(UIBarButtonItemStylePlain) target:self action:@selector(actionImageBarButton:)];
    self.navigationItem.leftBarButtonItem = imageBarButton;
}

- (void)actionImageBarButton:(UIBarButtonItem *)imageBarButton
{
    [self dismissViewControllerAnimated:YES completion:nil];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:NO];
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
