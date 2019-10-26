//
//  UIView+YLEx.h
//  YLUISDK
//
//  Created by leihaojie on 2019/7/17.
//  Copyright © 2019 leihaojie. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (YLExtension)

@property (assign, nonatomic) CGFloat x;
@property (assign, nonatomic) CGFloat y;
@property (assign, nonatomic) CGFloat width;
@property (assign, nonatomic) CGFloat height;
@property (assign, nonatomic) CGSize size;
@property (assign, nonatomic) CGPoint origin;
@property (assign, nonatomic) CGFloat right;
@property (assign, nonatomic) CGFloat bottom;

@end

NS_ASSUME_NONNULL_END
