//
//  ViewModel.h
//  ListLayoutManagerDemo
//
//  Created by 张晓珊 on 2018/8/16.
//  Copyright © 2018年 张晓珊. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SHListLayoutManagerProtocol.h"
#import "SHCollectionViewManager.h"

@interface ViewModel : NSObject<SHCollectionViewRootModelable>

@property (nonnull, nonatomic, strong, readonly) NSArray<SHListLayoutSectionModelable, SHCollectionViewMeasureDelegate>* sections;
- (void)loadData;

@end

@interface SectionModel : SHCollectionViewDefaultSectionModel


@end
