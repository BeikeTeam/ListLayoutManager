//
//  CustomButtonCell.m
//  ListLayoutManager
//
//  Created by 张晓珊 on 2018/8/19.
//  Copyright © 2018年 张晓珊. All rights reserved.
//

#import "CustomButtonCell.h"

@implementation CustomButtonCellModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.identifier = NSStringFromClass(CustomButtonCell.class);
        self.viewSize = CGSizeMake(0, 100);
    }
    return self;
}


@end

@interface CustomButtonCell ()

@property (nonatomic, strong) CustomButtonCellModel *model;

@end

@implementation CustomButtonCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI {
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.contentLabel];
    [self.contentView addSubview:self.button];
    
    NSLayoutConstraint *titleLabelTop = [self.titleLabel.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:20];
    NSLayoutConstraint *titleLabelLeading = [self.titleLabel.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:20];
    NSLayoutConstraint *titleLabelTrailling = [self.titleLabel.trailingAnchor constraintEqualToAnchor:self.button.leadingAnchor constant:-20];
    NSLayoutConstraint *titleLabelHeight = [self.titleLabel.heightAnchor constraintEqualToConstant:20];
    
    NSLayoutConstraint *buttonCenterY = [self.button.centerYAnchor constraintEqualToAnchor:self.titleLabel.centerYAnchor];
    NSLayoutConstraint *buttonTrailling = [self.button.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:-20];
    NSLayoutConstraint *buttonWidth = [self.button.widthAnchor constraintEqualToConstant:48];
    NSLayoutConstraint *buttonHeight = [self.button.heightAnchor constraintEqualToConstant:48];
    
    NSLayoutConstraint *contentLabelTop = [self.contentLabel.topAnchor constraintEqualToAnchor:self.titleLabel.bottomAnchor constant:20];
    NSLayoutConstraint *contentLabelLeading = [self.contentLabel.leadingAnchor constraintEqualToAnchor:self.titleLabel.leadingAnchor];
    NSLayoutConstraint *contentLabelTrailling = [self.contentLabel.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:-20];
    NSLayoutConstraint *contentLabelBottom = [self.contentLabel.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor constant:-20];
    
    [NSLayoutConstraint activateConstraints:@[titleLabelTop, titleLabelLeading, titleLabelTrailling, titleLabelHeight, buttonCenterY, buttonTrailling, buttonWidth, buttonHeight, contentLabelTop, contentLabelLeading, contentLabelTrailling, contentLabelBottom]];
}

- (void)configWithModel:(CustomButtonCellModel *)model {
    if ([model isKindOfClass:CustomButtonCellModel.class]) {
        CustomButtonCellModel *cellModel = model;
        self.model = cellModel;
        self.titleLabel.text = cellModel.title;
        self.contentLabel.text = cellModel.content;
        self.button.selected = cellModel.isShowAll;
    }
}

#pragma mark - buttonClick

- (void)buttonClick:(UIButton *)sinder {
    sinder.selected = !sinder.isSelected;
    self.model.isShowAll = sinder.isSelected;
    self.model.viewSize = CGSizeMake(0, self.model.isShowAll ? 150 : 100);
    if (self.buttonClickBlock != nil) {
        self.buttonClickBlock(sinder);
    }
}


#pragma mark - 懒加载

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        UILabel *label = [UILabel new];
        label.backgroundColor = [UIColor whiteColor];
        label.font = [UIFont boldSystemFontOfSize:17];
        label.textColor = [UIColor blackColor];
        label.translatesAutoresizingMaskIntoConstraints = NO;
        _titleLabel = label;
    }
    return _titleLabel;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        UILabel *label = [UILabel new];
        label.numberOfLines = 0;
        label.backgroundColor = [UIColor whiteColor];
        label.font = [UIFont boldSystemFontOfSize:15];
        label.textColor = [UIColor darkGrayColor];
        label.translatesAutoresizingMaskIntoConstraints = NO;
        _contentLabel = label;
    }
    return _contentLabel;
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
