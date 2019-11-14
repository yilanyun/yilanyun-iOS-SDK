//
//  ThirdViewController.m
//  YLUISDKDemo
//
//  Created by leihaojie on 2019/11/8.
//  Copyright © 2019 leihaojie. All rights reserved.
//

#import "ThirdViewController.h"
#import <YLUISDK/YLUISDK-Swift.h>

@interface ThirdViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *list;

@end

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat y = UIApplication.sharedApplication.statusBarFrame.size.height + 45;
    CGFloat height = self.view.height - y - 49 - KBottomSafeHeight;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, y, self.view.width, height)];
    self.tableView.estimatedRowHeight = 100;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    NSURL *bundleUrl = [[NSBundle mainBundle] URLForResource:@"YLUISDKResource" withExtension:@"bundle"];
    NSBundle *bundle = [NSBundle bundleWithURL:bundleUrl];
    [self.tableView registerNib:[UINib nibWithNibName:@"YLVideoInfoCell" bundle:bundle] forCellReuseIdentifier:@"YLVideoInfoCell"];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    [self.view addSubview:self.tableView];
    
    [YLVideo.shared getSubFeedListWithType:@"0" num:2 channelID:@"" callback:^(NSArray<YLFeedModel *> * _Nonnull list) {
        self.list = list;
        [self.tableView reloadData];
    }];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    if (indexPath.row < self.list.count) {
        YLVideoInfoCell * cell = [tableView dequeueReusableCellWithIdentifier:@"YLVideoInfoCell" forIndexPath:indexPath];
        [cell reload:self.list[indexPath.row]];
        return cell;
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
        cell.textLabel.text = [NSString stringWithFormat:@"%ld", (long)indexPath.row];
        return cell;
    }
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([cell isKindOfClass:[YLVideoInfoCell class]]) {
        [(YLVideoInfoCell *)cell clickWith:YLPlayPageTypeRelation viewController:self];
    }
    
    // 第二种方式：通过feedModel打开播放页
//    if (indexPath.row < self.list.count) {
//        [YLVideo.shared openPlayerWith:self.list[indexPath.row] playPageType:YLPlayPageTypeRelation viewController:self];
//    }
}

@end
