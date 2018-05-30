//
//  PostHeadpicApi.m
//  mat
//
//  Created by 柯思汉 on 17/7/13.
//  Copyright © 2017年 hfy. All rights reserved.
//

#import "PostHeadpicApi.h"
#import <AFNetworking.h>
@implementation PostHeadpicApi
{
    UIImage *_headImage;
    NSString *_userID; // 用户id
    NSString *_nickName; // 名字
    NSString *_gender; // 性别
    NSString *_birthday; // 生日生日格式’2017-12-31’

}
- (id)initWithImage:(UIImage *)headImage userID:(NSString *)userID nickName:(NSString *)nickName gender:(NSString *)gender birthday:(NSString *)birthday;
{
    self = [super init];
    if (self) {
        _headImage = headImage;
        if ([userID isNotBlank]) {
            _userID = userID;
        }else{
            _userID = @"0";
        }
        _nickName =nickName;
        _gender=gender;
        _birthday=birthday;
    }
    return self;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (NSString *)requestUrl {
    //    "http://shuxiang.admin.listcloud.cn/admin.php?m=appupload&f=growth"
    return AG_MOBILE_USER;
}

- (AFConstructingBlock)constructingBodyBlock {
    if (_headImage) {
        return ^(id<AFMultipartFormData> formData) {
            
            NSData *data = UIImageJPEGRepresentation(_headImage, 0.5);
            NSString *name = @"header.png";
            NSString *formKey = @"headImage";
            NSString *type = @"image/png";
            [formData appendPartWithFileData:data name:formKey fileName:name mimeType:type];
        };
    }
    return nil;
}

- (NSString *)responseImageId {
    NSArray *array = self.content;
    NSDictionary *dict = array[0];
    return dict[@"image"];
}

- (id)requestArgument {
    
    _birthday =[BirthdayFormat Birthday:_birthday];
    
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:_userID forKey:@"userID"];
    [dic setValue:_nickName forKey:@"nickName"];
    [dic setValue:_gender forKey:@"gender"];
    [dic setValue:_birthday forKey:@"birthday"];
    [dic setValue:@"headImage" forKey:@"name"];
    return [self returnUrlArgumentsFilterParams:dic];
    
}

@end
