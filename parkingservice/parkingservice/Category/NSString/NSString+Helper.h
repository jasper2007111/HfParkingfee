//
//  NSString+Helper.h
//  shuxiang
//
//  Created by 方燕娇 on 16/11/11.
//  Copyright © 2016年 Addison. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Helper)

- (NSString *)getMD5;
- (BOOL)isTelNumber;
- (NSString*)trim;
- (BOOL)isEmail;
- (NSString *)showAsteriskFromIndex:(NSUInteger)startIndex to:(NSUInteger)finIndex;

@end
