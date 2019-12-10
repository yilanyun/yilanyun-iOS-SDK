//
//  FirstViewController.m
//  YLUISDKDemo
//
//  Created by leihaojie on 2019/8/16.
//  Copyright © 2019 leihaojie. All rights reserved.
//

#import "FirstViewController.h"
#import "YLPickerView.h"
#import <YLUISDK/YLUISDK-Swift.h>
#import "SettingViewController.h"

@interface FirstViewController ()<YLPickerViewDelegate, YLVideoDelegate>

@property (nonatomic, strong) YLPickerView *picker;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) UIViewController *ylChild;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.titles = @[@"频道集合", @"单频道页"];
    self.navigationItem.title = self.titles[0];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"切换" style:UIBarButtonItemStylePlain target:self action:@selector(moreAction)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"配置" style:UIBarButtonItemStylePlain target:self action:@selector(settingAction)];
    
    [self createYLFeedWithSingle:NO];
}

- (void)createYLFeedWithSingle:(BOOL)single
{
    [self.ylChild.view removeFromSuperview];
    [self.ylChild removeFromParentViewController];
    
    CGFloat y = UIApplication.sharedApplication.statusBarFrame.size.height + 45;
    CGFloat height = self.view.height - y - 49 - KBottomSafeHeight;
    
    if (single)
    {
        YLFeedListViewController *feed = [[YLFeedListViewController alloc] init];
        // 频道ID
        feed.channelID = @"1291";
        feed.delegate = self;
        feed.view.frame = CGRectMake(0, y, self.view.width, height);
        [self.view addSubview:feed.view];
        [self addChildViewController:feed];
        self.ylChild = feed;
        
    } else
    {
        YLRootViewController *root = [[YLRootViewController alloc] init];
        root.delegate = self;
        root.view.frame = CGRectMake(0, y, self.view.width, height);
        [self.view addSubview:root.view];
        [self addChildViewController:root];
        self.ylChild = root;
    }
}

- (void)settingAction
{
    [self.navigationController pushViewController:[[SettingViewController alloc] init] animated:YES];
}

- (void)moreAction
{
    [self.picker show];
}

- (YLPickerView *)picker
{
    if (!_picker) {
        _picker = [[YLPickerView alloc] initWithTitles:self.titles];
        _picker.delegate = self;
    }
    return _picker;
}

#pragma mark - YLVideoDelegate
// 视频开始播放
- (void)playerStartWithVideoInfo:(YLFeedModel *)videoInfo {
}
// 视频播放暂停状态变化
- (void)playerPauseWithVideoInfo:(YLFeedModel *)videoInfo isPause:(BOOL)isPause {
}
// 视频播放结束
- (void)playerEndWithVideoInfo:(YLFeedModel *)videoInfo {
}
// 视频播放失败
- (void)playerErrorWithVideoInfo:(YLFeedModel *)videoInfo error:(NSError *)error {
}
// 点击分享按钮
- (void)clickVideoShareBtnWithVideoInfo:(YLFeedModel *)videoInfo {
}

#pragma mark - UIPickerViewDelegate
- (void)selectedIndex:(NSInteger)index
{
    self.navigationItem.title = self.titles[index];
    [self createYLFeedWithSingle:index == 0 ? NO : YES];
}

@end
