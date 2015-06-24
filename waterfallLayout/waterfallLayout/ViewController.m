//
//  ViewController.m
//  waterfallLayout
//
//  Created by cxc on 15/6/24.
//  Copyright © 2015年 china. All rights reserved.
//

#import "ViewController.h"
#import "Shop.h"
#import "WaterfallShopCell.h"
#import "WaterfallViewLayout.h"
#import "CXCCollectionFooterView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet WaterfallViewLayout *layout;
@property (nonatomic,strong) NSMutableArray *shops;
@property (nonatomic,weak) CXCCollectionFooterView *footerView;
@property (nonatomic,assign,getter=isLoading) BOOL loading;
@property (nonatomic,assign) NSInteger index;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
}
- (void)loadData{
    [self.shops addObjectsFromArray:[Shop shopsWithIndex:self.index]];
    self.index++;
    self.layout.columnCount = 3;
    self.layout.dataList = self.shops;
    
    [self.collectionView reloadData];
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.shops.count;
}
- (UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
    WaterfallShopCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.shop = self.shops[indexPath.item];
    cell.backgroundColor = [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0];
    
    return cell;
}
- (UICollectionReusableView *)collectionView:(nonnull UICollectionView *)collectionView viewForSupplementaryElementOfKind:(nonnull NSString *)kind atIndexPath:(nonnull NSIndexPath *)indexPath{
    if (kind == UICollectionElementKindSectionFooter) {
        self.footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footerView" forIndexPath:indexPath];
        return self.footerView;
    }
    return nil;
}

- (void)scrollViewDidScroll:(nonnull UIScrollView *)scrollView{
    if (self.footerView == nil || self.isLoading) {
        return;
    }
    if ((scrollView.contentOffset.y+scrollView.bounds.size.height)>self.footerView.frame.origin.y) {
        self.loading = YES;
        [self.footerView.indicator startAnimating];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.footerView = nil;
            [self loadData];
            self.loading = NO;
        });
    }
}
#pragma mark -懒加载 =>
- (NSMutableArray *)shops{
    if (_shops == nil) {
        _shops = [NSMutableArray array];
    }
    return _shops;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
