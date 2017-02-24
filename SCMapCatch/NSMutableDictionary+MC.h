//
//  NSMutableDictionary+MC.h
//  SCMapCatchDemo
//
//  Created by 陈世翰 on 17/2/23.
//  Copyright © 2017年 Coder Chan. All rights reserved.
//

#import <Foundation/Foundation.h>

#define MDictionary() [NSMutableDictionary dictionary]
#define MDictionary_(_dict_) [NSMutableDictionary dictionaryWithDictionary:_dict_]
#define MArray() [NSMutableArray array]
#define MArray_(_array_) [NSMutableArray arrayWithArray:_array_]

@interface NSMutableDictionary (MC)
/**
 *  @brief 增加了anObject为nil时，remove当前aKey的功能
 *  @param anObject 不为nil时 setObject:ForKey: 为nil时，removeObjectForKey:
 *  @param aKey key
 */
-(void)mc_setObject:(id)anObject forKey:(id<NSCopying>)aKey;
@end
