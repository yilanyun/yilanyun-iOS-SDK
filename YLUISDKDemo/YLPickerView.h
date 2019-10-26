//
//  YLPickerView.h
//  YLUISDKDemo
//
//  Created by leihaojie on 2019/9/9.
//  Copyright © 2019 leihaojie. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol YLPickerViewDelegate <NSObject>

- (void)selectedIndex:(NSInteger)index;

@end

@interface YLPickerView : UIView

@property (nonatomic, weak) id<YLPickerViewDelegate> delegate;

- (instancetype)initWithTitles:(NSArray<NSString *> *)titles;

- (void)show;

- (void)hide;

@end

NS_ASSUME_NONNULL_END
