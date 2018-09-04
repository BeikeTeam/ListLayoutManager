//
//  CollectionViewCell.m
//  ListLayoutManagerDemo
//
//  Created by 张晓珊 on 2018/8/16.
//  Copyright © 2018年 张晓珊. All rights reserved.
//

#import "CollectionViewCell.h"

@implementation CollectionViewCellModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.identifier = NSStringFromClass(CollectionViewCell.class);
        self.viewSize = CGSizeMake(50, 30);
    }
    return self;
}

@end


@interface CollectionViewCell () <SHListLayoutViewable>

@property (nonatomic, strong) UILabel *label;

@end

@implementation CollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI {
    [self.contentView addSubview:self.label];
    NSDictionary *views = @{@"label" : self.label};
    NSArray *constraintsH = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[label]-0-|" options:0 metrics:nil views:views];
    NSArray *constraintsV = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[label]-0-|" options:0 metrics:nil views:views];
    NSMutableArray *constraints = [NSMutableArray arrayWithArray:constraintsH];
    [constraints addObjectsFromArray:constraintsV];
    [NSLayoutConstraint activateConstraints:constraints];
}

- (void)configWithModel:(id)model {
    if ([model isKindOfClass:CollectionViewCellModel.class]) {
        CollectionViewCellModel *cellModel = model;
        self.label.text = cellModel.number;
    }
}


#pragma mark - 懒加载

- (UILabel *)label {
    
    if (!_label) {
        UILabel *label = [UILabel new];
        label.translatesAutoresizingMaskIntoConstraints = NO;
        label.backgroundColor = [UIColor lightGrayColor];
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        _label = label;
    }
    return _label;
}

@end
