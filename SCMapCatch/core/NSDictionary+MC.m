//
//  NSDictionary+Kuah.m
//  KMapCatch
//
//  Created by 陈世翰 on 17/2/23.
//  Copyright © 2017年 Coder Chan. All rights reserved.
//

#import "NSDictionary+Kuah.h"

@implementation NSDictionary (Kuah)


/**
 *  @brief 支持key以path的形式来获取值
 *  @param key 可以以路径形式来跨级抓取
 *  @return 抓取结果
 */
-(id)Kuah_objectForKeys:(NSString *)keys,...{
    NSMutableArray * keyArray = [NSMutableArray array];
    va_list args;
    va_start(args, keys);
    for (NSString * currentKey = keys; currentKey != nil; currentKey = va_arg(args, id)) {
        NSCAssert([currentKey isKindOfClass:NSString.class], @"key %@ is not a NSString", currentKey);
        [keyArray addObject:currentKey];
    }
    va_end(args);
    return  [self Kuah_objectForKey:keyArray separatedString:nil];
}
/**
 *  @brief 支持key以path的形式来获取值
 *  @param aKey 可以以路径形式来跨级抓取
 *  @param separatedString 分割路径等级的分割符
 *  @return 抓取结果
 */
-(id)Kuah_objectForKey:(id)aKey separatedString:(NSString *)separatedString{
    NSArray *keys;
    if ([aKey isKindOfClass:[NSString class]]) {
        if (separatedString.length==0) {
            return [self objectForKey:aKey];
        }
        keys=[aKey componentsSeparatedByString:separatedString];
    }else if ([aKey isKindOfClass:[NSArray class]]){
        keys = aKey;
    }
    
    if (keys.count ==1) {
        return [self objectForKey:keys.firstObject];
    }else{
        NSString *firstKey = keys.firstObject;
        id firstObject = self[firstKey];
        if ([firstObject isKindOfClass:[NSDictionary class]]) {
          return  [firstObject Kuah_objectForKey:[keys subarrayWithRange:(NSRange){1,keys.count-1}] separatedString:nil];
        }else{
            return nil;
        }
    }
}
@end