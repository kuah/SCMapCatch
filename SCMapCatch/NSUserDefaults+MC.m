//
//  NSUserDefaults+MC.m
//  SCMapCatchDemo
//
//  Created by 陈世翰 on 17/2/23.
//  Copyright © 2017年 Coder Chan. All rights reserved.
//

#import "NSUserDefaults+MC.h"
#import "NSMutableDictionary+MC.h"
#import "NSDictionary+MC.h"
@implementation NSUserDefaults (MC)
/**
 *  @brief 支持key以path的形式来设置值
 *  @param value 数值 （如果value传入的值为nil,则会把该key删除）
 *  @param defaultName key 可以以路径形式来划分等级  eg. root.floor1.b.n 或者是一个key数组，如果是key数组，则separatedString将会失效
 *  @param separatedString 用以划分层次的分隔符,分隔符将不被计入key或者value中,该值传空或为@""则关闭路径功能
 *  @return 插入是否成功，当路径上递归到非dictionary的值时，将会返回失败 YES/NO
 */
-(BOOL)mc_setObject:(id)value forKey:(id)defaultName separatedString:(NSString *)separatedString{
    
    /*---------->分割功能开启<-----------*/
    //分割出不同层次的组件
    NSArray *components;
    if ([defaultName isKindOfClass:[NSString class]]) {
        if (separatedString.length==0) {//如果关闭了分割功能能或没有被分割
            [self mc_setObject:value forKey:defaultName];
            return YES;
        }
        components=[defaultName componentsSeparatedByString:separatedString];
    }else if([defaultName isKindOfClass:[NSArray class]]){
        components= defaultName;
    }
    
    if (components.count==1) {//组件为1，则没有被分割，直接设置
        [self mc_setObject:value forKey:defaultName];
        return YES;
    }else if (components.count>1){//最少有两层的路径
        id floor = [self objectForKey:components.firstObject];
        if (!floor) {
            floor = MDictionary();
            
        }else{
            if ([floor isKindOfClass:[NSDictionary class]]) {
                floor = MDictionary_(floor);
            }else{
                return NO;
            }
        }
        floor = [self _mc_componentForFloor:floor components:[components subarrayWithRange:(NSRange){1,components.count-1}] input:value];
        if (!floor) {
            return NO;
        }
        [self setObject:floor forKey:components.firstObject];
        [self  synchronize];
        return YES;
    }
    return NO;
}
//----->递归方法
-(id)_mc_componentForFloor:(NSMutableDictionary * )floor components:(NSArray *)components input:(id)inputObject{
    if (!floor)return nil;
    if (components.count==1) {//最后一层
        [floor mc_setObject:inputObject forKey:components.firstObject];
    }else if(components.count>1){//递归的路上
        if (floor[components.firstObject] && [floor[components.firstObject] isKindOfClass:[NSDictionary class]]) {//目标层有dict
            [self _mc_componentForFloor:MDictionary_(floor[components.firstObject]) components:[components subarrayWithRange:(NSRange){1,components.count-1}] input:inputObject];
        }else if (!floor[components.firstObject]){//目标层没有东西
            [floor setObject:[self _mc_componentForFloor:MDictionary() components:[components subarrayWithRange:(NSRange){1,components.count-1}] input:inputObject] forKey:components.firstObject];
        }else{
            return nil;
        }
    }
    return floor;
}
/**
 *  @brief 增加了value为nil时，remove当前key的功能
 *  @param value 不为nil时 setObject:ForKey: 为nil时，removeObjectForKey:
 *  @param defaultName key
 */
-(void)mc_setObject:(id)value forKey:(NSString *)defaultName{
    if (value) {
        [self setObject:value forKey:defaultName];
    }else{
        [self removeObjectForKey:defaultName];
    }
    [self synchronize];
}
/**
 *  @brief 支持key以path的形式来获取值
 *  @param defaultName 可以以路径形式来跨级抓取 (defaultName支持传入一个数组,若如此做,separatedString可以传nil)
 *  @param separatedString 分割路径等级的分割符
 *  @return 抓取结果
 */
-(id)mc_objectForKey:(id)defaultName separatedString:(NSString *)separatedString{
    NSArray *components;
    if ([defaultName isKindOfClass:[NSString class]]) {
        if (separatedString.length==0) {
            return [self objectForKey:defaultName];
        }
        components=[defaultName componentsSeparatedByString:separatedString];
    }else if([defaultName isKindOfClass:[NSArray class]]){
        components= defaultName;
    }
    if (components.count == 1) {
       return [self objectForKey:components.firstObject];
    }else{
        NSString *firstKey = components.firstObject;
        id firstObject = [self objectForKey:firstKey];
        if ([firstObject isKindOfClass:[NSDictionary class]]) {
            return  [firstObject mc_objectForKey:[components subarrayWithRange:(NSRange){1,components.count-1}] separatedString:nil];
        }else{
            return nil;
        }
    }
}
/**
 *  @brief 同上
 */
+(BOOL)mc_setObject:(id)value forKey:(id)defaultName separatedString:(NSString *)separatedString{
    return [[NSUserDefaults standardUserDefaults] mc_setObject:value forKey:defaultName separatedString:separatedString];
}
/**
 *  @brief 同上
 */
+(void)mc_setObject:(id)value forKey:(NSString *)defaultName{
    [[NSUserDefaults standardUserDefaults] mc_setObject:value forKey:defaultName];
}
/**
 *  @brief 同上
 */
+(id)mc_objectForKey:(id)defaultName separatedString:(NSString *)separatedString{
    return [[NSUserDefaults standardUserDefaults] mc_objectForKey:defaultName separatedString:separatedString];
}
@end
