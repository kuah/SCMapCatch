//
//  NSDictionary+MC.m
//  SCMapCatchDemo
//
//  Created by 陈世翰 on 17/2/23.
//  Copyright © 2017年 Coder Chan. All rights reserved.
//

#import "NSDictionary+MC.h"

@implementation NSDictionary (MC)
/**
 *  @brief 支持key以path的形式来获取值
 *  @param aKey 可以以路径形式来跨级抓取
 *  @param separatedString 分割路径等级的分割符
 *  @return 抓取结果
 */
-(id)mc_objectForKey:(id)aKey separatedString:(NSString *)separatedString{
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
          return  [firstObject mc_objectForKey:[keys subarrayWithRange:(NSRange){1,keys.count-1}] separatedString:nil];
        }else{
            return nil;
        }
    }
}
@end
