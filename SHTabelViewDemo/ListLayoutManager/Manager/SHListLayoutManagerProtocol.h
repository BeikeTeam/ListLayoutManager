//
//  SHListLayoutManagerProtocol.h
//  Pods
//
//  Created by 张晓珊 on 2018/7/12.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#ifndef SHListLayoutManagerProtocol_h
#define SHListLayoutManagerProtocol_h


#pragma mark - UITableView & UICollectionView Protocol

@protocol SHListLayoutHeaderModelable<NSObject>

@property (nonnull, nonatomic, copy) NSString *title;

@end

@protocol SHListLayoutCellModelable<NSObject>

@property (nonnull, nonatomic, copy) NSString *identifier;
@property (nullable, nonatomic, copy) NSString *targetUrl;
@property (nonatomic, assign) CGSize viewSize;

@end

@protocol SHListLayoutViewable<NSObject>

- (void)configWithModel: (nullable id) model;
@optional
- (void)endDisplaying;

@end

@protocol SHListLayoutSectionModelable<NSObject>

@property (nullable, nonatomic, strong) id<SHListLayoutHeaderModelable> header;
@property (nullable, nonatomic, copy) NSString *identifierForSectionHeader;
@property (nullable, nonatomic, copy) NSString *identifierForSectionFooter;

- (nonnull NSArray<SHListLayoutCellModelable>*)items;
- (nullable NSString *)identifierForItemAtIndex:(NSInteger)index;
- (NSInteger)numberOfItemsInSection;

@end


#pragma mark - UITableView Protocol

@protocol SHTableViewManagerDelegate<NSObject>

@optional
- (void)configTableViewHeaderFooterView:(nonnull UITableViewHeaderFooterView *)view;
- (void)configTableViewCell:(nonnull UITableViewCell *)cell;
- (void)didSelectWithTableView:(nonnull UITableView *)tableView atIndexPath:(nonnull NSIndexPath *)indexPath;
- (void)scrollViewDidScroll:(nonnull UIScrollView *)scrollView;
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView;

@end

@protocol SHTableViewMeasureDelegate<NSObject>

@property (nonatomic, assign) CGFloat heightForHeader;
@property (nonatomic, assign) CGFloat heightForFooter;

- (CGFloat)heightForItemAtIndex: (NSInteger) index;

@end

@protocol SHTableViewRootModelable<NSObject>

- (nonnull NSArray<SHListLayoutSectionModelable, SHTableViewMeasureDelegate>*)sections;

@end

#pragma mark - UICollectionView Protocol

@protocol SHCollectionViewMeasureDelegate<NSObject>

@property (nonatomic, assign) UIEdgeInsets insetForSection;
@property (nonatomic, assign) CGSize sizeForHeader;

- (CGSize)sizeForItemAtIndex:(NSInteger)index;

@optional
- (CGFloat)minimumLineSpacing;
- (CGFloat)minimumInteritemSpacing;

@end

@protocol SHCollectionViewRootModelable<NSObject>

- (nonnull NSArray<SHListLayoutSectionModelable, SHCollectionViewMeasureDelegate>*)sections;

@end

@protocol SHCollectionViewManagerDelegate<NSObject>

@optional
- (void)configCollectionViewCell:(nonnull UICollectionViewCell *)cell;
- (void)didSelectWithCollectionView:(nonnull UICollectionView *)collectionView atIndexPath:(nonnull NSIndexPath *)indexPath;
- (void)scrollViewDidScroll:(nonnull UIScrollView *)scrollView;

@end

#endif /* SHListLayoutManagerProtocol_h */
