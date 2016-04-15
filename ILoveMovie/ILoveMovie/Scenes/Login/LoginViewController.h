//
//  LoginViewController.h
//  DouBan1.0
//
//  Created by lanou3g on 15/9/9.
//  Copyright (c) 2015年 Reiko. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LoginView;
@protocol LoginViewControllerDelegate <NSObject>

- (void)changeMineVC;

@end
typedef void(^LoginSuccessBlock)(void);

@interface LoginViewController : UIViewController
@property (nonatomic,assign)id<LoginViewControllerDelegate> delegate;
@property (nonatomic, retain)LoginView *loginView;
@property (nonatomic, copy) LoginSuccessBlock successBlock;//登陆成功后回调

@end

