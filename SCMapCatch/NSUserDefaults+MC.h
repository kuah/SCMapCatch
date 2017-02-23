//
//  NSUserDefaults+MC.h
//  SCMapCatchDemo
//
//  Created by 陈世翰 on 17/2/23.
//  Copyright © 2017年 Coder Chan. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface NSUserDefaults (MC)

/* ps :  当路径越界后，往往我们需要沿着路径一路创建，但是mutableDictionary往往就没有这个需求*/
/**
 *  @brief 支持key以path的形式来设置值
 *  @param value 数值 （如果value传入的值为nil,则会把该key删除）
 *  @param defaultName key 可以以路径形式来划分等级  eg. root.floor1.b.n 或者是一个key数组，如果是key数组，则separatedString将会失效
 *  @param separatedString 用以划分层次的分隔符,分隔符将不被计入key或者value中,该值传空或为@""则关闭路径功能
 *  @return 插入是否成功，当路径上递归到非dictionary的值时，将会返回失败 YES/NO
 */
-(BOOL)mc_setObject:(id)value forKey:(id)defaultName separatedString:(NSString *)separatedString;
/**
 *  @brief 增加了value为nil时，remove当前key的功能
 *  @param value 不为nil时 setObject:ForKey: 为nil时，removeObjectForKey:
 *  @param defaultName key
 */
-(void)mc_setObject:(id)value forKey:(NSString *)defaultName;

/**
 *  @brief 支持key以path的形式来获取值
 *  @param defaultName 可以以路径形式来跨级抓取 (defaultName支持传入一个数组,若如此做,separatedString可以传nil)
 *  @param separatedString 分割路径等级的分割符
 *  @return 抓取结果
 */
-(id)mc_objectForKey:(id)defaultName separatedString:(NSString *)separatedString;

/**
 *  @brief 同上
 */
+(BOOL)mc_setObject:(id)value forKey:(id)defaultName separatedString:(NSString *)separatedString;
/**
 *  @brief 同上
 */
+(void)mc_setObject:(id)value forKey:(NSString *)defaultName;
/**
 *  @brief 同上
 */
+(id)mc_objectForKey:(id)defaultName separatedString:(NSString *)separatedString;
@end
