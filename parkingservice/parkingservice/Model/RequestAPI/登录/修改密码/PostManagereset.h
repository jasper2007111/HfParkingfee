//
//  PutAccountPassword.h
//  huafangcase
//
//  Created by 柯思汉 on 17/8/7.
//  Copyright © 2017年 KKK. All rights reserved.
//

#import "YTKUrlArgumentsFilter.h"

@interface PutAccountPassword : YTKUrlArgumentsFilter
- (id)initWithusername:(NSString *)username oldpassword:(NSString *)oldpassword newpassword:(NSString*)newpassword;
@end
