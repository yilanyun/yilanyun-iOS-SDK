//
//  ViewController.m
//  YLDataSDKDemoOC
//
//  Created by yanpei on 2019/1/15.
//  Copyright © 2019 yilan. All rights reserved.
//

#import "ViewController.h"
#import <YLDataSDK/YLDataSDK-Swift.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    {
        UIButton *btn = [[UIButton alloc] init];
        btn.frame = CGRectMake(100, 100, 150, 50);
        [btn setTitle:@"频道列表" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [self.view addSubview:btn];
        [btn addTarget:self action:@selector(loadCategories) forControlEvents:UIControlEventTouchUpInside];
    }
    {
        UIButton *btn = [[UIButton alloc] init];
        btn.frame = CGRectMake(100, 150, 150, 50);
        [btn setTitle:@"频道信息流(首次刷新)" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [self.view addSubview:btn];
        [btn addTarget:self action:@selector(feedList1) forControlEvents:UIControlEventTouchUpInside];
    }
    {
        UIButton *btn = [[UIButton alloc] init];
        btn.frame = CGRectMake(100, 200, 150, 50);
        [btn setTitle:@"频道信息流(上拉刷新)" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [self.view addSubview:btn];
        [btn addTarget:self action:@selector(feedList2) forControlEvents:UIControlEventTouchUpInside];
    }
    {
        UIButton *btn = [[UIButton alloc] init];
        btn.frame = CGRectMake(100, 250, 150, 50);
        [btn setTitle:@"频道信息流(下拉刷新)" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [self.view addSubview:btn];
        [btn addTarget:self action:@selector(feedList3) forControlEvents:UIControlEventTouchUpInside];
    }
    {
        UIButton *btn = [[UIButton alloc] init];
        btn.frame = CGRectMake(100, 300, 150, 50);
        [btn setTitle:@"video show" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [self.view addSubview:btn];
        [btn addTarget:self action:@selector(videoShow) forControlEvents:UIControlEventTouchUpInside];
    }
    {
        UIButton *btn = [[UIButton alloc] init];
        btn.frame = CGRectMake(100, 350, 150, 50);
        [btn setTitle:@"video play" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [self.view addSubview:btn];
        [btn addTarget:self action:@selector(videoPlay) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)loadCategories
{
    [YLVideo.shared getChannelsWithCallback:^(BOOL result, NSArray<YLChannelModel *> * _Nonnull list) {
        NSLog(@"");
    }];
}

- (void)feedList1
{
    [YLVideo.shared getFeedListWithChannelId:@"10181" loadType:YLFeedLoadTypeFirst callback:^(BOOL result, NSArray<YLFeedModel *> * _Nonnull list) {
        NSLog(@"");
    }];
}

- (void)feedList2
{
    [YLVideo.shared getFeedListWithChannelId:@"10181" loadType:YLFeedLoadTypePullUp callback:^(BOOL result, NSArray<YLFeedModel *> * _Nonnull list) {
        NSLog(@"");
    }];
}

- (void)feedList3
{
    [YLVideo.shared getFeedListWithChannelId:@"10181" loadType:YLFeedLoadTypePullDown callback:^(BOOL result, NSArray<YLFeedModel *> * _Nonnull list) {
        NSLog(@"");
    }];
}

- (void)videoShow
{
}

- (void)videoPlay
{
}


@end
