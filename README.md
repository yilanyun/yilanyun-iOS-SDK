# yilanyun-iOS-SDK

ReleaseNote

| 版本  | 时间           | 修改内容                                                     |
| ----- | -------------- | ------------------------------------------------------------ |
| 1.1.0 | 2019年5月15号  | init                                                         |
| 1.2.0 | 2019年8月16号  | 增加小视频功能                                               |
| 1.3.0 | 2019年8月29号  | 1、小视频增加点赞和评论功能<br />2、加入账号系统             |
| 1.4.0 | 2019年9月6号   | 支持在小视频中投放客户的穿山甲小视频广告                     |
| 1.4.2 | 2019年10月25号 | 1、SDK改为静态库打包方式、适配iOS13<br />2、横版视频支持直投视频广告 |
| 1.4.4 | 2019年11月7号  | 1、直投广告支持更多样式<br />2、竖版视频增加分享功能和更多可配置项（详见文档3.5、3.6、3.7） |

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
[YLInit.shared setAccessKey:@"xxx" token:@"yyy" sid:@"zzz" uid:@"111"];
// SDK Debug信息开关, 默认关闭
YLInit.shared.debugMode = YES;
// 获取SDK版本号
NSString *version = YLInit.shared.SDKVersion;
```

### 3、嵌入UI

接入YLRootViewController等类时，建议使用childViewController的方式接入，以便调整frame来快速适配不同的项目结构。

#### 3.1、自定义UI

- H5播放页顶部导航栏-文字和返回按钮的颜色: YLUIConfig.webViewTintColor

- H5播放页顶部导航栏-背景的颜色: YLUIConfig.webViewBgColor

#### 3.2、接入一览用户系统

目前用户系统只用于小视频点赞和评论

```objective-c
// 用户登录
[YLInit.shared loginWithNickname:@"用户昵称" avatar:@"http[s]开头的完整图片url" phone:@"手机号，未传手机号不可评论" uid:@"用户ID"];
// 用户退出登录
[YLInit.shared logout];
// 查询用户登录状态
BOOL isLogin = YLInit.shared.isLogin;
```

#### 3.3、带频道导航的类：YLRootViewController

##### 3.3.1、添加rootView：

```objective-c
YLRootViewController *root = [[YLRootViewController alloc] init];
// 播放页类型(默认：相关视频)
root.playPageType = type;
root.view.frame = CGRectMake(0, y, self.view.width, height);
[self.view addSubview:root.view];
[self addChildViewController:root];
```

##### 3.3.2、feed流滑动控制：

控制feed流滑动到顶部，并设置是否刷新feed数据。

```objective-c
[root scrollToTopWithPullRefresh:NO];
```

#### 3.4、单一频道：YLFeedListViewController

##### 3.4.1、添加feedListView：

```objective-c
YLFeedListViewController *feed = [[YLFeedListViewController alloc] init];
// 播放页类型(默认：相关视频)
feed.playPageType = type;
// 频道ID
feed.channelID = @"1291";
feed.view.frame = CGRectMake(0, y, self.view.width, height);
[self.view addSubview:feed.view];
[self addChildViewController:feed];
```

##### 3.4.2、feed流滑动控制：同3.3.2。

#### 3.5、类似抖音的竖屏视频页面：YLLittleVideoViewController

```objective-c
YLLittleVideoViewController *video = [[YLLittleVideoViewController alloc] init];
// 小视频评论展示类型(默认不显示)
video.commentType = YLLittleCommentTypeReadWrite;
// 小视频播放器填充类型(默认resizeAspect)
video.playerContentMode = YLLittlePlayerContentModeResizeAspectFill;
// 是否显示分享按钮
video.showShare = YES;
// 小视频点赞等按钮位于底部（默认右边）
video.bottomPanel = YES;
// 小视频视频状态及广告加载等回调信息(详见3.7)
video.delegate = self;
video.view.frame = CGRectMake(0, y, self.view.width, height);
[self.view addSubview:video.view];
[self addChildViewController:video];
```

#### 3.6、类似快手的竖屏视频列表页面：YLLittleVideoListController

```objective-c
YLLittleVideoListController *list = [[YLLittleVideoListController alloc] init];
// 小视频评论展示类型(默认不显示)
list.commentType = YLLittleCommentTypeReadWrite;
// 小视频播放器填充类型(默认resizeAspect)
list.playerContentMode = YLLittlePlayerContentModeResizeAspectFill;
// 是否显示分享按钮
list.showShare = YES;
// 小视频点赞等按钮位于底部（默认右边）
list.bottomPanel = YES;
// 小视频视频状态及广告加载等回调信息(详见3.7)
list.delegate = self;
list.view.frame = CGRectMake(0, y, self.view.width, height);
[self.view addSubview:list.view];
[self addChildViewController:list];
```

#### 3.7、小视频视频状态及广告加载等回调信息：YLLittleVideoDelegate

```objective-c
// 首个视频开始播放(isAD: 是否是广告)
- (void)firstPlayerStartWithVideoID:(NSString *)videoID isAD:(BOOL)isAD {
}
// 视频开始播放
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
```

## 四、支持穿山甲广告

目前穿山甲广告仅支持投放于小视频页面

- 首先通过商务沟通配置好广告位等信息

- 根据穿山甲SDK文档完成项目配置，并设置正确的APPID，小视频中即会出现对应的广告