//
//  CustomImageCell.h
//  ListLayoutManager
//
//  Created by 张晓珊 on 2018/8/19.
//  Copyright © 2018年 张晓珊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SHListLayoutManagerProtocol.h"

@interface CustomImageCellModel : NSObject <SHListLayoutCellModelable>

@property (nonnull, nonatomic, copy) NSString *identifier;
@property (nonatomic, assign) CGSize viewSize;
@property (nonatomic, copy) NSString *targetUrl;

@property (nonatomic, copy) NSString *houseId;
@property (nonatomic, copy) NSString *iconName;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *content;

@end

@class CustomImageCellModel;

@interface CustomImageCell : UITableViewCell <SHListLayoutViewable>

@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;

- (void)configWithModel:(id)model;

@end
