//
//  RegisterTextField.m
//  DouBan1.0
//
//  Created by lanou3g on 15/9/9.
//  Copyright (c) 2015年 Reiko. All rights reserved.
//

#import "RegisterView.h"
#define KW kScreenWidth/375
#define KH kScreenHeight/667
@implementation RegisterView



- (instancetype) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubViews];
    }
    return self;
    
    
    // 左返回
    // UIBarButtonItem *imageBarButton = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"iconfont-fanhui(1)"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)] style:(UIBarButtonItemStylePlain) target:self action:@selector(actionImageBarButton:)];
    // self.navigationItem.leftBarButtonItem = imageBarButton;
}
- (void)actionImageBarButton:(UIBarButtonItem *)imageBarButton
{
    // [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)addSubViews
{
    
    UIImageView *bgPhoto = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    bgPhoto.image = [UIImage imageNamed:@"loginbg"];
    [self addSubview:bgPhoto];
    
    UIVisualEffectView *visulaView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight]];
    visulaView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    visulaView.alpha = 0.1;
    [self addSubview:visulaView];
    
    self.userNameTextField = [[UITextField alloc] initWithFrame:CGRectMake((kScreenWidth- 300*KW)/2, 120*KH, 300*KW, 30*KH)];
    self.userNameTextField.placeholder = @"请输入用户名";
    [self addSubview:self.userNameTextField];
    
    self.passWordTextField1 = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.userNameTextField.frame), CGRectGetMaxY(self.userNameTextField.frame)+15*KH, CGRectGetWidth(self.userNameTextField.frame), CGRectGetHeight(self.userNameTextField.frame))];
    self.passWordTextField1.placeholder = @"请输入密码";
    [self addSubview:self.passWordTextField1];

    self.passWordTextField2 = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.userNameTextField.frame), CGRectGetMaxY(self.passWordTextField1.frame)+15*KH, CGRectGetWidth(self.userNameTextField.frame), CGRectGetHeight(self.userNameTextField.frame))];
    self.passWordTextField2.placeholder = @"请再次输入密码";
    [self addSubview:self.passWordTextField2];
    
    self.mailTextField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.userNameTextField.frame), CGRectGetMaxY(self.passWordTextField2.frame)+15*KH, CGRectGetWidth(self.userNameTextField.frame), CGRectGetHeight(self.userNameTextField.frame))];
    self.mailTextField.placeholder = @"请输入邮箱";
    [self addSubview:self.mailTextField];
    
//    self.phoneNumTextField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.userNameTextField.frame), CGRectGetMaxY(self.mailTextField.frame)+15*KH, CGRectGetWidth(self.userNameTextField.frame), CGRectGetHeight(self.userNameTextField.frame))];
//    self.phoneNumTextField.placeholder = @"请输入电话号码";
//    [self addSubview:self.phoneNumTextField];
    [self addSupport];
}



- (void)addSupport{
    
    
    UIImageView *userLeft = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 25*KW, 25*KW)];
    userLeft.image = [UIImage imageNamed:@"login-user"];
    self.userNameTextField.leftView = userLeft;
    self.userNameTextField.leftViewMode = UITextFieldViewModeAlways;
    UILabel *userLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.userNameTextField.frame), CGRectGetMaxY(self.userNameTextField.frame), CGRectGetWidth(self.userNameTextField.frame), 1*KH)];
    userLabel.backgroundColor = kFindListCellLabelTextColor;
    [self addSubview:userLabel];
    
    
    UIImageView *passwordLeft_1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 25*KW, 25*KW)];
    passwordLeft_1.image = [UIImage imageNamed:@"login-password"];
    self.passWordTextField1.leftView = passwordLeft_1;
    self.passWordTextField1.secureTextEntry = YES;
    self.passWordTextField1.leftViewMode = UITextFieldViewModeAlways;
    UILabel *passwordLabel_1 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.passWordTextField1.frame), CGRectGetMaxY(self.passWordTextField1.frame), CGRectGetWidth(self.passWordTextField1.frame), 1*KH)];
    passwordLabel_1.backgroundColor = kFindListCellLabelTextColor;
    [self addSubview:passwordLabel_1];
    
    UIImageView *passwordLeft_2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 25*KW, 25*KW)];
    passwordLeft_2.image = [UIImage imageNamed:@"login-password"];
    self.passWordTextField2.leftView = passwordLeft_2;
    self.passWordTextField2.secureTextEntry = YES;
    self.passWordTextField2.leftViewMode = UITextFieldViewModeAlways;
    UILabel *passwordLabel_2 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.passWordTextField2.frame), CGRectGetMaxY(self.passWordTextField2.frame), CGRectGetWidth(self.passWordTextField2.frame), 1*KH)];
    passwordLabel_2.backgroundColor = kFindListCellLabelTextColor;
    [self addSubview:passwordLabel_2];
    
    UIImageView *emailLeft = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 25*KW, 25*KW)];
    emailLeft.image = [UIImage imageNamed:@"login-mail"];
    self.mailTextField.leftView = emailLeft;
    self.mailTextField.leftViewMode = UITextFieldViewModeAlways;
    UILabel *emailLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.mailTextField.frame), CGRectGetMaxY(self.mailTextField.frame), CGRectGetWidth(self.mailTextField.frame), 1*KH)];
    emailLabel.backgroundColor = kFindListCellLabelTextColor;
    [self addSubview:emailLabel];
    
//    UIImageView *phoneLeft = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 25*KW, 25*KW)];
//    phoneLeft.image = [UIImage imageNamed:@"login-phone"];
//    self.phoneNumTextField.leftView = phoneLeft;
//    self.phoneNumTextField.leftViewMode = UITextFieldViewModeAlways;
//    UILabel *phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.phoneNumTextField.frame), CGRectGetMaxY(self.phoneNumTextField.frame), CGRectGetWidth(self.phoneNumTextField.frame), 1*KH)];
//    phoneLabel.backgroundColor = kFindListCellLabelTextColor;
//    [self addSubview:phoneLabel];
    
    // 按钮
    self.registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.registerButton.frame = CGRectMake((kScreenWidth - 300*KW) / 2, self.mailTextField.bottom + 20*KH, 300*KW, 40*KH);
    [self.registerButton setTitle:@"确认注册" forState:UIControlStateNormal];
    [self.registerButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.registerButton.titleLabel.font = [UIFont fontWithName:@"MarkerFelt-Thin" size:33*KW];
    self.registerButton.layer.cornerRadius = self.registerButton.frame.size.height/2;
    self.registerButton.backgroundColor = kFindListCellLabelTextColor;
    [self addSubview:self.registerButton];
    

    
}






@end
