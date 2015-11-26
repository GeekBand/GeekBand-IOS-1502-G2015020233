//
//  GBMRegisterViewController.m
//  蓦然
//
//  Created by LuoNeo on 15/11/21.
//  Copyright © 2015年 com.carestream. All rights reserved.
//

#import "GBMRegisterViewController.h"

@interface GBMRegisterViewController ()<GBMRegisterRequestDelegate>

@end

@implementation GBMRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.registerBtn.layer.cornerRadius=5.0;
    self.registerBtn.clipsToBounds=YES;
    
    self.userNameTextField.delegate=self;
    self.emailTextField.delegate=self;
    self.psdTextField.delegate=self;
    self.repeatPsdTextField.delegate=self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)registerBtnClicked:(id)sender {
    NSString *userName=self.userNameTextField.text;
    NSString *email=self.emailTextField.text;
    NSString *psd=self.psdTextField.text;
    NSString *repeatPsd=self.psdTextField.text;
    if([userName length]==0||
       [email length]==0||
       [psd length]==0||
       [repeatPsd length]==0){
        [CommonTools showMessage:self message:@"请完整填写用户名，邮箱和密码"];
    }else if (![CommonTools isValidEmail:email]){
        [CommonTools showMessage:self message:@"请填写正确的电子邮件"];
    }else if (![psd isEqualToString:repeatPsd]){
        [CommonTools showMessage:self message:@"两次输入的密码不一致，请重新输入"];
    }else if(![CommonTools isvalidPassword:psd]){
        [CommonTools showMessage:self message:@"密码格式错误，请输入6至20位的密码"];
    }else{
        [self registerHandle];
    }
}

- (IBAction)loginBtnClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (IBAction)ViewCtrlClicked:(id)sender {
    [self.userNameTextField resignFirstResponder];
    [self.emailTextField resignFirstResponder];
    [self.psdTextField resignFirstResponder];
    [self.repeatPsdTextField resignFirstResponder];
    
    self.view.frame=CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height);
}

- (IBAction)imgCtrlClicked:(id)sender {
    [self.userNameTextField resignFirstResponder];
    [self.emailTextField resignFirstResponder];
    [self.psdTextField resignFirstResponder];
    [self.repeatPsdTextField resignFirstResponder];
    
    self.view.frame=CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height);
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    self.view.frame=CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height);
    return YES;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    CGRect frame=textField.frame;
    
    int offset=frame.origin.y+85-(self.view.frame.size.height-216);
    if(offset>0){
        NSTimeInterval animationDuration=0.30f;
        [UIView beginAnimations:@"ResizeForKeyboards" context:nil];
        [UIView setAnimationDuration:animationDuration];
        
        self.view.frame=CGRectMake(0, -offset, self.view.frame.size.width, self.view.frame.size.height);
        
        [UIView commitAnimations];
    }
}
-(void)registerHandle{
    NSString *userName=self.userNameTextField.text;
    NSString *email=self.emailTextField.text;
    NSString *psd=self.psdTextField.text;
    NSString *gbid=[CommonTools gbid];
    self.registerRequest=[[GBMRegisterRequest alloc] init];
    [self.registerRequest sendRegisterRequestWithUserName:userName
                                                    email:email
                                                 password:psd
                                                     gbid:gbid
                                                 delegate:self];
}

-(void)registerRequestSuccess:(GBMRegisterRequest *)request user:(GBMUserModel *)user{
    if([user.registerReturnMessage isEqualToString:@"Register success"]){
        [CommonTools showMessage:self
                         message:@"注册成功，请登录"
                        complete:^(){[self dismissViewControllerAnimated:YES completion:nil];}];
    }else{
        [CommonTools showMessage:self message:user.loginReturnMessage];
    }
}

-(void)registerRequestFailed:(GBMRegisterRequest *)request error:(NSError *)error{
    NSLog(@"注册失败:%@",error);
}

@end














