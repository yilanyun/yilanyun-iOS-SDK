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

@interface SecondViewController ()<YLPickerViewDelegate, YLLittleVideoDelegate>

@property (nonatomic, strong) YLPickerView *picker;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) UIViewController *ylChild;
@property (nonatomic, assign) NSInteger curentType;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titles = @[@"类抖音小视频", @"类快手小视频"];
    self.navigationItem.title = self.titles[0];
    self.curentType = 0;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"切换" style:UIBarButtonItemStylePlain target:self action:@selector(moreAction)];
    
    [self createLittleWithList:NO];
}

- (void)createLittleWithList:(BOOL)list
{
    [self.ylChild.view removeFromSuperview];
    [self.ylChild removeFromParentViewController];
    
    CGFloat y = UIApplication.sharedApplication.statusBarFrame.size.height + 45;
    CGFloat height = self.view.height - y - 49 - KBottomSafeHeight;
    
    if (list)
    {
        YLLittleVideoListController *list = [[YLLittleVideoListController alloc] init];
        // 小视频评论展示类型(默认不显示)
        list.commentType = YLLittleCommentTypeReadWrite;
        // 小视频播放器填充类型(默认resizeAspect)
        list.playerContentMode = YLLittlePlayerContentModeResizeAspectFill;
        // 是否显示分享按钮
        list.showShare = YES;
        // 小视频点赞等按钮位于底部（默认右边）
        list.bottomPanel = YES;
        // 小视频视频状态及广告加载等回调信息
        list.delegate = self;
        list.view.frame = CGRectMake(0, y, self.view.width, height);
        [self.view addSubview:list.view];
        [self addChildViewController:list];
        self.ylChild = list;
        
    } else
    {
        YLLittleVideoViewController *video = [[YLLittleVideoViewController alloc] init];
        // 小视频评论展示类型(默认不显示)
        video.commentType = YLLittleCommentTypeReadWrite;
        // 小视频播放器填充类型(默认resizeAspect)
        video.playerContentMode = YLLittlePlayerContentModeResizeAspectFill;
        // 是否显示分享按钮
        video.showShare = YES;
        // 小视频点赞等按钮位于底部（默认右边）
        video.bottomPanel = YES;
        // 小视频视频状态及广告加载等回调信息
        video.delegate = self;
        video.view.frame = CGRectMake(0, y, self.view.width, height);
        [self.view addSubview:video.view];
        [self addChildViewController:video];
        self.ylChild = video;
    }
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

#pragma mark - UIPickerViewDelegate
- (void)selectedIndex:(NSInteger)index
{
    if (self.curentType == index) {
        return;
    }
    self.navigationItem.title = self.titles[index];
    self.curentType = index;
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

#pragma mark - YLLittleVideoDelegate
// 首个视频开始播放(isAD: 是否是广告)
- (void)firstPlayerStartWithVideoID:(NSString *)videoID isAD:(BOOL)isAD {
}
// 视频开始播放(isAD: 是否是广告)
- (void)playerStartWithVideoID:(NSString * _Nonnull)videoID isAD:(BOOL)isAD {
}
// 视频播放暂停状态变化
- (void)playerPauseWithVideoID:(NSString * _Nonnull)videoID isPause:(BOOL)isPause isAD:(BOOL)isAD {
}
// 视频播放结束
- (void)playerEndWithVideoID:(NSString * _Nonnull)videoID isAD:(BOOL)isAD {
}
// 视频播放失败
- (void)playerErrorWithVideoID:(NSString * _Nonnull)videoID error:(NSError * _Nullable)error isAD:(BOOL)isAD {
}
// 广告信息获取成功
- (void)ylADInfoLoadSuccessWithAdID:(NSString *)adID {
}
// 广告信息获取失败
- (void)ylADInfoLoadFailWithAdID:(NSString *)adID error:(NSError *)error {
}
// 点击分享按钮
- (void)clickShareBtnWithVideoInfo:(YLFeedModel *)videoInfo {
}

@end
