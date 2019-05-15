//
//  ChannelItemCell.m
//  YLDataSDKDemoOC
//
//  Created by yanpei on 2019/1/16.
//  Copyright © 2019 yilan. All rights reserved.
//

#import "ChannelItemCell.h"
#import <YLDataSDK/YLDataSDK-Swift.h>

@implementation ChannelItemCell

UILabel *titleLabel;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        titleLabel = [[UILabel alloc] init];
        titleLabel.frame = self.bounds;
        titleLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        titleLabel.font = [UIFont systemFontOfSize:14];
        titleLabel.textColor = [UIColor whiteColor];
        [self addSubview:titleLabel];
    }
    return self;
}

- (void)reloadData: (YLChannelModel*)data
{
    titleLabel.text = data.name;
}



@end
