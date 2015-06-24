//
//  Shop.m
//  waterfallLayout
//
//  Created by cxc on 15/6/24.
//  Copyright © 2015年 china. All rights reserved.
//

#import "Shop.h"

@implementation Shop

+ (instancetype)shopWithDict:(NSDictionary *)dict{
    id obj = [[self alloc]init];
    [obj setValuesForKeysWithDictionary:dict];
    return obj;
}
+ (NSArray *)shopsWithIndex:(NSInteger)index{
    NSString *fileName = [NSString stringWithFormat:@"%zd.plist",(index%3)+1];
    NSString *path = [[NSBundle mainBundle]pathForResource:fileName ofType:nil];
    NSArray *array = [NSArray arrayWithContentsOfFile:path];
    NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:array.count];
    [array enumerateObjectsUsingBlock:^(id  __nonnull obj, NSUInteger idx, BOOL * __nonnull stop) {
        [arrayM addObject:[self shopWithDict:obj]];
    }];
    return arrayM.copy;
}
@end
