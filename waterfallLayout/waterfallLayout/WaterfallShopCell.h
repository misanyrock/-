//
//  WaterfallShopCell.h
//  waterfallLayout
//
//  Created by cxc on 15/6/24.
//  Copyright © 2015年 china. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Shop;

@interface WaterfallShopCell : UICollectionViewCell
/**
 *  数据模型
 */
@property (nonatomic,strong) Shop *shop;
@end
