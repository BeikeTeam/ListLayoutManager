//
//  SHCollectionViewManager.h
//  AFNetworking
//
//  Created by 张晓珊 on 2018/7/12.
//

#import "SHListLayoutManagerProtocol.h"

@interface SHCollectionViewManager : NSObject <UICollectionViewDelegateFlowLayout, UICollectionViewDataSource>

@property (nullable, nonatomic, weak) id<SHCollectionViewRootModelable> listModel;
@property (nullable, nonatomic, weak) id<SHCollectionViewManagerDelegate> delegate;

@end


@interface SHCollectionViewDefaultSectionModel : NSObject<SHListLayoutSectionModelable, SHCollectionViewMeasureDelegate>


#pragma mark - SHListLayoutSectionModelable

@property (nullable, nonatomic, strong) id<SHListLayoutHeaderModelable> header;
@property (nullable, nonatomic, copy) NSString *identifierForSectionHeader;
@property (nullable, nonatomic, copy) NSString *identifierForSectionFooter;
@property (nonnull, nonatomic, strong) NSArray<SHListLayoutCellModelable> *items;

- (nullable NSString *)identifierForItemAtIndex:(NSInteger)index;
- (NSInteger)numberOfItemsInSection;


#pragma mark - SHCollectionViewMeasureDelegate

@property (nonatomic, assign) UIEdgeInsets insetForSection;
@property (nonatomic, assign) CGSize sizeForHeader;

- (CGSize)sizeForItemAtIndex:(NSInteger)index;


@end
