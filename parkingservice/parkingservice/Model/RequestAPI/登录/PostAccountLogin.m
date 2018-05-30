//
//  PostAccountLogin.m
//  huafangcase
//
//  Created by 柯思汉 on 17/7/27.
//  Copyright © 2017年 KKK. All rights reserved.
//

#import "PostAccountLogin.h"

@implementation PostAccountLogin
{
    NSString *_username;
    NSString *_password;
    NSString *_isTemp;
}
- (id)initWithusername:(NSString *)username password:(NSString *)password isTemp:(NSString *)isTemp{
    self = [super init];
    if (self) {
        _username = username;
        _password = password;
        _isTemp = isTemp;
    }
    return self;
}
- (NSString *)requestUrl {
    // “http://www.yuantiku.com” 在 YTKNetworkConfig 中设置，这里只填除去域名剩余的网址信息
    return @"/v1/account/login";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (id)requestArgument {
    DLog(@"%@",[_password getMD5]);
    return [self returnUrlArgumentsFilterParams:@{
                                                  @"username": _username,
                                                  @"password": _password,
                                                  @"isTemp":_isTemp
                                                  }];
}

@end
