//
//  CustomImageCell.m
//  ListLayoutManager
//
//  Created by 张晓珊 on 2018/8/19.
//  Copyright © 2018年 张晓珊. All rights reserved.
//

#import "CustomImageCell.h"

@implementation CustomImageCellModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.identifier = NSStringFromClass(CustomImageCell.class);
        self.viewSize = CGSizeMake(0, 140);
    }
    return self;
}

@end

@interface CustomImageCell ()

@end

@implementation CustomImageCell

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
    [self.contentView addSubview:self.iconView];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.contentLabel];
    
    NSLayoutConstraint *iconViewTop = [self.iconView.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:20];
    NSLayoutConstraint *iconViewLeading = [self.iconView.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:20];
    NSLayoutConstraint *iconViewBottom = [self.iconView.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor constant:-20];
    NSLayoutConstraint *iconViewWidth = [self.iconView.widthAnchor constraintEqualToConstant:120];
    
    NSLayoutConstraint *titleLabelTop = [self.titleLabel.topAnchor constraintEqualToAnchor:self.iconView.topAnchor];
    NSLayoutConstraint *titleLabelLeading = [self.titleLabel.leadingAnchor constraintEqualToAnchor:self.iconView.trailingAnchor constant:20];
    NSLayoutConstraint *titleLabelTrailling = [self.titleLabel.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:-20];
    NSLayoutConstraint *titleLabelHeight = [self.titleLabel.heightAnchor constraintEqualToConstant:20];
    
    NSLayoutConstraint *contentLabelTop = [self.contentLabel.topAnchor constraintEqualToAnchor:self.titleLabel.bottomAnchor constant:20];
    NSLayoutConstraint *contentLabelLeading = [self.contentLabel.leadingAnchor constraintEqualToAnchor:self.titleLabel.leadingAnchor];
    NSLayoutConstraint *contentLabelTrailling = [self.contentLabel.trailingAnchor constraintEqualToAnchor:self.titleLabel.trailingAnchor];
    NSLayoutConstraint *contentLabelHeight = [self.contentLabel.heightAnchor constraintLessThanOrEqualToConstant:60];
    
    [NSLayoutConstraint activateConstraints:@[iconViewTop, iconViewLeading, iconViewBottom, iconViewWidth, titleLabelTop, titleLabelLeading, titleLabelTrailling, titleLabelHeight, contentLabelTop, contentLabelLeading, contentLabelTrailling, contentLabelHeight]];
}


- (void)configWithModel:(id)model {
    if ([model isKindOfClass:CustomImageCellModel.class]) {
        CustomImageCellModel *cellModel = model;
        self.imageView.image = [UIImage imageNamed:cellModel.iconName];
        self.titleLabel.text = cellModel.title;
        self.contentLabel.text = cellModel.content;
    }
}


#pragma mark - 懒加载
- (UIImageView *)iconView {
    if (!_iconView) {
        UIImageView *imageView = [UIImageView new];
        imageView.backgroundColor = [UIColor lightGrayColor];
        imageView.translatesAutoresizingMaskIntoConstraints = NO;
        _iconView = imageView;
    }
    return _iconView;
}

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

@end
