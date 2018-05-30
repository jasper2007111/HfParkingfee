//
//  UserData.m
//  tuanhuiyuan
//
//  Created by zccl on 15/7/1.
//  Copyright (c) 2015年 dcf. All rights reserved.
//

#import "UserData.h"
#import "UserInfoModel.h"
@implementation UserData

+(void)setDefults:(NSDictionary *)dic
{
    NSArray *key =[[NSArray alloc]initWithArray:[dic allKeys]];
    for (int i=0; i<key.count; i++) {
        NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
       if( [dic[key[i]] isKindOfClass:[NSString class]])
       {
           [userdefaults setObject:[[NSString alloc]initWithFormat:@"%@",dic[key[i]]] forKey:key[i]];
       }
        else
        {
        [userdefaults setObject:dic[key[i]] forKey:key[i]];
        }
        [userdefaults synchronize];
    }
}
+ (id)getDvalue:(NSString *)name
{
    return  [[NSUserDefaults standardUserDefaults] objectForKey:name];

}


#pragma mark- 保存用户城市信息
+(void)setUserInfo:(UserInfoModel*)model
{
    NSMutableDictionary * _dictUserInfo = [[NSMutableDictionary alloc] init];
    [_dictUserInfo setValue:model.createtime forKey:@"createtime"];
    [_dictUserInfo setValue:model.disable forKey:@"disable"];
    [_dictUserInfo setValue:model.employeeAccount forKey:@"employeeAccount"];
    [_dictUserInfo setValue:model.familyId forKey:@"familyId"];
    [_dictUserInfo setValue:model.familyName forKey:@"familyName"];
    [_dictUserInfo setValue:model.jobId forKey:@"jobId"];
    [_dictUserInfo setValue:model.jobName forKey:@"jobName"];
    [_dictUserInfo setValue:model.landline forKey:@"landline"];
    [_dictUserInfo setValue:model.mail forKey:@"mail"];
    [_dictUserInfo setValue:model.mobile forKey:@"mobile"];
    [_dictUserInfo setValue:model.oaId forKey:@"oaId"];
    [_dictUserInfo setValue:model.orgId forKey:@"orgId"];
    [_dictUserInfo setValue:model.realname forKey:@"realname"];
    [_dictUserInfo setValue:model.sex forKey:@"sex"];
    [_dictUserInfo setValue:model.uptime forKey:@"uptime"];
    [_dictUserInfo setValue:model.userPassword forKey:@"userPassword"];
    [_dictUserInfo setValue:model.uuid forKey:@"uuid"];
    
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    [userdefaults setObject:_dictUserInfo forKey:@"userinfo"];
    [userdefaults synchronize];
}

+(NSDictionary *)getUserInfo
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"userinfo"];
}

+(void)changeUserInfo:(NSString *)key Value:(NSString*)value
{
    NSMutableDictionary *userdic =[[NSMutableDictionary alloc]initWithDictionary:[UserData getUserInfo]];
    [userdic setValue:value forKey:key];
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    [userdefaults setObject:userdic forKey:@"userinfo"];
    [userdefaults synchronize];
}



+(void)setHistorical:(NSDictionary*)historical
{
   
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    [userdefaults setObject:historical forKey:@"historical"];
    [userdefaults synchronize];
}
+(NSDictionary *)getHistorical
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"historical"];
}
+ (void)removeHistory
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"historical"];
}
#pragma mark ----------清楚所有数据
+(void)removeAllData
{
    NSUserDefaults *defatluts = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *dictionary = [defatluts dictionaryRepresentation];
    
    for(NSString *key in [dictionary allKeys]){
        
        if ([key isEqualToString:@"historical"]) {
            continue;
        }
        [defatluts removeObjectForKey:key];
        
        [defatluts synchronize];
        
    }
    
}
@end
