//
//  UICollectionView+itemIndex.m
//  Yun
//
//  Created by my on 2017/3/13.
//  Copyright © 2017年 lq. All rights reserved.
//

#import "UICollectionView+itemIndex.h"

@implementation UICollectionView (itemIndex)


-(NSInteger)cellIndexForIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger cellIndex = 0;
    for (NSInteger section = 0; section < indexPath.section; section++) {
        cellIndex += [self numberOfItemsInSection:section];
    }
    
    cellIndex += indexPath.row;
    
    return cellIndex;
}
@end
