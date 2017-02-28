#SCMapCatch
[SCMapCatch](https://github.com/Chan4iOS/SCMapCatch) 是一个关于 NSUserDefaults , NSDictionary,NSMutableDictionary的轻量封装.

##安装
####手动
[SCMapCatch](https://github.com/Chan4iOS/SCMapCatch) 下载demo项目,将`SCMapCatch`文件夹copy添加到项目中
####CocoaPod
在profile中添加
```
pod 'SCMapCatch'
```
终端切换到项目目录，执行
```
pod install
```
##介绍
不知道我是特例还是大家都会遇到以下的几种情况：

#####字典object的获取
这里说的当然不是简单的`objectForKey:`,往往我会遇到，需要在一个多层嵌套的字典组成的树状结构中，获取得到特定的一个object
```
{
    1 =     {
        b =         {
            5 = 6;
        };
    };
};
```

#####NSUserDefault的分用户(模块)设置，以及object获取
NSUserDefault，作用就不多说，随便举个例子，记住密码，单个用户当然可以很简单的实现，但是我们在允许记住多个用户的记住密码的情况下，又符合管理规范，我们往往需要把`记住密码`看作一个`小模块`并`独立出一个key`放在NSUserDefault的第一层(如果你说可以直接存放，则此问题可忽略)。比如:
```
{
    pwKeeping =     {
        user_a =    123456,
        user_b =    654321
    };
};
```
那么这样保存方式极其繁琐。

###仅需要一句代码
#####字典object的获取
```
NSDictionary *dic = @{@"1":@{@"b":@{@"5":@6}}};
//用特定的符号来划分路径的等级
id catchResult = [dic mc_objectForKey:@"1.b.5" separatedString:@"."];
```
#####NSUserDefault的分用户(模块)设置，以及object获取
######设置
```
//二选一
[NSUserDefaults mc_setObject:@"123456" forKey:@[@"pwKeeping",@"user_a"] separatedString:nil];
[NSUserDefaults mc_setObject:@"654321" forKey:[@"pwKeeping"stringByAppendingPathComponent:@"user_a"] separatedString:@"/"];
```
######获取
```
NSString *getting_result = [NSUserDefaults mc_objectForKey:@"your_root/m/c" separatedString:@"/"]
```

###说明
######在NSUserDefault 中`mc_setobject: forKey:`方法的调用
* 所过路径必须为NSDictionary或其子类
* 所过路径，遇到了空路径则会被创建
* 当object为nil时，则末尾key会被remove

######在NSUserDefault 和 字典 中 `objectForKey:` 方法的调用
* 非目标位置的所过路径，一旦找不到或找到的object值不是字典或其子类，则返回nil

----
#SCMapCatch
[SCMapCatch](https://github.com/Chan4iOS/SCMapCatch) , a simplified tool for NSUserDefaults , NSDictionary,NSMutableDictionary.

##Install
####Manually
[SCMapCatch](https://github.com/Chan4iOS/SCMapCatch) download the demo code , copy the `SCMapCatch` folder into your project.
####CocoaPod
use 
```
pod 'SCMapCatch'
```
