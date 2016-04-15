//
//  LoginView.m
//  DouBan1.0
//
//  Created by lanou3g on 15/9/9.
//  Copyright (c) 2015年 Reiko. All rights reserved.
//

#import "LoginView.h"
#define KW kScreenWidth/375
#define KH kScreenHeight/667

@implementation LoginView



- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubViews];
        
    }
    
    return self;
}


- (void)addSubViews{
    

    UIImageView *bgPhoto = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    bgPhoto.image = [UIImage imageNamed:@"loginbg"];
    [self addSubview:bgPhoto];
    
    UIVisualEffectView *visulaView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
    visulaView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    visulaView.alpha = 0.3;
    [self addSubview:visulaView];
    
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(20*KW, 100*KH, kScreenWidth - 20*KW * 2, kScreenHeight - 100*KH * 2)];
   // view.backgroundColor = [UIColor greenColor];
    view.alpha = 0.3;
    view.layer.shadowColor = [UIColor blueColor].CGColor;
    view.layer.shadowOffset = CGSizeMake(10, 10);
    view.layer.shadowRadius = 50;

    [self addSubview:view];
    
    //  字体
    UIImageView *logoImage = [[UIImageView alloc] initWithFrame:CGRectMake((kScreenWidth - 100*KW) / 2, 0, 100*KW, 80*KH)];
    logoImage.image = [UIImage imageNamed:@"start_logo"];
    [self addSubview:logoImage];
    
    UIImageView *userName = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 25*KW, 25*KW)];
    userName.image = [UIImage imageNamed:@"login-user"];
    self.userNameTextField = [[UITextField alloc] initWithFrame:CGRectMake((kScreenWidth - 300*KW) / 2, logoImage.bottom + 50*KH, 300*KW, 30*KH)];
    self.userNameTextField.leftView = userName;
    self.userNameTextField.leftViewMode = UITextFieldViewModeAlways;
    self.userNameTextField.borderStyle = UITextBorderStyleNone;
    self.userNameTextField.placeholder = @"请输入用户名";
    [self addSubview:self.userNameTextField];
  

    for (int i = 0; i < 2; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(self.userNameTextField.left , self.userNameTextField.bottom + (i * 80*KH), self.userNameTextField.width, 1)];
        label.backgroundColor = [UIColor colorWithRed:0.8 green:0.247 blue:0.314 alpha:0.580];
        [self addSubview:label];
    }

    
    UIImageView *passWd = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 25*KW, 25*KH)];
    passWd.image = [UIImage imageNamed:@"login-password"];
    self.passWordTextField = [[UITextField alloc] initWithFrame:CGRectMake((kScreenWidth - 300*KW) / 2, self.userNameTextField.bottom + 50*KH, 300*KW, 30*KH)];
    self.passWordTextField.leftView = passWd;
    self.passWordTextField.secureTextEntry = YES;
    self.passWordTextField.leftViewMode = UITextFieldViewModeAlways;
    self.passWordTextField.borderStyle = UITextBorderStyleNone;
    self.passWordTextField.placeholder = @"请输入密码";
    self.passWordTextField.secureTextEntry = YES;
    [self addSubview:self.passWordTextField];
  

    // 按钮
    self.loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.loginButton.frame = CGRectMake((kScreenWidth - 300*KW) / 2, self.passWordTextField.bottom + 20*KH, 300*KW, 40*KH);
    [self.loginButton setTitle:@"登 陆" forState:UIControlStateNormal];
    [self.loginButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.loginButton.titleLabel.font = [UIFont fontWithName:@"MarkerFelt-Thin" size:33*KW];
    self.loginButton.layer.cornerRadius = self.loginButton.frame.size.height/2;
    self.loginButton.backgroundColor = kFindListCellLabelTextColor;
    [self addSubview:self.loginButton];
    
    
    self.findPasswordButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.findPasswordButton.frame = CGRectMake(CGRectGetMinX(self.loginButton.frame), CGRectGetMaxY(self.loginButton.frame)+20*KH, 120*KW, 30*KH);
    [self.findPasswordButton setTitle:@"找回密码?" forState:UIControlStateNormal];
    [self.findPasswordButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.findPasswordButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-BoldOblique" size:15*KW];
    self.findPasswordButton.layer.cornerRadius = self.findPasswordButton.frame.size.height/2-5;
    self.findPasswordButton.backgroundColor = kFindListCellLabelTextColor;
    [self addSubview:self.findPasswordButton];
    
    
    self.registerButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.registerButton.frame = CGRectMake(CGRectGetMaxX(self.loginButton.frame)-120*KW, CGRectGetMaxY(self.loginButton.frame)+20*KH, 120*KW, 30*KH);
    [self.registerButton setTitle:@"注册" forState:UIControlStateNormal];
    [self.registerButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.registerButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-BoldOblique" size:15*KW];
    self.registerButton.backgroundColor = kFindListCellLabelTextColor;
    self.registerButton.layer.cornerRadius = self.registerButton.frame.size.height/2-5;
    [self addSubview:self.registerButton];
}

@end
