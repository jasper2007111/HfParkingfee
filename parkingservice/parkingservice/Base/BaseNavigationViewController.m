//
//  BaseNavigationViewController.m

//

#import "BaseNavigationViewController.h"

@interface BaseNavigationViewController ()

@end

@implementation BaseNavigationViewController

+ (void)initialize {
    UINavigationBar *bar = [UINavigationBar appearance];
//    [bar setBackgroundImage:[UIImage imageNamed:@"navBar_bg_414x70"] forBarMetrics:UIBarMetricsDefault];
    [bar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
}

- (void)viewDidLoad {
    [super viewDidLoad];
 
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
        if (self.childViewControllers.count) {
            
            //隐藏tabbar
            viewController.hidesBottomBarWhenPushed = YES;
            
            //返回按钮
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setImage:[UIImage imageNamed:@"后退"] forState:UIControlStateNormal];
            [btn sizeToFit];
            [btn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
            viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
            
            //防止侧滑失效
            __weak __typeof(viewController)weakSelf = viewController;
            self.interactivePopGestureRecognizer.delegate = (id)weakSelf;
    }
    
    [super pushViewController:viewController animated:animated];

}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated {
    
    if (self.viewControllers.count <=2) {
        self.tabBarController.tabBar.hidden = NO;
    }
    UIViewController *resultVC = [super popViewControllerAnimated:animated];
    return resultVC;
}

#pragma mark- Action

- (void)back:(id)sender {
    if ((self.presentedViewController || self.presentingViewController) && self.childViewControllers.count == 1) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else {
        [self popViewControllerAnimated:YES];
    }
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
