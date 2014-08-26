//
//  MyLayout.m
//  SupViewTest
//
//  Created by Aaron Sutula on 8/26/14.
//  Copyright (c) 2014 Aaron Sutula. All rights reserved.
//

#import "MyLayout.h"

@implementation MyLayout

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray *array = [NSMutableArray array];
    
    UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
    if (CGRectIntersectsRect(rect, attributes.frame)) {
        [array addObject:attributes];
    }
    
    UICollectionViewLayoutAttributes *supAttributes = [self layoutAttributesForSupplementaryViewOfKind:@"supView" atIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
    if (supAttributes && CGRectIntersectsRect(rect, supAttributes.frame)) {
        [array addObject:supAttributes];
    }
    
    return array;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attributes.frame = CGRectMake(100, 100, 100, 100);
    return attributes;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:kind withIndexPath:indexPath];
    attributes.frame = CGRectMake(100, 220, 20, 20);
    attributes.alpha = self.transition;
    return attributes;
}

- (CGSize)collectionViewContentSize
{
    return CGSizeMake(200, 240);
}

@end
