//
//  SHCollectionViewManager.m
//  AFNetworking
//
//  Created by 张晓珊 on 2018/7/12.
//

#import "SHCollectionViewManager.h"

@interface SHCollectionViewManager() 


@end

@implementation SHCollectionViewManager

#pragma makr - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    if (self.listModel) {
        return self.listModel.sections.count;
    }
    return 0;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section >= self.listModel.sections.count) {
        return 0;
    }
    
    id<SHListLayoutSectionModelable> sectionModel = self.listModel.sections[section];
    if (sectionModel && [sectionModel respondsToSelector:@selector(numberOfItemsInSection)]) {
        return [sectionModel numberOfItemsInSection];
    }
    
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section >= self.listModel.sections.count) {
        return [UICollectionViewCell new];
    }
    
    id<SHListLayoutSectionModelable> sectionModel = self.listModel.sections[indexPath.section];
    
    if ([sectionModel respondsToSelector:@selector(identifierForItemAtIndex:)]) {
        NSString *identifier = [sectionModel identifierForItemAtIndex:indexPath.item];
        
        if (identifier && identifier.length > 0) {
             UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
            if ([self.delegate respondsToSelector:@selector(configCollectionViewCell:)]) {
                [self.delegate configCollectionViewCell:cell];
            }
            return cell;
        }
    }
    
    return [UICollectionViewCell new];
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        
        if (indexPath.section >= self.listModel.sections.count) {
            return [UICollectionReusableView new];
        }
        
        id<SHListLayoutSectionModelable> sectionModel = self.listModel.sections[indexPath.section];
        if (sectionModel.identifierForSectionHeader) {
            UICollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:sectionModel.identifierForSectionHeader forIndexPath:indexPath];
            return header;
        }
    }
    
    return [UICollectionReusableView new];
}


#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section >= self.listModel.sections.count) {
        return CGSizeZero;
    }
    
    id<SHCollectionViewMeasureDelegate> sectionModel = self.listModel.sections[indexPath.section];
    if (sectionModel && [sectionModel respondsToSelector:@selector(sizeForItemAtIndex:)]) {
        return [sectionModel sizeForItemAtIndex:indexPath.item];
    }
    
    return CGSizeZero;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    if (section >= self.listModel.sections.count) {
        return UIEdgeInsetsZero;
    }
    
    id<SHCollectionViewMeasureDelegate> sectionModel = self.listModel.sections[section];
    if (sectionModel) {
        return sectionModel.insetForSection;
    }
    return UIEdgeInsetsZero;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    
    if (section >= self.listModel.sections.count) {
        return CGSizeZero;
    }
    
    id<SHCollectionViewMeasureDelegate> sectionModel = self.listModel.sections[section];
    if (sectionModel) {
        return sectionModel.sizeForHeader;
    }
    
    return CGSizeZero;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    
    CGFloat space = 0.f;
    if ([collectionViewLayout isKindOfClass:[UICollectionViewFlowLayout class]]) {
        space = ((UICollectionViewFlowLayout *)collectionViewLayout).minimumLineSpacing;
    }
    
    if (section >= self.listModel.sections.count) {
        return space;
    }
    
    id<SHCollectionViewMeasureDelegate> sectionModel = self.listModel.sections[section];
    if (sectionModel && [sectionModel respondsToSelector:@selector(minimumLineSpacing)]) {
        space = sectionModel.minimumLineSpacing;
    }
    
    return space;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    CGFloat space = 0.f;
    if ([collectionViewLayout isKindOfClass:[UICollectionViewFlowLayout class]]) {
        space = ((UICollectionViewFlowLayout *)collectionViewLayout).minimumInteritemSpacing;
    }
    
    if (section >= self.listModel.sections.count) {
        return space;
    }
    
    id<SHCollectionViewMeasureDelegate> sectionModel = self.listModel.sections[section];
    if (sectionModel && [sectionModel respondsToSelector:@selector(minimumInteritemSpacing)]) {
        space = sectionModel.minimumLineSpacing;
    }
    
    return space;
}


#pragma - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView willDisplaySupplementaryView:(UICollectionReusableView *)view forElementKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section >= self.listModel.sections.count) {
        return;
    }
    
    id<SHListLayoutSectionModelable> sectionModel = self.listModel.sections[indexPath.section];
    if ([view conformsToProtocol:@protocol(SHListLayoutViewable)] && [view respondsToSelector:@selector(configWithModel:)]) {
        [((id<SHListLayoutViewable>)view) configWithModel:sectionModel.header];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingSupplementaryView:(UICollectionReusableView *)view forElementOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
    
    if ([view conformsToProtocol:@protocol(SHListLayoutViewable)] && [view respondsToSelector:@selector(endDisplaying)]) {
        [((id<SHListLayoutViewable>)view) endDisplaying];
    }
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section >= self.listModel.sections.count) {
        return;
    }
    
    id<SHListLayoutSectionModelable> sectionModel = self.listModel.sections[indexPath.section];
    
    if (indexPath.item >= sectionModel.items.count) {
        return;
    }
    
    id<SHListLayoutCellModelable> cellModel = sectionModel.items[indexPath.item];
    if ([cell conformsToProtocol:@protocol(SHListLayoutViewable)] && [cell respondsToSelector:@selector(configWithModel:)]) {
        [((id<SHListLayoutViewable>)cell) configWithModel:cellModel];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([cell conformsToProtocol:@protocol(SHListLayoutViewable)] && [cell respondsToSelector:@selector(endDisplaying)]) {
        [((id<SHListLayoutViewable>)cell) endDisplaying];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectWithCollectionView:atIndexPath:)]) {
        [self.delegate didSelectWithCollectionView:collectionView atIndexPath:indexPath];
    }
}


@end


@implementation SHCollectionViewDefaultSectionModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.header = nil;
        self.identifierForSectionHeader = nil;
        self.identifierForSectionFooter = nil;
        self.items = [NSArray<SHListLayoutCellModelable> array];
        self.sizeForHeader = CGSizeZero;
        self.insetForSection = UIEdgeInsetsZero;
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

- (CGSize)sizeForItemAtIndex:(NSInteger)index {
    if (index >= self.items.count) {
        return CGSizeZero;
    }
    id<SHListLayoutCellModelable> item = self.items[index];
    if (item) {
        return item.viewSize;
    }
    
    return CGSizeZero;
}



@end
