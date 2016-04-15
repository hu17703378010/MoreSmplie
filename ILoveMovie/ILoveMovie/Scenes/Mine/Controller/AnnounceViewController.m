//
//  AnnounceViewController.m
//  ILoveMovie
//
//  Created by lanou3g on 15/11/7.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import "AnnounceViewController.h"

@interface AnnounceViewController ()

@end

@implementation AnnounceViewController

- (void)viewDidLoad {\
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"版本声明";

    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0.8 green:0.247 blue:0.314 alpha:0.580]];

    // 左返回
    UIBarButtonItem *imageBarButton = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"iconfont-fanhui(1)"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)] style:(UIBarButtonItemStylePlain) target:self action:@selector(actionImageBarButton:)];
    self.navigationItem.leftBarButtonItem = imageBarButton;
    
    
    UIImageView *imageViews = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"flower"]];
    imageViews.frame = CGRectMake((self.view.frame.size.width - 200*KW)/2, 70*KH, 200*KW, 80*KH);
    [self.view addSubview:imageViews];
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake((imageViews.frame.size.width - 70*KW)/2, 15*KH, 70*KW, 50*KH)];
    nameLabel.text = @"版权声明";
    nameLabel.font = [UIFont systemFontOfSize:16*KH];
    [imageViews addSubview:nameLabel];
    UILabel *contantLabel = [[UILabel alloc]initWithFrame:CGRectMake(8*KW, imageViews.bottom-30*KH, (self.view.frame.size.width-10*KW), (self.view.frame.size.height - 120*KH))];
   // contantLabel.backgroundColor = [UIColor redColor];
    [self.view addSubview:contantLabel];
    contantLabel.numberOfLines = 0;
    contantLabel.font = [UIFont systemFontOfSize:12*KW];
    contantLabel.text = @"1、 一切移动客户端用户在下载并浏览本APP软件时均被视为已经仔细阅读本条款并完全同意。凡以任何方式登陆本APP，或直接、间接使用本APP资料者，均被视为自愿接受本网站相关声明和用户服务协议的约束。\n2、 本APP分享的内容并不代表APP手机APP之意见及观点，也不意味着本网赞同其观点或证实其内容的真实性。\n3、 本APP分享的文字、图片、音视频等资料均由网络提供，其真实性、准确性和合法性由信息发布人负责。本APP不提供任何保证，并不承担任何法律责任。\n4、 本APP所分享的文字、图片、音视频等资料，如果侵犯了第三方的知识产权或其他权利，本APP对此不承担责任。\n5、 本APP不保证为向用户提供便利而设置的外部链接的准确性和完整性，同时，对于该外部链接指向的不由本APP实际控制的任何网页上的内容，本APP不承担任何责任。\n6、 用户明确并同意其使用本APP网络服务所存在的风险将完全由其本人承担；因其使用本APP网络服务而产生的一切后果也由其本人承担，本APP对此不承担任何责任。\n7、 除本APP注明之服务条款外，其它因不当使用本APP而导致的任何意外、疏忽、合约毁坏、诽谤、版权或其他知识产权侵犯及其所造成的任何损失，本APP概不负责，亦不承担任何法律责任。\n8、 对于因不可抗力或因黑客攻击、通讯线路中断等本APP不能控制的原因造成的网络服务中断或其他缺陷，导致用户不能正常使用本APP，本APP不承担任何责任，但将尽力减少因此给用户造成的损失或影响。\n9、 本声明未涉及的问题请参见国家有关法律法规，当本声明与国家有关法律法规冲突时，以国家法律法规为准。\n10、本网站相关声明版权及其修改权、更新权和最终解释权均属本APP所有。\n";
}


- (void)actionImageBarButton:(UIBarButtonItem *)imageBarButton
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
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
