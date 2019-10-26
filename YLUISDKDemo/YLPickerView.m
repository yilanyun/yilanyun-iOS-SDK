//
//  YLPickerView.m
//  YLUISDKDemo
//
//  Created by leihaojie on 2019/9/9.
//  Copyright © 2019 leihaojie. All rights reserved.
//

#import "YLPickerView.h"

@interface YLPickerView ()<UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIPickerView *picker;
@property (nonatomic, strong) UIToolbar *toolBar;
@property (nonatomic, strong) NSArray<NSString *> *titles;
@property (nonatomic, assign) BOOL hiding;

@end

@implementation YLPickerView

- (instancetype)initWithTitles:(NSArray<NSString *> *)titles
{
    self = [super init];
    if (self) {
        self.frame = UIApplication.sharedApplication.windows.lastObject.bounds;
        
        self.titles = titles;
        [self addSubview:self.contentView];
        [self.contentView addSubview:self.picker];
        [self.contentView addSubview:self.toolBar];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

#pragma mark - public
- (void)show
{
    [self.contentView setHidden:NO];
    self.contentView.y = self.height;
    [UIApplication.sharedApplication.windows.lastObject addSubview:self];
    [UIView animateWithDuration:0.3 animations:^{
        self.contentView.bottom = self.height;
    }];
}

- (void)hide
{
    if (self.hiding) {
        return;
    }
    self.hiding = YES;
    [UIView animateWithDuration:0.3 animations:^{
        self.contentView.y = self.height;
    } completion:^(BOOL finished) {
        [self.contentView setHidden:YES];
        [self removeFromSuperview];
        self.hiding = NO;
    }];
}

#pragma mark - subviews
- (UIView *)contentView
{
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, 300)];
    }
    return _contentView;
}

- (UIPickerView *)picker
{
    if (!_picker) {
        _picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, self.toolBar.bottom, self.contentView.width, self.contentView.height - self.toolBar.bottom)];
        if (@available(iOS 13.0, *)) {
            _picker.backgroundColor = [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
                if (traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
                    return UIColor.blackColor;
                } else {
                    return UIColor.whiteColor;
                }
            }];
        } else {
            _picker.backgroundColor = UIColor.whiteColor;
        }
        _picker.delegate = self;
        _picker.dataSource = self;
    }
    return _picker;
}

- (UIToolbar *)toolBar
{
    if (!_toolBar) {
        _toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.contentView.width, 45)];
        UIBarButtonItem *space1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        space1.width = 10;
        UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelAction)];
        UIBarButtonItem *space2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneAction)];
        UIBarButtonItem *space3 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        space3.width = 10;
        _toolBar.items = @[space1, cancelButton, space2, doneButton, space3];
    }
    return _toolBar;
}

#pragma mark - actions
- (void)tapAction
{
    [self hide];
}

- (void)cancelAction
{
    [self hide];
}

- (void)doneAction
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectedIndex:)]) {
        NSInteger index = [self.picker selectedRowInComponent:0];
        if (index < 0) {
            index = 0;
        }
        [self.delegate selectedIndex:index];
    }
    [self hide];
}

#pragma mark - UIPickerViewDelegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.titles.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return self.titles[row];
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 40;
}

@end
