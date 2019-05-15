//
//  VideoInfoCell.m
//  YLDataSDKDemoOC
//
//  Created by yanpei on 2019/1/16.
//  Copyright © 2019 yilan. All rights reserved.
//

#import "VideoInfoCell.h"

@interface VideoInfoCell ()

@property (weak, nonatomic) IBOutlet UIImageView *cover;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *duration;
@property (weak, nonatomic) IBOutlet UILabel *cpName;
@property (weak, nonatomic) IBOutlet UIImageView *cpHead;


@end

@implementation VideoInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (void)reloadData:(YLFeedModel*)data
{
    self.title.text = data.title;
    self.cpName.text = data.provider.name;
    NSString *min = [NSString stringWithFormat:@"%02ld", data.duration];
    NSString *sec = [NSString stringWithFormat:@"%02ld", data.duration % 60];
    self.duration.text = [NSString stringWithFormat:@"%@:%@", min, sec];
    
}

@end
