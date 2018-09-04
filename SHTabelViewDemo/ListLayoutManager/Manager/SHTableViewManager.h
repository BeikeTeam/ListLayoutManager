//
//  SHTableViewManager.h
//  AFNetworking
//
//  Created by 张晓珊 on 2018/7/12.
//

#import "SHListLayoutManagerProtocol.h"

@interface SHTableViewManager : NSObject <UITableViewDelegate, UITableViewDataSource>

@property (nullable, nonatomic, weak) id<SHTableViewRootModelable> listModel;
@property (nullable, nonatomic, weak) id<SHTableViewManagerDelegate> delegate;

@end

@interface SHTableViewDefaultSectionModel : NSObject<SHListLayoutSectionModelable>

@property (nullable, nonatomic, strong) id<SHListLayoutHeaderModelable> header;
@property (nullable, nonatomic, copy) NSString *identifierForSectionHeader;
@property (nullable, nonatomic, copy) NSString *identifierForSectionFooter;
@property (nonnull, nonatomic, copy) NSArray<SHListLayoutCellModelable> *items;
@property (nonatomic, assign) CGFloat heightForHeader;
@property (nonatomic, assign) CGFloat heightForFooter;

- (nullable NSString *)identifierForItemAtIndex:(NSInteger)index;
- (NSInteger)numberOfItemsInSection;
- (CGFloat)heightForItemAtIndex: (NSInteger) index;

@end
