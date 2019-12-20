//
//  SettingViewController.m
//  YLUISDKDemo
//
//  Created by leihaojie on 2019/11/25.
//  Copyright © 2019 leihaojie. All rights reserved.
//

#import "SettingViewController.h"
#import <YLUISDK/YLUISDK-Swift.h>
#import "YLPickerView.h"

@interface SettingViewController ()<UITableViewDelegate, UITableViewDataSource, YLPickerViewDelegate>

@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSArray *settingList;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) NSUInteger index;

@end

@implementation SettingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.whiteColor;
    self.navigationItem.title = @"配置项";
    
    self.titles = @[@"横版视频播放页类型",
                    @"横版视频是否响应点击头像跳转CP页",
                    @"横版视频评论展示类型",
                    @"横版视频是否显示分享按钮",
                    @"竖版视频评论展示类型",
                    @"竖版视频播放器填充类型",
                    @"竖版视频点赞等按钮位于底部",
                    @"竖版视频是否显示分享按钮",
                    @"CP页是否显示关注按钮"];
    self.settingList = @[@[@"H5播放页", @"相关视频播放页", @"feed流播放页", @"当前页播放"],
                         @[@"响应", @"不响应"],
                         @[@"不显示", @"只读", @"读写"],
                         @[@"不显示", @"显示"],
                         @[@"不显示", @"只读", @"读写"],
                         @[@"留白式等比例填充", @"非等比例填充", @"裁剪式等比例填充"],
                         @[@"右边", @"底部"],
                         @[@"不显示", @"显示"],
                         @[@"不显示", @"显示"]];
    
    CGFloat y = UIApplication.sharedApplication.statusBarFrame.size.height + 45;
    CGFloat height = self.view.height - y - 49 - KBottomSafeHeight;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, y, self.view.width, height)];
    self.tableView.rowHeight = 60;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.tableView];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"UITableViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = self.titles[indexPath.row];
    cell.detailTextLabel.text = [self detailText:indexPath.row];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titles.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.index = indexPath.row;
    YLPickerView *picker = [[YLPickerView alloc] initWithTitles:self.settingList[indexPath.row]];
    picker.delegate = self;
    [picker show];
}

- (NSString *)detailText:(NSInteger)index
{
    switch (index) {
        case 0:
            switch (YLUIConfig.playPageType) {
                case YLPlayPageTypeWeb:
                    return @"H5播放页";
                    break;
                case YLPlayPageTypeRelation:
                    return @"相关视频播放页";
                    break;
                case YLPlayPageTypeFeed:
                    return @"feed流播放页";
                    break;
                case YLPlayPageTypeDirect:
                    return @"当前页播放";
                    break;
                default:
                    break;
            }
            break;
        case 1:
            return YLUIConfig.cpInfoResponse ? @"响应" : @"不响应";
            break;
        case 2:
            switch (YLUIConfig.commentType) {
                case YLLittleCommentTypeNone:
                    return @"不显示";
                    break;
                case YLLittleCommentTypeRead:
                    return @"只读";
                    break;
                case YLLittleCommentTypeReadWrite:
                    return @"读写";
                    break;
                default:
                    break;
            }
            break;
        case 3:
            return YLUIConfig.showShare ? @"显示" : @"不显示";
            break;
        case 4:
            switch (YLUIConfig.littleCommentType) {
                case YLLittleCommentTypeNone:
                    return @"不显示";
                    break;
                case YLLittleCommentTypeRead:
                    return @"只读";
                    break;
                case YLLittleCommentTypeReadWrite:
                    return @"读写";
                    break;
                default:
                    break;
            }
            break;
        case 5:
            switch (YLUIConfig.playerContentMode) {
                case YLLittlePlayerContentModeResizeAspect:
                    return @"留白式等比例填充";
                    break;
                case YLLittlePlayerContentModeResize:
                    return @"非等比例填充";
                    break;
                case YLLittlePlayerContentModeResizeAspectFill:
                    return @"裁剪式等比例填充";
                    break;
                default:
                    break;
            }
            break;
        case 6:
            return YLUIConfig.bottomPanel ? @"底部" : @"右边";
            break;
        case 7:
            return YLUIConfig.littleShowShare ? @"显示" : @"不显示";
            break;
        case 8:
            return YLUIConfig.showFollow ? @"显示" : @"不显示";
            break;
        default:
            return @"";
            break;
    }
}

- (void)selectedIndex:(NSInteger)index
{
    switch (self.index) {
        case 0:
            switch (index) {
                case 0:
                    YLUIConfig.playPageType = YLPlayPageTypeWeb;
                    break;
                case 1:
                    YLUIConfig.playPageType = YLPlayPageTypeRelation;
                    break;
                case 2:
                    YLUIConfig.playPageType = YLPlayPageTypeFeed;
                    break;
                case 3:
                    YLUIConfig.playPageType = YLPlayPageTypeDirect;
                    break;
                default:
                    break;
            }
            break;
        case 1:
            YLUIConfig.cpInfoResponse = index == 0 ? YES : NO;
            break;
        case 2:
            switch (index) {
                case 0:
                    YLUIConfig.commentType = YLLittleCommentTypeNone;
                    break;
                case 1:
                    YLUIConfig.commentType = YLLittleCommentTypeRead;
                    break;
                case 2:
                    YLUIConfig.commentType = YLLittleCommentTypeReadWrite;
                    break;
                default:
                    break;
            }
            break;
        case 3:
            YLUIConfig.showShare = index == 0 ? NO : YES;
            break;
        case 4:
            switch (index) {
                case 0:
                    YLUIConfig.littleCommentType = YLLittleCommentTypeNone;
                    break;
                case 1:
                    YLUIConfig.littleCommentType = YLLittleCommentTypeRead;
                    break;
                case 2:
                    YLUIConfig.littleCommentType = YLLittleCommentTypeReadWrite;
                    break;
                default:
                    break;
            }
            break;
        case 5:
            switch (index) {
                case 0:
                    YLUIConfig.playerContentMode = YLLittlePlayerContentModeResizeAspect;
                    break;
                case 1:
                    YLUIConfig.playerContentMode = YLLittlePlayerContentModeResize;
                    break;
                case 2:
                    YLUIConfig.playerContentMode = YLLittlePlayerContentModeResizeAspectFill;
                    break;
                default:
                    break;
            }
            break;
        case 6:
            YLUIConfig.bottomPanel = index == 0 ? NO : YES;
            break;
        case 7:
            YLUIConfig.littleShowShare = index == 0 ? NO : YES;
            break;
        case 8:
            YLUIConfig.showFollow = index == 0 ? NO : YES;
            break;
        default:
            break;
    }
    [self.tableView reloadData];
}

@end
