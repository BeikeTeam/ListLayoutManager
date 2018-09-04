//
//  ViewModel.m
//  ListLayoutManagerDemo
//
//  Created by 张晓珊 on 2018/8/16.
//  Copyright © 2018年 张晓珊. All rights reserved.
//

#import "ViewModel.h"
#import "CollectionHeaderView.h"
#import "CollectionViewCell.h"

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
    
    
    CollectionHeaderViewModel *headerViewModel = [CollectionHeaderViewModel new];
    headerViewModel.title = @"第一组";
    
    NSMutableArray<SHListLayoutCellModelable> *items1 = [NSMutableArray<SHListLayoutCellModelable> array];
    for (int i = 0; i < 15; i++) {
        CollectionViewCellModel * cellModel = [CollectionViewCellModel new];
        cellModel.number = [NSString stringWithFormat:@"一/%d", i];
        [items1 addObject:cellModel];
    }
    
    SectionModel *sectionModel1 = [SectionModel new];
    sectionModel1.header = headerViewModel;
    sectionModel1.identifierForSectionHeader = NSStringFromClass(CollectionHeaderView.class);
    sectionModel1.items = items1;
    sectionModel1.sizeForHeader = CGSizeMake([UIScreen mainScreen].bounds.size.width, 50);
    sectionModel1.insetForSection = UIEdgeInsetsMake(0, 20, 0, 20);
    
    
    SectionModel *sectionModel2 = [SectionModel new];
    
    CollectionHeaderViewModel *headerViewModel3 = [CollectionHeaderViewModel new];
    headerViewModel3.title = @"第三组";
    
    NSMutableArray<SHListLayoutCellModelable> *items3 = [NSMutableArray<SHListLayoutCellModelable> array];
    for (int i = 0; i < 9; i++) {
        CollectionViewCellModel * cellModel = [CollectionViewCellModel new];
        cellModel.number = [NSString stringWithFormat:@"三/%d", i];
        [items3 addObject:cellModel];
    }
    
    SectionModel *sectionModel3 = [SectionModel new];
    sectionModel3.header = headerViewModel3;
    sectionModel3.identifierForSectionHeader = NSStringFromClass(CollectionHeaderView.class);
    sectionModel3.items = items3;
    sectionModel3.sizeForHeader = CGSizeMake([UIScreen mainScreen].bounds.size.width, 50);
    sectionModel3.insetForSection = UIEdgeInsetsMake(0, 20, 0, 20);
    
    [self.array addObject:sectionModel1];
    [self.array addObject:sectionModel2];
    [self.array addObject:sectionModel3];
}

- (NSArray<SHListLayoutSectionModelable,SHCollectionViewMeasureDelegate> *)sections {
    return self.array.count > 0 ? self.array.copy : @[];
}

@end


@implementation SectionModel



@end
