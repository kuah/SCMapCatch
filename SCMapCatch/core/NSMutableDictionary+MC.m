//
//  NSMutableDictionary+Kuah.m
//  KMapCatch
//
//  Created by 陈世翰 on 17/2/23.
//  Copyright © 2017年 Coder Chan. All rights reserved.
//

#import "NSMutableDictionary+Kuah.h"

@implementation NSMutableDictionary (Kuah)
/**
 *  @brief 增加了anObject为nil时，remove当前aKey的功能
 *  @param anObject 不为nil时 setObject:ForKey: 为nil时，removeObjectForKey:
 *  @param aKey key
 */
-(void)Kuah_setObject:(id)anObject forKey:(id<NSCopying>)aKey{
    if (anObject) {
        [self setObject:anObject forKey:aKey];
    }else{
        [self removeObjectForKey:aKey];
    }
}
@end
