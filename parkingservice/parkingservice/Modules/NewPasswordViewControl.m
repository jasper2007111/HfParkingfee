//
//  NewPasswordViewControl.m
//  huafangcase
//


#import "NewPasswordViewControl.h"
#import "Putaccountverify.h"
#import "LoginViewControl.h"

@interface NewPasswordViewControl ()
@property (strong, nonatomic) IBOutlet UITextField *code;
@property (strong, nonatomic) IBOutlet UITextField *password1;
@property (strong, nonatomic) IBOutlet UITextField *password2;

@end

@implementation NewPasswordViewControl

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTrans:@"设置新密码"];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)sure:(id)sender {
    [self requestPutaccountverify];
}

- (void)requestPutaccountverify{
    if ([self.password1.text isEqualToString:_password2.text]==0) {
        [self showErrorWithMsg:@"密码输入不一致"];
    }
    if(self.password1.text.length==0)
        [self showErrorWithMsg:@"请输入密码"];
    Putaccountverify *api = [[Putaccountverify alloc]initWithusername:_name code:_code.text password:[_password2.text getMD5]];
    JF_WS(weakSelf);
    [api sk_startWithWithSuccessBlock:^(YTKBaseRequest *request) {
        
        DLog(@"%@",request.responseJSONObject);
        // 你可以直接在这里使用 self
        LoginViewControl *control = [[LoginViewControl alloc]initWithNibName:@"LoginViewControl" bundle:nil];
       [ weakSelf presentViewController:control animated:YES completion:^{
            
        }];
    }  errorBlock:^(YTKBaseRequest *request) {
        [weakSelf showInfoWithMsg:request.message];
        
        
    } failureBlock:^(NSString *message) {
    }];
    
    
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
