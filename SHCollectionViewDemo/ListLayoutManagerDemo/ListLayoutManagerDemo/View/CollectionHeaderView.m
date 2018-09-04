//
//  CollectionHeaderView.m
//  ListLayoutManagerDemo
//
//  Created by 张晓珊 on 2018/8/16.
//  Copyright © 2018年 张晓珊. All rights reserved.
//

#import "CollectionHeaderView.h"

@implementation CollectionHeaderViewModel


@end

@interface CollectionHeaderView ()<SHListLayoutViewable>

@property (nonatomic, strong) UILabel *titleLabel;

@end


@implementation CollectionHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI {
    [self addSubview:self.titleLabel];
    NSDictionary *views = @{@"label" : self.titleLabel};
    NSArray *constraintsH = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[label]-0-|" options:0 metrics:nil views:views];
    NSArray *constraintsV = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[label]-0-|" options:0 metrics:nil views:views];
    NSMutableArray *constraints = [NSMutableArray arrayWithArray:constraintsH];
    [constraints addObjectsFromArray:constraintsV];
    [NSLayoutConstraint activateConstraints:constraints];
}


#pragma mark - SHListLayoutViewable

- (void)configWithModel:(id)model {
    if ([model isKindOfClass:CollectionHeaderViewModel.class]) {
        CollectionHeaderViewModel *viewModel = model;
        self.titleLabel.text = viewModel.title;
    }
}


#pragma mark - 懒加载

- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        UILabel *label = [UILabel new];
        label.translatesAutoresizingMaskIntoConstraints = NO;
        label.backgroundColor = [UIColor whiteColor];
        label.textColor = [UIColor darkGrayColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:20];
        _titleLabel = label;
    }
    return _titleLabel;
}

@end
