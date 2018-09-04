//
//  CollectionHeaderView.h
//  ListLayoutManagerDemo
//
//  Created by 张晓珊 on 2018/8/16.
//  Copyright © 2018年 张晓珊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SHListLayoutManagerProtocol.h"

@interface CollectionHeaderViewModel : NSObject <SHListLayoutHeaderModelable>

@property (nonnull, nonatomic, copy) NSString *title;

@end

@interface CollectionHeaderView : UICollectionReusableView

@end
