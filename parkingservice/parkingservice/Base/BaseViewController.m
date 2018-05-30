//
//  BaseViewController.m
//  mat
//
//  Created by 方燕娇 on 2017/6/28.
//  Copyright © 2017年 hfy. All rights reserved.
//

#import "BaseViewController.h"
#import "UserData.h"
@interface BaseViewController ()
@property (nonatomic,strong)UIImageView *imageView;
@property (nonatomic,strong)NSTimer *timer;
@end

@implementation BaseViewController

- (void)viewDidAppear:(BOOL)animated
{
    NSString *name =[[NSString alloc]initWithFormat:@"%@",NSStringFromClass([self class])];
    NSDictionary *LocalVCName =[[NSDictionary alloc]initWithObjectsAndKeys:name,@"LocalVCName", nil];
    [UserData setDefults:LocalVCName];
    
    
}
- (void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航栏
    [self creatNavView];
    [self creatUI];
    //获取当前页面文件名
    KFLog(@"LocalVCName::========== %@ ========",NSStringFromClass([self class]));
//    self.view.backgroundColor = kBackGroundColor;
    
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
}
#pragma mark- 初始化UI

- (void)creatUI {
    
//    self.view.backgroundColor = kBackGroundColor;
    _imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT)];
    _imageView.image=[UIImage imageNamed:@"viewBg"];
    [self.view addSubview:_imageView];
    [self.view sendSubviewToBack:_imageView];
}
///设置右边导航栏
- (void)setRightNavgationItemNormalImage:(NSString *)imageName title:(NSString *)title action:(SEL)action;
{
    [self setRightNavgationItemNormalImage:imageName title:title frame:CGRectMake(0, 0, 80, 44) action:action];
}
///设置右边导航栏(加frame)
- (void)setRightNavgationItemNormalImage:(NSString *)imageName title:(NSString *)title frame:(CGRect)frame action:(SEL)action {
    
    [self setRightNavgationItemNormalImage:imageName title:title frame:frame action:action textColor:[UIColor whiteColor]];
}
///设置右边导航栏(加frame、文字颜色)
- (void)setRightNavgationItemNormalImage:(NSString *)imageName title:(NSString *)title frame:(CGRect)frame action:(SEL)action textColor:(UIColor *)textColor{
    
    UIButton *btn = [[UIButton alloc] initWithFrame:frame];
    if (imageName) {
        [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    }
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:textColor forState:UIControlStateNormal];
    [btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [btn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = barButtonItem;
}

//删除背景图片
- (void)RemoveBackimage
{
    [_imageView removeFromSuperview];
}
///导航栏
- (void)creatNavView {
    
    //背景颜色
    self.navigationController.navigationBar.barTintColor =KF_RGB(48, 148, 247);
    self.navigationController.view.backgroundColor = kBackGroundColor;
    
    //返回按钮
    if (self.navigationController.viewControllers.count > 1 || self.presentingViewController) {
        [self setLeftNavgationItemNormalImage:@"后退" title:@"" action:@selector(goBackAction)];
    }
    
    //Title
    UIColor *color = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:color}];
    
    //默认透明
    self.navTranslucent = YES;
    
    
}
///设置导航栏透明
- (void)setTrans:(NSString *)title {

    //隐藏导航栏文字
    self.navigationItem.title=title;
    //设置导航栏背景图片为一个空的image，这样就透明了
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    
    //去掉透明后导航栏下边的黑边
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
}
#pragma mark- HUD

- (void)showLoadingTipWithMsg:(NSString *)msg{
    [SVProgressHUD showWithStatus:msg];
}

- (void)endLoadingTip{
    [SVProgressHUD dismiss];
}

- (void)showSuccessWithMsg:(NSString *)msg{
    [_timer invalidate];
    _timer =[NSTimer scheduledTimerWithTimeInterval:0.8 target:self selector:@selector(dismis:) userInfo:nil repeats:YES ];
    [SVProgressHUD showSuccessWithStatus:msg];
}

- (void)showErrorWithMsg:(NSString *)msg{
    [_timer invalidate];
    _timer =[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(dismis:) userInfo:nil repeats:YES ];
    [SVProgressHUD showErrorWithStatus:msg];
}

- (void)showInfoWithMsg:(NSString *)msg{
    [_timer invalidate];
    _timer =[NSTimer scheduledTimerWithTimeInterval:0.8 target:self selector:@selector(dismis:) userInfo:nil repeats:YES ];
    [SVProgressHUD showInfoWithStatus:msg];
}


- (void)showInfoWithMsg:(NSString *)msg andImage:(UIImage *)image{
    [_timer invalidate];
    _timer =[NSTimer scheduledTimerWithTimeInterval:0.6 target:self selector:@selector(dismis:) userInfo:nil repeats:YES ];
    [SVProgressHUD showImage:image status:msg];
}
- (void)dismis:(NSTimer*)timer
{
    [_timer invalidate];
    _timer = nil;
     [SVProgressHUD dismiss];
}
#pragma mark- Action

- (void)goBackAction {
    [self.navigationController popViewControllerAnimated:YES];
}
///设置左边导航栏
- (void)setLeftNavgationItemNormalImage:(NSString *)imageName title:(NSString *)title action:(SEL)action {
    [self setLeftNavgationItemNormalImage:imageName title:title frame:CGRectMake(0, 0, 80, 44) action:action];
}
///设置左边导航栏（加frame）
- (void)setLeftNavgationItemNormalImage:(NSString *)imageName title:(NSString *)title frame:(CGRect)frame  action:(SEL)action {
    
    UIButton *btn = [[UIButton alloc] initWithFrame:frame];
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [btn setTitleColor:KF_RGB(61, 61, 61) forState:UIControlStateNormal];
    [btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [btn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = barButtonItem;
}
-(CGSize)calculateContentFloat:(NSString *)content size:(CGSize)size font:(UIFont *)font
{
    NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil];
    CGSize lalSize=[content boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    return lalSize;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+(NSString *)getCountDownStringWithEndTime:(NSString *)endTime {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *now = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];//设置时区
    NSInteger interval = [zone secondsFromGMTForDate: now];
    NSDate *localDate = [now  dateByAddingTimeInterval: interval];
    
    NSDate *endDate = [dateFormatter dateFromString:endTime];
    NSInteger endInterval = [zone secondsFromGMTForDate: endDate];
    NSDate *end = [endDate dateByAddingTimeInterval: endInterval];
    NSUInteger voteCountTime = (NSInteger)([end timeIntervalSinceDate:localDate])/3600;
    
    NSString *timeStr = [NSString stringWithFormat:@"%ld", voteCountTime];
    
    return timeStr;
}
// 将字典或者数组转化为JSON串
- (NSString *)dictionaryToJSONString:(NSDictionary *)dictionary
{
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonString;
}
- (NSString *)arrayToJSONString:(NSArray *)array
{
    NSError *error = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    return jsonString;
}
//强制转屏
- (void)interfaceOrientation:(UIInterfaceOrientation)orientation
{
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        SEL selector  = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        int val = orientation;
        // 从2开始是因为0 1 两个参数已经被selector和target占用
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
    }
}
-(void)dealloc{
     //获取当前页面文件名
    KFLog(@"DeallocVCName::======== %@ =======",NSStringFromClass([self class]));

}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
