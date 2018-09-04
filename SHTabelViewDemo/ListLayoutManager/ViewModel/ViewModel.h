//
//  ViewModel.h
//  ListLayoutManager
//
//  Created by 张晓珊 on 2018/9/4.
//  Copyright © 2018年 张晓珊. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SHListLayoutManagerProtocol.h"
#import "SHTableViewManager.h"

@interface ViewModel : NSObject <SHTableViewRootModelable>

@property (nonnull, nonatomic, strong, readonly) NSArray<SHListLayoutSectionModelable, SHTableViewMeasureDelegate>* sections;

- (void)loadData;

@end

@interface CustomSectionModel : SHTableViewDefaultSectionModel


@end
