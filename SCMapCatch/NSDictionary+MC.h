//
//  NSDictionary+MC.h
//  SCMapCatchDemo
//
//  Created by 陈世翰 on 17/2/23.
//  Copyright © 2017年 Coder Chan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (MC)
/**
 *  @brief 支持key以path的形式来获取值
 *  @param aKey 可以以路径形式来跨级抓取 (aKey支持传入一个数组)
 *  @param separatedString 分割路径等级的分割符
 *  @return 抓取结果
 */
-(id)mc_objectForKey:(id)aKey separatedString:(NSString *)separatedString;
@end
