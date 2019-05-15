//
//  ChannelItemCell.h
//  YLDataSDKDemoOC
//
//  Created by yanpei on 2019/1/16.
//  Copyright © 2019 yilan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <YLDataSDK/YLDataSDK-Swift.h>

NS_ASSUME_NONNULL_BEGIN

@interface ChannelItemCell : UICollectionViewCell

- (void)reloadData: (YLChannelModel*)data;

@end

NS_ASSUME_NONNULL_END
