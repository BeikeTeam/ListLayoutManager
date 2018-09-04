//
//  CustomLabelCell.m
//  ListLayoutManager
//
//  Created by 张晓珊 on 2018/8/19.
//  Copyright © 2018年 张晓珊. All rights reserved.
//

#import "CustomLabelCell.h"

@implementation CustomLabelCellModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.identifier = NSStringFromClass(CustomLabelCell.class);
        self.viewSize = CGSizeMake(0, 50);
    }
    return self;
}

@end

@implementation CustomLabelCell

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
    [self.contentView addSubview:self.leftLabel];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.rightLabel];
    
    NSLayoutConstraint *leftLabelTop = [self.leftLabel.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:10];
    NSLayoutConstraint *leftLabelLeading = [self.leftLabel.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:20];
    NSLayoutConstraint *leftLabelBottom = [self.leftLabel.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor constant:-10];
    NSLayoutConstraint *leftLabelWidth = [self.leftLabel.widthAnchor constraintEqualToConstant:70];
    
    NSLayoutConstraint *titleLabelTop = [self.titleLabel.topAnchor constraintEqualToAnchor:self.contentView.topAnchor];
    NSLayoutConstraint *titleLabelLeading = [self.titleLabel.leadingAnchor constraintEqualToAnchor:self.leftLabel.trailingAnchor constant:20];
    NSLayoutConstraint *titleLabelBottom = [self.titleLabel.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor];
    NSLayoutConstraint *titleLabelTrailing = [self.titleLabel.trailingAnchor constraintEqualToAnchor:self.rightLabel.leadingAnchor constant:20];
    
    NSLayoutConstraint *rightLabelTop = [self.rightLabel.topAnchor constraintEqualToAnchor:self.contentView.topAnchor];
    NSLayoutConstraint *rightLabelBottom = [self.rightLabel.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor];
    NSLayoutConstraint *rightLabelTrailing = [self.rightLabel.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:-20];
    
    [NSLayoutConstraint activateConstraints:@[leftLabelTop, leftLabelLeading, leftLabelBottom, leftLabelWidth, titleLabelTop, titleLabelLeading, titleLabelBottom, titleLabelTrailing, rightLabelTop, rightLabelBottom, rightLabelTrailing]];
    
}

- (void)configWithModel:(id)model {
    if ([model isKindOfClass:CustomLabelCellModel.class]) {
        CustomLabelCellModel *cellModel = model;
        self.leftLabel.text = cellModel.region;
        self.titleLabel.text = cellModel.title;
        self.rightLabel.text = cellModel.count;
    }
}


#pragma  mark - 懒加载

- (UILabel *)leftLabel {
    if (!_leftLabel) {
        UILabel *label = [UILabel new];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont boldSystemFontOfSize:15];
        label.textColor = [UIColor whiteColor];
        label.backgroundColor = [UIColor lightGrayColor];
        label.translatesAutoresizingMaskIntoConstraints = NO;
        label.textAlignment = NSTextAlignmentCenter;
        _leftLabel = label;
    }
    return _leftLabel;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        UILabel *label = [UILabel new];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont systemFontOfSize:17];
        label.textColor = [UIColor blackColor];
        label.translatesAutoresizingMaskIntoConstraints = NO;
        _titleLabel = label;
    }
    return _titleLabel;
}

- (UILabel *)rightLabel {
    if (!_rightLabel) {
        UILabel *label = [UILabel new];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont systemFontOfSize:17];
        label.textColor = [UIColor darkGrayColor];
        label.translatesAutoresizingMaskIntoConstraints = NO;
        [label setContentHuggingPriority:251 forAxis:UILayoutConstraintAxisHorizontal];
        _rightLabel = label;
    }
    return _rightLabel;
}

@end
