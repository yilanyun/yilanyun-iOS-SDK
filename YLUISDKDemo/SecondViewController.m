//
//  SecondViewController.m
//  YLUISDKDemo
//
//  Created by leihaojie on 2019/8/16.
//  Copyright © 2019 leihaojie. All rights reserved.
//

#import "SecondViewController.h"
#import "YLPickerView.h"
#import <YLUISDK/YLUISDK-Swift.h>
#import "SettingViewController.h"

@interface SecondViewController ()<YLPickerViewDelegate, YLVideoDelegate>

@property (nonatomic, strong) YLPickerView *picker;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) UIViewController *ylChild;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.titles = @[@"类抖音小视频", @"类快手小视频"];
    self.navigationItem.title = self.titles[0];
    UIBarButtonItem *moreItem = [[UIBarButtonItem alloc] initWithTitle:@"切换" style:UIBarButtonItemStylePlain target:self action:@selector(moreAction)];
    UIBarButtonItem *dislikeItem = [[UIBarButtonItem alloc] initWithTitle:@"负反馈" style:UIBarButtonItemStylePlain target:self action:@selector(dislikeAction)];
    self.navigationItem.rightBarButtonItems = @[moreItem, dislikeItem];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"配置" style:UIBarButtonItemStylePlain target:self action:@selector(settingAction)];
    
    [self createLittleWithList:NO];
}

- (void)createLittleWithList:(BOOL)list
{
    [self.ylChild.view removeFromSuperview];
    [self.ylChild removeFromParentViewController];
    
    CGFloat y = UIApplication.sharedApplication.statusBarFrame.size.height + 44;
    CGFloat height = self.view.height - y - 49 - KBottomSafeHeight;
    
    if (list)
    {
        YLLittleVideoListController *list = [[YLLittleVideoListController alloc] init];
        // 小视频视频状态及广告加载等回调信息
        list.delegate = self;
        list.view.frame = CGRectMake(0, y, self.view.width, height);
        [self.view addSubview:list.view];
        [self addChildViewController:list];
        self.ylChild = list;
        
    } else
    {
        YLLittleVideoViewController *video = [[YLLittleVideoViewController alloc] init];
        // 小视频视频状态及广告加载等回调信息
        video.delegate = self;
        video.view.frame = CGRectMake(0, y, self.view.width, height);
        [self.view addSubview:video.view];
        [self addChildViewController:video];
        self.ylChild = video;
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

- (void)dislikeAction
{
    if ([self.ylChild isKindOfClass:[YLLittleVideoViewController class]]) {
        [(YLLittleVideoViewController *)self.ylChild disLikeVideo];
    }
}

- (YLPickerView *)picker
{
    if (!_picker) {
        _picker = [[YLPickerView alloc] initWithTitles:self.titles];
        _picker.delegate = self;
    }
    return _picker;
}

#pragma mark - UIPickerViewDelegate
- (void)selectedIndex:(NSInteger)index
{
    self.navigationItem.title = self.titles[index];
    switch (index) {
        case 0:
            [self createLittleWithList:NO];
            break;
        case 1:
            [self createLittleWithList:YES];
            break;
        default:
            break;
    }
}

#pragma mark - YLVideoDelegate
// 首个视频开始播放(isAD: 是否是广告)
- (void)firstPlayerStartWithVideoInfo:(YLFeedModel *)videoInfo isAD:(BOOL)isAD {
}
// 视频开始播放(isAD: 是否是广告)
- (void)playerStartWithVideoInfo:(YLFeedModel *)videoInfo isAD:(BOOL)isAD {
}
// 视频播放暂停状态变化
- (void)playerPauseWithVideoInfo:(YLFeedModel *)videoInfo isPause:(BOOL)isPause isAD:(BOOL)isAD {
}
// 视频播放结束
- (void)playerEndWithVideoInfo:(YLFeedModel *)videoInfo isAD:(BOOL)isAD {
}
// 视频播放失败
- (void)playerErrorWithVideoInfo:(YLFeedModel *)videoInfo error:(NSError *)error isAD:(BOOL)isAD {
}
// 广告信息获取成功
- (void)ylADInfoLoadSuccessWithAdID:(NSString *)adID {
}
// 广告信息获取失败
- (void)ylADInfoLoadFailWithAdID:(NSString *)adID error:(NSError *)error {
}
// 点击分享按钮
- (void)clickShareBtnWithVideoInfo:(YLFeedModel *)videoInfo isMain:(BOOL)isMain {
    UIPasteboard.generalPasteboard.string = videoInfo.shareUrl;
}

@end
