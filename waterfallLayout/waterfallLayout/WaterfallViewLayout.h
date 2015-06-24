//
//  WaterfallViewLayout.h
//  waterfallLayout
//
//  Created by cxc on 15/6/24.
//  Copyright © 2015年 china. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WaterfallViewLayout : UICollectionViewFlowLayout
/**
 *  列数
 */
@property (nonatomic,assign) NSInteger columnCount;
/**
 *  数据数组
 */
@property (nonatomic,strong) NSArray *dataList;
@end
