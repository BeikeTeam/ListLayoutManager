//
//  CustomHeaderView.m
//  ListLayoutManager
//
//  Created by 张晓珊 on 2018/8/23.
//  Copyright © 2018年 张晓珊. All rights reserved.
//

#import "CustomHeaderView.h"

@implementation CustomHeaderViewModel


@end

@interface CustomHeaderView ()

@property (nonatomic, strong) CustomHeaderViewModel *model;

@end

@implementation CustomHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI {
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.button];
    
    NSLayoutConstraint *titleLabelCenterY = [self.titleLabel.centerYAnchor constraintEqualToAnchor:self.contentView.centerYAnchor];
    NSLayoutConstraint *titleLabelLeading = [self.titleLabel.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:20];
    
    NSLayoutConstraint *buttonCenterY = [self.button.centerYAnchor constraintEqualToAnchor:self.contentView.centerYAnchor];
    NSLayoutConstraint *buttonTrailing = [self.button.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:-20];
    
    [NSLayoutConstraint activateConstraints:@[titleLabelCenterY, titleLabelLeading, buttonCenterY, buttonTrailing]];
}

- (void)configWithModel:(id)model {
    if ([model isKindOfClass:CustomHeaderViewModel.class]) {
        CustomHeaderViewModel *headerModel = model;
        self.model = headerModel;
        self.button.hidden = headerModel.isHiddenButton;
        self.titleLabel.text = headerModel.title;
        self.button.selected = headerModel.isShowAllCustomLabel;
    }
}


#pragma mark - buttonClick

- (void)buttonClick:(UIButton *)sinder {
    sinder.selected = !sinder.isSelected;
    self.model.isShowAllCustomLabel = sinder.isSelected;
    if (self.buttonClickBlock != nil) {
        self.buttonClickBlock(sinder);
    }
}


#pragma mark - 懒加载

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        UILabel *label = [UILabel new];
        label.backgroundColor = [UIColor whiteColor];
        label.font = [UIFont boldSystemFontOfSize:20];
        label.textColor = [UIColor blackColor];
        label.translatesAutoresizingMaskIntoConstraints = NO;
        _titleLabel = label;
    }
    return _titleLabel;
}

- (UIButton *)button {
    if (!_button) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.translatesAutoresizingMaskIntoConstraints = NO;
        [button setTitle:@"展开" forState:UIControlStateNormal];
        [button setTitle:@"收起" forState:UIControlStateSelected];
        [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        _button = button;
    }
    return _button;
}

@end
