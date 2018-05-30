//
//  BaseViewController.h
//  mat
//
//  Created by 方燕娇 on 2017/6/28.
//  Copyright © 2017年 hfy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController
{
    
}
///导航栏是否透明
@property (nonatomic, assign) BOOL navTranslucent;
// 点击返回时的事件
//- (void)popAction:(UIBarButtonItem *)barButtonItem;
/// 初始化导航栏
- (void)creatNavView;
- (void)goBackAction;
//强制转屏
- (void)interfaceOrientation:(UIInterfaceOrientation)orientation;
//删除背景图片
- (void)RemoveBackimage;

+(NSString *)getCountDownStringWithEndTime:(NSString *)endTime;
#pragma mark- 导航栏
- (void)setTrans:(NSString *)title;
///设置右边导航栏
- (void)setRightNavgationItemNormalImage:(NSString *)imageName title:(NSString *)title action:(SEL)action;

///设置左边导航栏
- (void)setLeftNavgationItemNormalImage:(NSString *)imageName title:(NSString *)title action:(SEL)action;

///设置右边导航栏(加frame)
- (void)setRightNavgationItemNormalImage:(NSString *)imageName title:(NSString *)title frame:(CGRect)frame action:(SEL)action;

///设置左边导航栏（加frame）
- (void)setLeftNavgationItemNormalImage:(NSString *)imageName title:(NSString *)title frame:(CGRect)frame  action:(SEL)action;

///设置右边导航栏(加frame、文字颜色)
- (void)setRightNavgationItemNormalImage:(NSString *)imageName title:(NSString *)title frame:(CGRect)frame action:(SEL)action textColor:(UIColor *)textColor;

//计算UIlabel 的内容高度
-(CGSize)calculateContentFloat:(NSString *)content size:(CGSize)size font:(UIFont *)font;
// 将字典或者数组转化为JSON串
- (NSString *)dictionaryToJSONString:(NSDictionary *)dictionary;
- (NSString *)arrayToJSONString:(NSArray *)array;
#pragma mark- HUD
/**
 *  带文字的HUD
 *
 *  @param msg 文字
 */
- (void)showLoadingTipWithMsg:(NSString *)msg;

/**
 *  结束HUD
 */
- (void)endLoadingTip;

/**
 *  显示成功后的HUD
 *
 *  @param msg 成功文字
 */
- (void)showSuccessWithMsg:(NSString *)msg;

/**
 *  显示失败后的HUD
 *
 *  @param msg 失败文字
 */
- (void)showErrorWithMsg:(NSString *)msg;

/**
 *  显示信息的HUD
 *
 *  @param msg 信息文字
 */
- (void)showInfoWithMsg:(NSString *)msg;

/**
 *  显示带文字和图片的HUD
 *
 *  @param msg   文字
 *  @param image 图片
 */
- (void)showInfoWithMsg:(NSString *)msg andImage:(UIImage *)image;


@end
