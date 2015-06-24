//
//  WaterfallShopCell.m
//  waterfallLayout
//
//  Created by cxc on 15/6/24.
//  Copyright © 2015年 china. All rights reserved.
//

#import "WaterfallShopCell.h"
#import "Shop.h"
#import "UIImageView+WebCache.h"


@interface WaterfallShopCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *priceLaber;


@end
@implementation WaterfallShopCell
-(void)setShop:(Shop *)shop{
    _shop = shop;
    
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:shop.img]];
    self.priceLaber.text = shop.price;
}
@end
