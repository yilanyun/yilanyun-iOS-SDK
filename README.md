# yilanyun-iOS-SDK

ReleaseNote

| 版本   | 时间           | 修改内容                                                     |
| ------ | -------------- | ------------------------------------------------------------ |
| 1.1.0  | 2019年5月15号  | init                                                         |
| 1.2.0  | 2019年8月16号  | 增加小视频功能                                               |
| 1.3.0  | 2019年8月29号  | 1、小视频增加点赞和评论功能<br />2、加入账号系统             |
| 1.4.0  | 2019年9月6号   | 支持在小视频中投放客户的穿山甲小视频广告                     |
| 1.4.2  | 2019年10月25号 | 1、SDK改为静态库打包方式、适配iOS13<br />2、横版视频支持直投视频广告 |
| 1.4.4  | 2019年11月7号  | 1、直投广告支持更多样式<br />2、竖版视频增加分享功能和更多可配置项 |
| 1.4.6  | 2019年11月14号 | 1、增加局部信息流功能（详见文档3.10）<br />2、增加视频作者信息页面 |
| 1.4.8  | 2019年11月26号 | 1、横版视频增加当前页播放形式（YLUIConfig.playPageType）<br />2、横版视频增加点赞、评论、分享功能<br />3、增加视频举报功能（详见文档3.3）<br />4、所有可配置项改为全局配置（详见文档3.1）<br />5、广告位优化 |
| 1.4.10 | 2019年12月10号 | 1、竖版视频增加文字和卡片广告<br />2、横版视频回调整个视频信息（详见文档3.6）<br />3、UI优化 |
| 1.4.12 | 2019年12月20号 | 1、增加关注CP功能（详见文档3.1）<br />2、横版和竖版视频feed流支持穿山甲模板广告<br />3、横版和竖版视频代理合并<br />4、增加竖版视频负反馈功能（详见文档3.7） |
| 1.4.14 | 2020年1月6号   | 1、竖版视频支持原生视频广告<br />2、横版视频相关和banner广告位支持穿山甲投放 |
| 1.4.16 | 2020年1月14号  | 1、横版视频支持前后贴广告<br />2、横版视频feed流原生广告UI优化 |

Demo地址：https://github.com/yilanyun/yilanyun-iOS-SDK

## 一、iOS UI SDK接入

最低支持系统: iOS 9.0。

本SDK需和穿山甲SDK同时使用（若暂无穿山甲APPID，则仅接入穿山甲SDK即可）。

### 1、OC项目接入

1、将YLUISDK.framework和YLUISDKResource.bundle文件拖入工程。

2、在项目中新建一个swift文件，并跟随指引创建桥接文件（若已有桥接文件可跳过此步骤）。

3、按照穿山甲SDK接入文档接入穿山甲（github地址：https://github.com/bytedance/Bytedance-UnionAD/tree/master）。

### 2、Swift项目接入

1、将YLUISDK.framework和YLUISDKResource.bundle文件拖入工程。

2、按照穿山甲SDK接入文档接入穿山甲（github地址：https://github.com/bytedance/Bytedance-UnionAD/tree/master）。

## 二、SDK主要类

- YLInit：整个SDK的主入口，单例，主要提供初始化，配置用户信息。
- YLRootViewController：带频道和水平导航的UI，UIViewController类型，可以方便的嵌入用户App中。
- YLFeedListViewController：某单一频道fee流页面。
- YLLittleVideoViewController：类似抖音的竖屏视频页面。
- YLLittleVideoListController：类似快手的竖屏视频列表页面。

## 三、接入代码

### 1、在使用SDK的类中添加引用

只需在类中添加如下引用即可使用SDK所有功能，无需引用YLInit等对应的类。

- OC项目：

  ```objective-c
  #import <YLUISDK/YLUISDK-Swift.h>
  ```

- Swift项目：

  ```swift
  import YLUISDK
  ```

### 2、初始化SDK及SDK配置等

在程序刚启动时, 调一览SDK其他功能之前，调初始化代码。

```objective-c
/**
 初始化SDK
 @param key : key由一览提供
 @param token : token由一览提供
 @param sid : 设置渠道号
 @param uid : 为了获取更加准确的跨平台的个性化推荐内容，鼓励用户配置应用的唯一userId
 */
[YLInit.shared setAccessKey:@"xxx" token:@"yyy" sid:@"zzz" uid:@"111"];
// SDK Debug信息开关, 默认关闭
YLInit.shared.debugMode = YES;
// 获取SDK版本号
NSString *version = YLInit.shared.SDKVersion;
```

### 3、嵌入UI

接入YLRootViewController等类时，建议使用childViewController的方式接入，以便调整frame来快速适配不同的项目结构。

```objective-c
// 为兼容iOS9设备中，scrollView特定情况下自动向下偏移一段距离的问题，建议使用时在viewController中加入以下代码
self.automaticallyAdjustsScrollViewInsets = NO;
```

#### 3.1、自定义UI

```objective-c
// H5播放页顶部导航栏-背景的颜色
YLUIConfig.webViewBgColor = UIColor.whiteColor;
// H5播放页顶部导航栏-文字和返回按钮的颜色
YLUIConfig.webViewTintColor = UIColor.blackColor;

// CP信息页是否显示关注按钮（默认隐藏）
YLUIConfig.showFollow = YES;
/*-----------------  横版视频配置项  -----------------*/
// 播放页类型(默认：相关视频；局部信息流不支持当前页播放形式)
YLUIConfig.playPageType = YLPlayPageTypeRelation;
// 是否响应点击头像跳转CP页(默认响应)
YLUIConfig.cpInfoResponse = YES;
// 评论展示类型(默认不显示)
YLUIConfig.commentType = YLLittleCommentTypeNone;
// 是否显示分享按钮(默认不显示)
YLUIConfig.showShare = NO;

/*-----------------  竖版视频配置项  -----------------*/
// 评论展示类型(默认不显示)
YLUIConfig.littleCommentType = YLLittleCommentTypeNone;
// 播放器填充类型(默认resizeAspect)
YLUIConfig.playerContentMode = YLLittlePlayerContentModeResizeAspect;
// 点赞等按钮位于底部（默认右边）
YLUIConfig.bottomPanel = NO;
// 是否显示分享按钮(默认不显示)
YLUIConfig.littleShowShare = NO;
```

#### 3.2、接入一览用户系统

```objective-c
// 用户登录
[YLInit.shared loginWithNickname:@"用户昵称" avatar:@"http[s]开头的完整图片url" phone:@"手机号，未传手机号不可评论" uid:@"用户ID"];
// 用户退出登录
[YLInit.shared logout];
// 查询用户登录状态
BOOL isLogin = YLInit.shared.isLogin;
```

#### 3.3、举报视频

```objective-c
// 获取举报视频原因列表
NSArray *list = [YLVideo.shared getReportReasonList];
/*
 举报视频
 @param reason : 选择举报的原因
 @param otherDescription : 选择其他问题时，填写的具体问题
 */
[YLVideo.shared reportVideoWith:list[0] otherDescription:@""];
```

#### 3.4、带频道导航的类：YLRootViewController

##### 3.4.1、添加rootView：

```objective-c
YLRootViewController *root = [[YLRootViewController alloc] init];
// 横版视频状态等回调信息(详见3.6)
root.delegate = self;
root.view.frame = CGRectMake(0, y, self.view.width, height);
[self.view addSubview:root.view];
[self addChildViewController:root];
```

##### 3.4.2、feed流滑动控制：

控制feed流滑动到顶部，并设置是否刷新feed数据。

```objective-c
[root scrollToTopWithPullRefresh:NO];
```

#### 3.5、单一频道：YLFeedListViewController

##### 3.5.1、添加feedListView：

```objective-c
YLFeedListViewController *feed = [[YLFeedListViewController alloc] init];
// 频道ID
feed.channelID = @"1291";
// 横版视频状态等回调信息(详见3.6)
feed.delegate = self;
feed.view.frame = CGRectMake(0, y, self.view.width, height);
[self.view addSubview:feed.view];
[self addChildViewController:feed];
```

##### 3.5.2、feed流滑动控制：同3.4.2。

#### 3.6、横版视频状态等回调信息：YLVideoDelegate

```objective-c
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
// 点击分享按钮(isMain: 竖版视频用来标记是否是首页，仅首页支持负反馈功能)
- (void)clickShareBtnWithVideoInfo:(YLFeedModel *)videoInfo isMain:(BOOL)isMain {
    UIPasteboard.generalPasteboard.string = videoInfo.shareUrl;
}
```

#### 3.7、类似抖音的竖屏视频页面：YLLittleVideoViewController

```objective-c
YLLittleVideoViewController *video = [[YLLittleVideoViewController alloc] init];
// 小视频视频状态及广告加载等回调信息(详见3.9)
video.delegate = self;
video.view.frame = CGRectMake(0, y, self.view.width, height);
[self.view addSubview:video.view];
[self addChildViewController:video];

// 对当前正在播放的视频进行负反馈
[video disLikeVideo];
```

#### 3.8、类似快手的竖屏视频列表页面：YLLittleVideoListController

```objective-c
YLLittleVideoListController *list = [[YLLittleVideoListController alloc] init];
// 小视频视频状态及广告加载等回调信息(详见3.9)
list.delegate = self;
list.view.frame = CGRectMake(0, y, self.view.width, height);
[self.view addSubview:list.view];
[self addChildViewController:list];
```

#### 3.9、小视频视频状态及广告加载等回调信息：YLVideoDelegate

```objective-c
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
// 点击分享按钮(isMain: 竖版视频用来标记是否是首页，仅首页支持负反馈功能)
- (void)clickShareBtnWithVideoInfo:(YLFeedModel *)videoInfo isMain:(BOOL)isMain {
    UIPasteboard.generalPasteboard.string = videoInfo.shareUrl;
}
```

#### 3.10、局部信息流

##### 3.10.1、获取局部信息及打开播放页

```objective-c
/**
 获取局部信息流信息
 @param type : 视频类型  0-横版视频视频  1-竖版视频
 @param num : 视频数量，1-4个，默认1
 @param channelID : 指定视频频道，默认从配置内容池选取
*/
[YLVideo.shared getSubFeedListWithType:@"0" num:2 channelID:@"" callback:^(NSArray<YLFeedModel *> * _Nonnull list) {
}];
// 通过局部信息流打开横版视频播放页
[YLVideo.shared openPlayerWith:model viewController:self];
/**
 通过局部信息流打开竖版视频播放页
 @param list : 视频列表
 @param playIndex : 打开播放页后展示视频位于list中的下标
*/
[YLVideo.shared openPlayerWith:list playIndex:0 delegate:self viewController:self];
```

##### 3.10.2、通过SDK渲染横版视频局部信息：YLVideoInfoCell

```objective-c
// YLVideoInfoCell支持预估行高（estimatedRowHeight），若接入时tableView使用的是预估行高则不需要设置YLVideoInfoCell的高度。
// 若tableView不支持预估行高，则需要手动设置cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([cell isKindOfClass:[YLVideoInfoCell class]]) {
        return self.tableView.frame.size.width / 16 * 9 + 50;
    }
}
// tableView注册YLVideoInfoCell
[self.tableView registerNib:[UINib nibWithNibName:@"YLVideoInfoCell" bundle:bundle] forCellReuseIdentifier:@"YLVideoInfoCell"];
// 点击cell打开横版视频播放页
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([cell isKindOfClass:[YLVideoInfoCell class]]) {
        [(YLVideoInfoCell *)cell clickWith:self];
    }
    // 第二种方式：通过feedModel打开播放页
//    if (indexPath.row < self.list.count) {
//        [YLVideo.shared openPlayerWith:self.list[indexPath.row] viewController:self];
//    }
}
```

## 四、支持穿山甲广告

- 首先通过商务沟通配置好广告位等信息

- 根据穿山甲SDK文档完成项目配置，并设置正确的APPID，对应位置即会展现穿山甲广告