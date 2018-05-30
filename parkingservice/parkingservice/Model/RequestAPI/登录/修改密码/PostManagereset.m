//
//  PutAccountPassword.m
//  huafangcase
//
//  Created by 柯思汉 on 17/8/7.
//  Copyright © 2017年 KKK. All rights reserved.
//

#import "PutAccountPassword.h"

@implementation PutAccountPassword
{
    NSString *_username;
    NSString *_oldpassword;
    NSString *_newpassword;
}
- (id)initWithusername:(NSString *)username oldpassword:(NSString *)oldpassword newpassword:(NSString*)newpassword;{
    self = [super init];
    if (self) {
        _username = username;
        _oldpassword = oldpassword;
        _newpassword = newpassword;
    }
    return self;
}
- (NSString *)requestUrl {
    // “http://www.yuantiku.com” 在 YTKNetworkConfig 中设置，这里只填除去域名剩余的网址信息
    return @"/v1/account/password";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPUT;
}

- (id)requestArgument {
//    DLog(@"%@",[_password getMD5]);
    return [self returnUrlArgumentsFilterParams:@{
                                                  @"username": _username,
                                                  @"newpassword": [_newpassword getMD5],
                                                  @"oldpassword":[_oldpassword getMD5]
                                                  }];
}

@end
