//
//  UserData.h
//  tuanhuiyuan
//
//  Created by zccl on 15/7/1.
//  Copyright (c) 2015年 dcf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfoModel.h"
@interface UserData : NSObject

+(void)setDefults:(NSDictionary *)dic;
+ (id)getDvalue:(NSString *)name;
//修改个人信息
+(void)changeUserInfo:(NSString *)key Value:(NSString*)value;
//个人信息
+(void)setUserInfo:(UserInfoModel*)model;
+(NSDictionary *)getUserInfo;
//浏览历史记录
+(void)setHistorical:(NSDictionary*)historical;
+(NSDictionary *)getHistorical;
//删除历史记录
+ (void)removeHistory;
+(void)removeAllData;
@end
