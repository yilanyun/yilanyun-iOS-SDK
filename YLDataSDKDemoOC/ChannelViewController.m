//
//  ChannelViewController.m
//  YLDataSDKDemoOC
//
//  Created by yanpei on 2019/1/16.
//  Copyright © 2019 yilan. All rights reserved.
//

#import "ChannelViewController.h"
#import "YLDataSDKDemoOC-Swift.h"
#import <YLDataSDK/YLDataSDK-Swift.h>
#import "ChannelItemCell.h"
#import "VideoInfoCell.h"

@interface ChannelViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource>

@end

@implementation ChannelViewController

UICollectionView *channelsView;
NSArray<YLChannelModel*> *channelList;
NSString *curChannel;

UITableView *feedListView;
NSArray<YLFeedModel*> *feedList;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.itemSize = CGSizeMake(50, 40);
    flowLayout.minimumLineSpacing = 4;
    flowLayout.minimumInteritemSpacing = 4;
    
    CGFloat top = 20;
    if (UIScreen.mainScreen.bounds.size.height > 811) {
        top = 44;
    }
    CGRect channelsViewFrame = CGRectMake(0, top, UIScreen.mainScreen.bounds.size.width, 40);
    channelsView = [[UICollectionView alloc] initWithFrame:channelsViewFrame collectionViewLayout:flowLayout];
    channelsView.showsVerticalScrollIndicator = NO;
    channelsView.showsHorizontalScrollIndicator = NO;
    channelsView.backgroundColor = [UIColor darkGrayColor];
    channelsView.delegate = self;
    channelsView.dataSource = self;
    [channelsView registerClass:ChannelItemCell.class forCellWithReuseIdentifier:@"ChannelItemCell"];
    [self.view addSubview:channelsView];
    
    feedListView = [[UITableView alloc] init];
    CGFloat maxY = channelsViewFrame.size.height + channelsViewFrame.origin.y;
    feedListView.frame = CGRectMake(0, maxY, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height - maxY);
    [feedListView registerNib:[UINib nibWithNibName:@"VideoInfoCell" bundle:nil] forCellReuseIdentifier:@"VideoInfoCell"];
    feedListView.delegate = self;
    feedListView.dataSource = self;
    feedListView.rowHeight = UIScreen.mainScreen.bounds.size.width / 16 * 9 + 50;
    [self.view addSubview:feedListView];
    
    [self loadCategories];
}

- (void)dealloc
{
    [NSNotificationCenter.defaultCenter removeObserver:self];
}



- (void)loadCategories
{
    [YLVideo.shared getChannelsWithCallback:^(BOOL success, NSArray<YLChannelModel *> *list) {
        if (success) {
            channelList = list;
            [channelsView reloadData];
            if (channelList.count > 0) {
                YLChannelModel *firstChannel = channelList[0];
                [self loadFeedList:firstChannel.id loadType:YLFeedLoadTypeFirst];
            }
        }
    }];
}

- (void)loadFeedList: (NSString*)channelID
            loadType: (YLFeedLoadType)loadType
{
    curChannel = channelID;
    
    [YLVideo.shared getFeedListWithChannelId:channelID loadType:loadType callback:^(BOOL success, NSArray<YLFeedModel *> *list) {
        if (success) {
            feedList = list;
            [feedListView reloadData];
        }
    }];
}

///////////

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return channelList.count;
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    ChannelItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ChannelItemCell" forIndexPath:indexPath];
    if ([cell isKindOfClass:ChannelItemCell.class]) {
        YLChannelModel *model = channelList[indexPath.row];
        [cell reloadData:model];
        return cell;
    }
    return [[UICollectionViewCell alloc] init];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    YLChannelModel *model = channelList[indexPath.row];
    [self loadFeedList:model.id loadType:YLFeedLoadTypeFirst];
}


///////////

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return feedList.count;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    VideoInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VideoInfoCell" forIndexPath:indexPath];
    if ([cell isKindOfClass:VideoInfoCell.class]) {
        YLFeedModel *model = feedList[indexPath.row];
        [cell reloadData:model];
        
        return cell;
    }
    return [[UITableViewCell alloc] init];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    YLFeedModel *model = feedList[indexPath.row];
    WebViewController *vc = [[WebViewController alloc] init];
    vc.urlStr = model.h5_url;
    [self presentViewController:vc animated:YES completion:nil];
    [YLReport.shared videoPlayWithVideoInfo:model];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    YLFeedModel *model = feedList[indexPath.row];
    [YLReport.shared videoShowWithVideoInfo:model];
}


@end




