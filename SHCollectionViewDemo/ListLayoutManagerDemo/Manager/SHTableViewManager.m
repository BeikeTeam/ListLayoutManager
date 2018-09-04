//
//  SHTableViewManager.m
//  AFNetworking
//
//  Created by 张晓珊 on 2018/7/12.
//

#import "SHTableViewManager.h"

@interface SHTableViewManager()

@end

@implementation SHTableViewManager


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    if (self.listModel) {
        return self.listModel.sections.count;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section >= self.listModel.sections.count) {
        return 0;
    }
    
    id<SHListLayoutSectionModelable> sectionModel = self.listModel.sections[section];
    if (sectionModel && [sectionModel respondsToSelector:@selector(numberOfItemsInSection)]) {
        return [sectionModel numberOfItemsInSection];
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section >= self.listModel.sections.count) {
        return [UITableViewCell new];
    }
    
    id<SHListLayoutSectionModelable> sectionModel = self.listModel.sections[indexPath.section];
    
    if ([sectionModel respondsToSelector:@selector(identifierForItemAtIndex:)]) {
        
        NSString *identifier = [sectionModel identifierForItemAtIndex:indexPath.row];
        
        if (identifier && identifier.length > 0) {
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: identifier forIndexPath:indexPath];
            if ([self.delegate respondsToSelector:@selector(configTableViewCell:)]) {
                [self.delegate configTableViewCell:cell];
            }
            return cell;
        }
    }
    
    return [UITableViewCell new];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (section >= self.listModel.sections.count) {
        return [UIView new];
    }
    
    id<SHListLayoutSectionModelable> sectionModel = self.listModel.sections[section];
    if (sectionModel.identifierForSectionHeader && sectionModel.identifierForSectionHeader.length > 0) {
        UITableViewHeaderFooterView * headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:sectionModel.identifierForSectionHeader];
        if ([self.delegate respondsToSelector:@selector(configTableViewHeaderFooterView:)]) {
            [self.delegate configTableViewHeaderFooterView:headerView];
        }
        return headerView;
    }
    
    return [UIView new];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section >= self.listModel.sections.count) {
        return [UIView new];
    }
    
    id<SHListLayoutSectionModelable> sectionModel = self.listModel.sections[section];
    if (sectionModel.identifierForSectionFooter && sectionModel.identifierForSectionFooter.length > 0) {
        UITableViewHeaderFooterView * footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:sectionModel.identifierForSectionFooter];
        if ([self.delegate respondsToSelector:@selector(configTableViewHeaderFooterView:)]) {
            [self.delegate configTableViewHeaderFooterView:footerView];
        }
        return footerView;
    }
    
    return [UIView new];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section >= self.listModel.sections.count) {
        return 0.f;
    }
    
    id<SHTableViewMeasureDelegate> sectionModel = self.listModel.sections[section];
    if (sectionModel) {
        return sectionModel.heightForHeader;
    }
    
    return 0.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section >= self.listModel.sections.count) {
        return 0.f;
    }
    
    id<SHTableViewMeasureDelegate> sectionModel = self.listModel.sections[indexPath.section];
    if (sectionModel && [sectionModel respondsToSelector:@selector(heightForItemAtIndex:)]) {
        return [sectionModel heightForItemAtIndex:indexPath.row];
    }
    
    return 0.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section >= self.listModel.sections.count) {
        return 0.f;
    }
    
    id<SHTableViewMeasureDelegate> sectionModel = self.listModel.sections[section];
    if (sectionModel) {
        return sectionModel.heightForFooter;
    }
    
    return 0.f;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    if (section >= self.listModel.sections.count) {
        return;
    }
    
    id<SHListLayoutSectionModelable> sectionModel = self.listModel.sections[section];
    if ([view conformsToProtocol:@protocol(SHListLayoutViewable)] && [view respondsToSelector:@selector(configWithModel:)]) {
        [((id<SHListLayoutViewable>)view) configWithModel:sectionModel.header];
    }
}

- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section {
    
    if ([view conformsToProtocol:@protocol(SHListLayoutViewable)] && [view respondsToSelector:@selector(endDisplaying)]) {
        [((id<SHListLayoutViewable>)view) endDisplaying];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section >= self.listModel.sections.count) {
        return;
    }
    
    id<SHListLayoutSectionModelable> sectionModel = self.listModel.sections[indexPath.section];
    
    if (indexPath.row >= sectionModel.items.count) {
        return;
    }
    
    id<SHListLayoutCellModelable> cellModel = sectionModel.items[indexPath.row];
    if ([cell conformsToProtocol:@protocol(SHListLayoutViewable)] && [cell respondsToSelector:@selector(configWithModel:)]) {
        [((id<SHListLayoutViewable>)cell) configWithModel:cellModel];
    }
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([cell conformsToProtocol:@protocol(SHListLayoutViewable)] && [cell respondsToSelector:@selector(endDisplaying)]) {
        [((id<SHListLayoutViewable>)cell) endDisplaying];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectWithTableView:atIndexPath:)]) {
        [self.delegate didSelectWithTableView:tableView atIndexPath:indexPath];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (self.delegate && [self.delegate respondsToSelector:@selector(scrollViewWillBeginDragging:)]) {
        [self.delegate scrollViewWillBeginDragging:scrollView];
    }
}

@end


@implementation SHTableViewDefaultSectionModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.header = nil;
        self.identifierForSectionHeader = nil;
        self.identifierForSectionFooter = nil;
        self.items = [NSArray<SHListLayoutCellModelable> array];
        self.heightForHeader = 0;
        self.heightForFooter = 0.1f;
    }
    return self;
}

- (nullable NSString *)identifierForItemAtIndex:(NSInteger)index {
    if (index >= self.items.count) {
        return nil;
    }
    
    id<SHListLayoutCellModelable> item = self.items[index];
    return item.identifier;
}

- (NSInteger)numberOfItemsInSection {
    return self.items.count;
}

- (CGFloat)heightForItemAtIndex:(NSInteger)index {
    if (index >= self.items.count) {
        return 0;
    }
    id<SHListLayoutCellModelable> item = self.items[index];
    if (item) {
        return item.viewSize.height;
    }
    
    return 0;
}


@end
