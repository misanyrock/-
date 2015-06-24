//
//  Shop.h
//  waterfallLayout
//
//  Created by cxc on 15/6/24.
//  Copyright © 2015年 china. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Shop : NSObject
/**
 *  plist文件字典对应key
 */
@property (nonatomic,copy) NSString *img;
@property (nonatomic,copy) NSString *price;
@property (nonatomic,assign) float w;
@property (nonatomic,assign) float h;

/**
 *  字典转模型
 *
 *  @param dict plist文件
 *
 *  @return shop对象
 */
+ (instancetype)shopWithDict:(NSDictionary *)dict;
/**
 *  根据索引加载店铺数组
 *
 *  @param index 索引
 *
 *  @return 店铺数组
 */
+ (NSArray *)shopsWithIndex:(NSInteger)index;
@end
