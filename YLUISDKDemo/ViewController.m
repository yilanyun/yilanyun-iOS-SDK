//
//  ViewController.m
//  YLUISDKDemo
//
//  Created by yanpei on 2019/2/12.
//  Copyright © 2019 yilan. All rights reserved.
//

#import "ViewController.h"
#import <YLUISDK/YLUISDK-Swift.h>

@interface ViewController ()

@end

@implementation ViewController
{
    YLRootViewController *_rootVC;
//    YLFeedListViewController *_rootVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    YLUIConfig.playPageType = YLPlayPageTypeWeb;
    
    self.view.backgroundColor = [UIColor redColor];
    
    CGFloat statusBarHeight = [ViewController statusBarHeight];
    
    YLRootViewController *vc = [[YLRootViewController alloc] init];
    vc.view.userInteractionEnabled = true;
    vc.view.frame = CGRectMake(0, statusBarHeight, self.view.frame.size.width, self.view.frame.size.height - statusBarHeight);
    [self.view addSubview:vc.view];
    [self addChildViewController:vc];
    _rootVC = vc;
    
//    YLFeedListViewController *feedVC = [[YLFeedListViewController alloc] init];
//    feedVC.view.frame = CGRectMake(0, statusBarHeight, self.view.frame.size.width, self.view.frame.size.height - statusBarHeight);
//    feedVC.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//    feedVC.view.backgroundColor = [UIColor greenColor];
//    feedVC.channelID = @"1291";
//    [self.view addSubview:feedVC.view];
//    [self addChildViewController:feedVC];
//    _rootVC = feedVC;
    
    {
        UIButton *btn = [[UIButton alloc] init];
        btn.frame = CGRectMake(100, 200, 80, 50);
        btn.backgroundColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.5];
        [btn setTitle:@"top" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnClicked) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
    
    {
        UIButton *btn = [[UIButton alloc] init];
        btn.frame = CGRectMake(200, 200, 80, 50);
        btn.backgroundColor = [UIColor colorWithRed:0 green:1 blue:0 alpha:0.5];
        [btn setTitle:@"refresh" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(refreshClicked) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
    
}

- (void)btnClicked
{
    [_rootVC scrollToTopWithPullRefresh:false];
}

- (void)refreshClicked
{
    [_rootVC scrollToTopWithPullRefresh:true];
}

+ (CGFloat)statusBarHeight
{
    if ([UIScreen mainScreen].bounds.size.height > 811) {
        return 44;
    } else {
        return 20;
    }
}

- (BOOL)shouldAutorotate
{
    return false;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}

@end
