//
//  UserViewController.m
//  YLUISDKDemo
//
//  Created by leihaojie on 2019/8/29.
//  Copyright © 2019 leihaojie. All rights reserved.
//

#import "UserViewController.h"
#import <YLUISDK/YLUISDK-Swift.h>

@interface UserViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nickText;
@property (weak, nonatomic) IBOutlet UITextField *avatarText;
@property (weak, nonatomic) IBOutlet UITextField *phoneText;
@property (weak, nonatomic) IBOutlet UITextField *userIDText;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIButton *logoutBtn;
@property (weak, nonatomic) IBOutlet UIButton *userInfoBtn;
@property (weak, nonatomic) IBOutlet UILabel *verLabel;

@end

@implementation UserViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"用户信息";
    
    self.verLabel.text = [NSString stringWithFormat:@"v%@", YLInit.shared.SDKVersion];
    [self setCornerWithBtn:self.loginBtn];
    [self setCornerWithBtn:self.logoutBtn];
    [self setCornerWithBtn:self.userInfoBtn];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [self.view addGestureRecognizer:tap];
}

- (void)setCornerWithBtn:(UIView *)button
{
    button.layer.cornerRadius = 5;
    button.layer.masksToBounds = YES;
}

- (void)tapAction
{
    [self.nickText resignFirstResponder];
    [self.avatarText resignFirstResponder];
    [self.phoneText resignFirstResponder];
    [self.userIDText resignFirstResponder];
}

- (IBAction)loginBtnAction:(id)sender
{
    [YLInit.shared loginWithNickname:self.nickText.text avatar:self.avatarText.text phone:self.phoneText.text uid:self.userIDText.text];
}

- (IBAction)logoutBtnAction:(id)sender
{
    [YLInit.shared logout];
}

- (IBAction)userInfoBtnAction:(id)sender
{
    NSString *message = @"未登录";
    if (YLInit.shared.isLogin) {
        message = @"已登录";
    }
    UIAlertController *alertCtrl = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
    }];
    [alertCtrl addAction:cancleAction];
    [self presentViewController:alertCtrl animated:YES completion:nil];
}

@end
