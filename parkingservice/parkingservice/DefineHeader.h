//
//  DefineHeader.h
//  mat
//
//  Created by 方燕娇 on 2017/6/28.
//  Copyright © 2017年 hfy. All rights reserved.
//

#ifndef DefineHeader_h
#define DefineHeader_h

#define KFLog( s, ... ) NSLog( @"< %@:(%d) > %@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )

#define APPDELEGATE   [UIApplication sharedApplication].delegate//启动界面
#define DEVICE_WIDTH ([UIScreen mainScreen].bounds.size.width)//设备宽
#define DEVICE_HEIGHT ([UIScreen mainScreen].bounds.size.height)//设备高

#define kBackGroundColor UIColorHex(#FFFFFF)//内容区域底色
#define kLineColor UIColorHex(#ecedee)//分割线颜色

#define HFKJ_uuid @"a402d558-febf-4ee4-8d68-26e49d05489e" //华方科技uuid
#define HFY_uuid  @"eec1e939-6823-4d39-9b9a-e5346d6a9e8b" //华方云uuid

#pragma mark- 弱引用

#define JF_WS(weakSelf) __weak __typeof(&*self)weakSelf = self;

#define TEST_ENV
#ifdef TEST_ENV

#define DLog(fmt, ...) NSLog((@"\n <%s : %d> %s  " @"\n " fmt), [[[NSString stringWithUTF8String:__FILE__] lastPathComponent]   UTF8String], __LINE__, __PRETTY_FUNCTION__,  ##__VA_ARGS__);
// 颜色
#define KF_RGB(r, g, b)  [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
//网络配置
#define YTKBASEURL         @"https://ag.hfycloud.com"
#define YTKUploadImageURL  @"http://120.25.135.143:8203/" // 后台地址
//#define YTKHTTP            @"http://shuxiang.h5.listcloud.cn" // H5地址
#define YTKCDNURL          @""

// 图片地址
//#define kAvatarURLWithId(_uid_) [NSString stringWithFormat:@"http://112.74.168.10:6020/avatar?id=%@",_uid_]

//AG配置
#define AG_TOKEN    @"07D04C73B2583D2CDC7F"
#define AG_APPID    @"ICECASE0-4671-4242-81FD-1C9D15C85953"
#define AG_ENCRYPT  @"commonICE"

// 沙盒路径
#define JF_PATH_OF_APP_HOME    NSHomeDirectory()
#define JF_PATH_OF_TEMP        NSTemporaryDirectory()
#define JF_PATH_OF_DOCUMENT    [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]
// 过期提醒
#define skDeprecated(instead) NS_DEPRECATED(1_0, 1_0, 1_0, 1_0, instead)

#else

//网络配置
#define YTKBASEURL         @""
//#define YTKUploadImageURL  @"http://sx.admin.listcloud.cn/admin.php" // 后台地址
//#define YTKHTTP            @"http://sx.h5.listcloud.cn" // H5地址
#define YTKCDNURL          @""

// 图片地址
//#define kAvatarURLWithId(_uid_) [NSString stringWithFormat:@"http://112.74.168.10:6020/avatar?id=%@",_uid_]

//AG配置
#define AG_TOKEN    @""
#define AG_APPID    @""
#define AG_ENCRYPT  @""

// 过期提醒
#define skDeprecated(instead) NS_DEPRECATED(1_0, 1_0, 1_0, 1_0, instead)

#define DLog(...)

#endif




#endif /* DefineHeader_h */
