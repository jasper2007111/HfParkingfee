//
//  JFTabbar.m
//  JFMiaoBo
//


#import "JFTabbar.h"
#import "MyhomeVC.h"
#import "MybookVC.h"
#import "MyappVC.h"
#import "MyinformationVC.h"
#import "BaseViewController.h"
#import "BaseNavigationViewController.h"
#import "CusNavViewController.h"

#define JF_TabbarTitleNormolColor KF_RGB(153, 153, 153)//Tabbar文字正常颜色
#define JF_TabbarTitleSelectedColor KF_RGB(153, 153, 153) //Tabbar文字被选中颜色
#define JF_TabbarBackgroundColor KF_RGB(226, 224, 224) //Tabbar的背景颜色

@interface JFTabbar () <UIAlertViewDelegate>

@property (nonatomic, strong) NSDictionary *noticeInfo;

@end

@implementation JFTabbar

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self creatUI];
}

- (void)creatUI {
  
//
    [[UITabBar appearance] setBackgroundColor:[UIColor clearColor]];
    
    //首页
    [self addChildVC:[[MyhomeVC alloc] initWithNibName:@"MyhomeVC" bundle:nil] imageName:@"首页" selectImageName:@"首页-focus" title:@"首页"];
    //分类
    [self addChildVC:[[MybookVC alloc] initWithNibName:@"MybookVC" bundle:nil] imageName:@"通讯录" selectImageName:@"通讯录-focus" title:@"通讯录"];
    
    //个人中心
    [self addChildVC:[[MyappVC alloc] initWithNibName:@"MyappVC" bundle:nil] imageName:@"应用" selectImageName:@"应用-focus" title:@"应用"];
    
    [self addChildVC:[[MyinformationVC alloc] initWithNibName:@"MyinformationVC" bundle:nil]  imageName:@"我的" selectImageName:@"我的-focus" title:@"我的"];
}

- (void)addChildVC:(BaseViewController *)vc imageName:(NSString *)imageName selectImageName:(NSString *)selectImageName title:(NSString *)title {
    
    CusNavViewController *nav = [[CusNavViewController alloc] initWithRootViewController:vc];
    
    //设置图片
    vc.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];;
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:selectImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];;
    //设置图片偏移量
//    CGFloat margin = 5;
//    [vc.tabBarItem setImageInsets:UIEdgeInsetsMake(margin, 0, -margin, 0)];
    
    //设置标题
    vc.tabBarItem.title = title;
    [vc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:JF_TabbarTitleNormolColor} forState:UIControlStateNormal];
    [vc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:JF_TabbarTitleSelectedColor} forState:UIControlStateSelected];
    
    [self addChildViewController:nav];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
 
}

#pragma mark- 通知

- (void)networkDidReceiveMessage:(NSNotification *)notification {
    
    DLog(@"我大tabbar收到的通知：%@",notification.userInfo);
    self.noticeInfo = notification.userInfo;
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"收到一条消息" message:notification.userInfo[@"aps"][@"alert"] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
