//
//  CustomHeaderView.h
//  ListLayoutManager
//
//  Created by 张晓珊 on 2018/8/23.
//  Copyright © 2018年 张晓珊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SHListLayoutManagerProtocol.h"

@interface CustomHeaderViewModel : NSObject <SHListLayoutHeaderModelable>

@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) BOOL isHiddenButton;
@property (nonatomic, assign) BOOL isShowAllCustomLabel;

@end

@interface CustomHeaderView : UITableViewHeaderFooterView <SHListLayoutViewable>

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, copy) void (^buttonClickBlock)(UIButton *sinder);

- (void)configWithModel:(id)model;

@end
