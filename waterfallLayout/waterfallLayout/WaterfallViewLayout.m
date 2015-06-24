//
//  WaterfallViewLayout.m
//  waterfallLayout
//
//  Created by cxc on 15/6/24.
//  Copyright © 2015年 china. All rights reserved.
//

#import "WaterfallViewLayout.h"
#import "Shop.h"

@interface WaterfallViewLayout ()
/**
 *  item的属性数组
 */
@property(nonatomic,copy)NSArray *layoutAttributes;
@end
@implementation WaterfallViewLayout

-(void)prepareLayout{
    CGFloat contentWidth = self.collectionView.bounds.size.width - self.sectionInset.left - self.sectionInset.right;
    CGFloat itemWidth = (contentWidth - (self.columnCount - 1)*self.minimumInteritemSpacing)/self.columnCount;
    [self attributes:itemWidth];
}
- (void)attributes:(CGFloat)itemWidth{
    CGFloat colHeight[self.columnCount];
    NSInteger colCount[self.columnCount];
    for (int i=0; i<self.columnCount; ++i) {
        colHeight[i] = self.sectionInset.top;
        colCount[i] = 0;
    }
    CGFloat totoalItemHeight = 0;
    
    NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:self.dataList.count];
    NSInteger index = 0;
    for (Shop *shop in self.dataList) {
        NSIndexPath *path = [NSIndexPath indexPathForItem:index inSection:0];
        UICollectionViewLayoutAttributes *attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:path];
        NSInteger col = [self shortestCol:colHeight];
        colCount[col]++;
        CGFloat x = self.sectionInset.left + col*(itemWidth +self.minimumInteritemSpacing);
        CGFloat y = colHeight[col];
        CGFloat h = [self itemHeightWith:CGSizeMake(shop.w, shop.h) itemWidth:itemWidth];
        totoalItemHeight += h;
        attr.frame = CGRectMake(x, y, itemWidth, h);
        
        colHeight[col] += h + self.minimumLineSpacing;
        
        index ++;
        [arrayM addObject:attr];
    }
    NSInteger highestCol = [self highestCol:colHeight];
    CGFloat h = (colHeight[highestCol] - colCount[highestCol]*self.minimumLineSpacing)/colCount[highestCol];
    self.itemSize = CGSizeMake(itemWidth, h);
    
    UICollectionViewLayoutAttributes *footerAttr = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionFooter withIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
    footerAttr.frame = CGRectMake(0, colHeight[highestCol]-self.minimumLineSpacing, self.collectionView.bounds.size.width, 50);
    [arrayM addObject:footerAttr];
    self.layoutAttributes = arrayM.copy;
}
/// 等比例计算 item 高度
- (CGFloat)itemHeightWith:(CGSize)size itemWidth:(CGFloat)itemWidth {
    return size.height * itemWidth / size.width;
}
/// 计算最短的列
- (NSInteger)shortestCol:(CGFloat *)colHeight {
    
    CGFloat min = MAXFLOAT;
    NSInteger col = 0;
    
    for (int i = 0; i < self.columnCount; ++i) {
        if (colHeight[i] < min) {
            min = colHeight[i];
            col = i;
        }
    }
    return col;
}

/// 计算最高列
- (NSInteger)highestCol:(CGFloat *)colHeigth {
    
    CGFloat max = 0;
    NSInteger col = 0;
    
    for (int i = 0; i < self.columnCount; ++i) {
        if (colHeigth[i] > max) {
            max = colHeigth[i];
            col = i;
        }
    }
    return col;
}

- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    return self.layoutAttributes;
    
}


@end
