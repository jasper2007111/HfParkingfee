//
//  PostAccountLogin.h
//  huafangcase
//
//  Created by 柯思汉 on 17/7/27.
//  Copyright © 2017年 KKK. All rights reserved.
//

#import "YTKUrlArgumentsFilter.h"

@interface PostAccountLogin : YTKUrlArgumentsFilter
- (id)initWithusername:(NSString *)username password:(NSString *)password isTemp:(NSString*)isTemp;
@end
