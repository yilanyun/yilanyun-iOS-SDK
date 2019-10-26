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

@interface FirstViewController ()<YLPickerViewDelegate>

@property (nonatomic, strong) YLPickerView *picker;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) UIViewController *ylChild;
@property (nonatomic, assign) NSInteger curentType;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titles = @[@"频道集合->Native相关播放页", @"频道集合->Native Feed播放页", @"频道集合->H5播放页", @"单频道页"];
    self.navigationItem.title = self.titles[0];
    self.curentType = 0;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"切换" style:UIBarButtonItemStylePlain target:self action:@selector(moreAction)];
    
    [self createYLFeedWithSingle:NO type:YLPlayPageTypeRelation];
}

- (void)createYLFeedWithSingle:(BOOL)single type:(YLPlayPageType)type
{
    [self.ylChild.view removeFromSuperview];
    [self.ylChild removeFromParentViewController];
    
    CGFloat y = UIApplication.sharedApplication.statusBarFrame.size.height + 45;
    CGFloat height = self.view.height - y - 49 - KBottomSafeHeight;
    
    if (single)
    {
        YLFeedListViewController *feed = [[YLFeedListViewController alloc] init];
        // 播放页类型(默认：相关视频)
        feed.playPageType = type;
        // 频道ID
        feed.channelID = @"1291";
        feed.view.frame = CGRectMake(0, y, self.view.width, height);
        [self.view addSubview:feed.view];
        [self addChildViewController:feed];
        self.ylChild = feed;
        
    } else
    {
        YLRootViewController *root = [[YLRootViewController alloc] init];
        // 播放页类型(默认：相关视频)
        root.playPageType = type;
        root.view.frame = CGRectMake(0, y, self.view.width, height);
        [self.view addSubview:root.view];
        [self addChildViewController:root];
        self.ylChild = root;
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
            [self createYLFeedWithSingle:NO type:YLPlayPageTypeRelation];
            break;
        case 1:
            [self createYLFeedWithSingle:NO type:YLPlayPageTypeFeed];
            break;
        case 2:
            [self createYLFeedWithSingle:NO type:YLPlayPageTypeWeb];
            break;
        case 3:
            [self createYLFeedWithSingle:YES type:YLPlayPageTypeRelation];
            break;
        default:
            break;
    }
}

@end
