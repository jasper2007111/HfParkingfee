//
//  PostHeadpicApi.h
//  mat
//
//  Created by 柯思汉 on 17/7/13.
//  Copyright © 2017年 hfy. All rights reserved.
//

#import "YTKUrlArgumentsFilter.h"

@interface PostHeadpicApi : YTKUrlArgumentsFilter
- (id)initWithImage:(UIImage *)headImage userID:(NSString *)userID nickName:(NSString *)nickName gender:(NSString *)gender birthday:(NSString *)birthday;
- (NSString *)responseImageId;
@end
