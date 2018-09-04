//
//  HouseDetailsViewController.m
//  ListLayoutManager
//
//  Created by 张晓珊 on 2018/9/2.
//  Copyright © 2018年 张晓珊. All rights reserved.
//

#import "HouseDetailsViewController.h"

@interface HouseDetailsViewController ()

@property (nonatomic, strong) UILabel *label;

@end

@implementation HouseDetailsViewController

- (void)loadView {
    [super loadView];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.label];
    
    NSLayoutConstraint *labelCenterX = [self.label.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor];
    NSLayoutConstraint *labelCenterY = [self.label.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor];
    
    [NSLayoutConstraint activateConstraints:@[labelCenterX, labelCenterY]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UILabel *)label {
    if (!_label) {
        UILabel *label = [UILabel new];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont boldSystemFontOfSize:25];
        label.textColor = [UIColor blackColor];
        label.translatesAutoresizingMaskIntoConstraints = NO;
        label.text = [NSString stringWithFormat:@"展示ID为:%@的详细信息", self.houseId];
        _label = label;
    }
    return _label;
}

@end
