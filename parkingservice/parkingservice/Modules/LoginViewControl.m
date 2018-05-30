
//

#import "LoginViewControl.h"
#import "ForgetpswViewControl.h"
#import "PostAccountLogin.h"
#import "UserInfoModel.h"
#import "JFTabbar.h"

@interface LoginViewControl ()<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextField *name;
@property (strong, nonatomic) IBOutlet UITextField *password;
//*******记住密码按钮
@property (strong, nonatomic) IBOutlet UIButton *keeps;

@end

@implementation LoginViewControl

- (void)viewDidLoad {
    [super viewDidLoad];
    _name.delegate=self;
    _password.delegate=self;
    [self setTrans:@"登录"];
    NSDictionary *dic =[UserData getHistorical];
    self.name.text =dic[@"name"];
    self.password.text = dic[@"password"];
    if (self.name.text.length) {
        self.keeps.selected=YES;
    }
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillDisappear:(BOOL)animated
{
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
}


- (IBAction)forgetpsw:(id)sender {
    ForgetpswViewControl *control = [[ForgetpswViewControl alloc]initWithNibName:@"ForgetpswViewControl" bundle:nil];
    UINavigationController *nav =[[UINavigationController alloc]initWithRootViewController:control];
    [self presentViewController:nav animated:YES completion:^{
        
    }];
}
- (IBAction)login:(id)sender {
    if(_keeps.selected == YES)
    {
        NSDictionary *keep = [[NSDictionary alloc]initWithObjectsAndKeys:self.name.text,@"name",self.password.text,@"password", nil];
        [UserData setHistorical:keep];
    }
    else
    {
        [UserData removeHistory];
    }
    [self requestPostAccountLogin];
}
- (IBAction)Keep:(UIButton *)sender {
    sender.selected=!sender.selected;
    if(_keeps.selected == YES)
    {
        NSDictionary *keep = [[NSDictionary alloc]initWithObjectsAndKeys:self.name.text,@"name",self.password.text,@"password", nil];
        [UserData setHistorical:keep];
    }
    else
    {
        [UserData removeHistory];
    }
}


#pragma  mark uitextfiled delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString*)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

- (void)requestPostAccountLogin{
  
    [self showLoadingTipWithMsg:@"登录中"];
    PostAccountLogin *api = [[PostAccountLogin alloc] initWithusername:self.name.text password:[self.password.text getMD5] isTemp:@""];
    JF_WS(weakSelf);
    [api sk_startWithWithSuccessBlock:^(YTKBaseRequest *request) {
        
        DLog(@"%@",request.responseJSONObject);
        // 你可以直接在这里使用 self
        DLog(@"succeed");
        
        UserInfoModel *data =[UserInfoModel mj_objectWithKeyValues:request.responseJSONObject[@"content"]];
//
        [UserData setUserInfo:data];
    
        JFTabbar *control =[[JFTabbar alloc]init];
        control.modalTransitionStyle =UIModalTransitionStyleCrossDissolve;
        [[[UIApplication sharedApplication] delegate] window] .rootViewController = control;
        
        [weakSelf endLoadingTip];
    }  errorBlock:^(YTKBaseRequest *request) {
        [weakSelf showInfoWithMsg:request.message];
       
        
    } failureBlock:^(NSString *message) {
        [weakSelf showInfoWithMsg:@"登录失败"];
        [weakSelf endLoadingTip];
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
