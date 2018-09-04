//
//  CustomLabelCell.h
//  ListLayoutManager
//
//  Created by 张晓珊 on 2018/8/19.
//  Copyright © 2018年 张晓珊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SHListLayoutManagerProtocol.h"

@interface CustomLabelCellModel : NSObject <SHListLayoutCellModelable>

@property (nonnull, nonatomic, copy) NSString *identifier;
@property (nonatomic, assign) CGSize viewSize;
@property (nonatomic, copy) NSString *targetUrl;

@property (nonatomic, copy) NSString *houseId;
@property (nonatomic, copy) NSString *region;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *count;

@end


@interface CustomLabelCell : UITableViewCell <SHListLayoutViewable>

@property (nonatomic, strong) UILabel *leftLabel;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *rightLabel;

- (void)configWithModel:(id)model;

@end
