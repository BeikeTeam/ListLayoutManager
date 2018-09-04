//
//  ViewModel.m
//  ListLayoutManager
//
//  Created by 张晓珊 on 2018/9/4.
//  Copyright © 2018年 张晓珊. All rights reserved.
//

#import "ViewModel.h"
#import "CustomHeaderView.h"
#import "CustomLabelCell.h"
#import "CustomImageCell.h"
#import "CustomButtonCell.h"
#import "SHListLayoutManagerProtocol.h"

@interface ViewModel ()

@property (nullable, nonatomic, strong) NSMutableArray *array;

@end

@implementation ViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.array = [NSMutableArray array];
    }
    return self;
}

- (void)loadData {
    [self.array addObject:[self createFirstTypeData]];
    [self.array addObject:[self createSecondTypeData]];
    [self.array addObject:[self createThirdTypeData]];
}

- (NSArray<SHListLayoutSectionModelable, SHTableViewMeasureDelegate> *)sections {
    return self.array.count > 0 ? self.array.copy : @[];
}

- (CustomSectionModel *)createFirstTypeData {
    // 创建 cellModels
    NSMutableArray<CustomLabelCellModel *> *cellModels = [NSMutableArray<CustomLabelCellModel *> array];
    for (int i = 0; i < 5; i++) {
        CustomLabelCellModel *cellModel = [CustomLabelCellModel new];
        cellModel.houseId = [NSString stringWithFormat:@"%d", i];
        cellModel.region = [NSString stringWithFormat:@"%d号线", i];
        cellModel.title = [NSString stringWithFormat:@"融泽嘉园%d号楼", i];
        cellModel.count = [NSString stringWithFormat:@"%d室", i];
        [cellModels addObject:cellModel];
    }
    
    // 创建 headerModel
    CustomHeaderViewModel *headerViewModel = [CustomHeaderViewModel new];
    headerViewModel.title = @"第一组";
    headerViewModel.isHiddenButton = NO;
    headerViewModel.isShowAllCustomLabel = NO;
    
    // 创建 sectionModel
    CustomSectionModel *sectionModel = [CustomSectionModel new];
    sectionModel.header = headerViewModel;
    sectionModel.items = cellModels.copy;
    sectionModel.heightForHeader = 30;
    
    return sectionModel;
}

- (CustomSectionModel *)createSecondTypeData {
    
    // 创建 cellModels
    NSMutableArray<CustomImageCellModel *> *cellModels = [NSMutableArray<CustomImageCellModel *> array];
    for (int i = 5; i < 10; i++) {
        CustomImageCellModel *cellModel = [CustomImageCellModel new];
        cellModel.houseId = [NSString stringWithFormat:@"%d", i];
        cellModel.iconName = [NSString stringWithFormat:@"%d", i];
        cellModel.title = [NSString stringWithFormat:@"融泽嘉园%d号楼", i];
        cellModel.content = [NSString stringWithFormat:@"这是一条关于融泽嘉园%d号楼的简介。不要在意这些细节，我是来凑字数的。不要在意这些细节，我是来凑字数的。不要在意这些细节，我是来凑字数的。不要在意这些细节，我是来凑字数的。", i];
        [cellModels addObject:cellModel];
    }
    
    // 创建 headerModel
    CustomHeaderViewModel *headerViewModel = [CustomHeaderViewModel new];
    headerViewModel.title = @"第二组";
    headerViewModel.isHiddenButton = YES;
    
    // 创建 sectionModel
    CustomSectionModel *sectionModel = [CustomSectionModel new];
    sectionModel.header = headerViewModel;
    sectionModel.items = cellModels.copy;
    sectionModel.heightForHeader = 40;
    
    return sectionModel;
}

- (CustomSectionModel *)createThirdTypeData {
    
    // 创建 cellModels
    NSMutableArray<CustomButtonCellModel *> *cellModels = [NSMutableArray<CustomButtonCellModel *> array];
    for (int i = 10; i < 15; i++) {
        CustomButtonCellModel *cellModel = [CustomButtonCellModel new];
        cellModel.houseId = [NSString stringWithFormat:@"%d", i];
        cellModel.title = [NSString stringWithFormat:@"融泽嘉园%d号楼", i];
        cellModel.content = [NSString stringWithFormat:@"这是一条关于融泽嘉园%d号楼的简介。不要在意这些细节，我是来凑字数的。不要在意这些细节，我是来凑字数的。不要在意这些细节，我是来凑字数的。不要在意这些细节，我是来凑字数的。", i];
        [cellModels addObject:cellModel];
    }
    
    // 创建 headerModel
    CustomHeaderViewModel *headerViewModel = [CustomHeaderViewModel new];
    headerViewModel.title = @"第三组";
    headerViewModel.isHiddenButton = YES;
    
    // 创建 sectionModel
    CustomSectionModel *sectionModel = [CustomSectionModel new];
    sectionModel.header = headerViewModel;
    sectionModel.items = cellModels.copy;
    sectionModel.heightForHeader = 50;
    
    return sectionModel;
}

@end

@implementation CustomSectionModel

- (instancetype)init {
    self = [super init];
    if (self) {
        self.identifierForSectionHeader = NSStringFromClass(CustomHeaderView.class);
        self.heightForHeader = 10;
    }
    return self;
}

- (NSInteger)numberOfItemsInSection {
    if ([self.header isKindOfClass:CustomHeaderViewModel.class]) {
        CustomHeaderViewModel *header = (CustomHeaderViewModel *)self.header;
        if (!header.isHiddenButton) {
            return header.isShowAllCustomLabel ? self.items.count : 3;
        }
    }
    return self.items.count;
}

@end

