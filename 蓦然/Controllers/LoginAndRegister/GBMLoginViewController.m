//
//  GBMLoginViewController.m
//  蓦然
//
//  Created by LuoNeo on 15/11/19.
//  Copyright © 2015年 com.carestream. All rights reserved.
//

#import "GBMLoginViewController.h"

@interface GBMLoginViewController ()<GBMLoginRequestDelegate>

@end

@implementation GBMLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.emailTextField.delegate=self;
    self.psdTextField.delegate=self;
    AppDelegate *app=(AppDelegate *)[UIApplication sharedApplication].delegate;
    app.loginViewController=self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginBtnClicked:(id)sender {
    NSString *userName=self.emailTextField.text;
    NSString *psd=self.psdTextField.text;
    if([userName length]==0||[psd length]==0){
        [CommonTools showMessage:self message:@"请输入邮箱和密码"];
    }else{
        [self loginHandle];
    }
}

- (IBAction)touchDownAction:(id)sender {
    [self.emailTextField resignFirstResponder];
    [self.psdTextField resignFirstResponder];
    self.view.frame=CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height);
}

- (IBAction)imgTouchDownAction:(id)sender {
    [self.emailTextField resignFirstResponder];
    [self.psdTextField resignFirstResponder];
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

-(void)loginHandle{
    NSString *email=self.emailTextField.text;
    NSString *psd=self.psdTextField.text;
    NSString *gbid=[CommonTools gbid];
    
    self.loginRequest=[[GBMLoginRequest alloc] init];
    [self.loginRequest sendLoginRequestWithEmail:email password:psd gbid:gbid delegate:self];
}

-(void)loginRequestSuccess:(GBMLoginRequest *)request user:(GBMUserModel *)user{
    if([user.loginReturnMessage isEqualToString:@"Login success"]){
        //NSLog(@"登录成功");
        AppDelegate *app=(AppDelegate *)[UIApplication sharedApplication].delegate;
        user.email=self.emailTextField.text;
        [app loadMainViewWithController:user];
        
    }else{
        NSLog(@"服务器报错:%@",user.loginReturnMessage);
    }
}
-(void)loginRequestFailed:(GBMLoginRequest *)request error:(NSError *)error{
    NSLog(@"登录失败:%@",error);
}
@end











