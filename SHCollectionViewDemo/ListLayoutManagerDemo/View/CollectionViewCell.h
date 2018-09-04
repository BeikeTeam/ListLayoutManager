//
//  CollectionViewCell.h
//  ListLayoutManagerDemo
//
//  Created by 张晓珊 on 2018/8/16.
//  Copyright © 2018年 张晓珊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SHListLayoutManagerProtocol.h"

@interface CollectionViewCellModel : NSObject <SHListLayoutCellModelable>

@property (nonnull, nonatomic, copy) NSString *identifier;
@property (nonatomic, copy) NSString *targetUrl;
@property (nonatomic, assign) CGSize viewSize;

@property (nonatomic, copy) NSString *number;

@end


@interface CollectionViewCell : UICollectionViewCell


@end
