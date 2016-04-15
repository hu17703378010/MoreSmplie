//
//  RegisterViewController.h
//  DouBan1.0
//
//  Created by lanou3g on 15/9/9.
//  Copyright (c) 2015年 Reiko. All rights reserved.
//

#import <UIKit/UIKit.h>
@class  RegisterView;

typedef void(^ LoginBlock)();

@interface RegisterViewController : UIViewController

@property (nonatomic, retain) RegisterView *registerView;
@property (nonatomic, assign) LoginBlock loginBlock;
@end
