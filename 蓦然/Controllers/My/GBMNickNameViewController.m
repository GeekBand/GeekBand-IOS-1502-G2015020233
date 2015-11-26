//
//  GBMNickNameViewController.m
//  蓦然
//
//  Created by LuoNeo on 15/11/23.
//  Copyright © 2015年 com.carestream. All rights reserved.
//

#import "GBMNickNameViewController.h"

@interface GBMNickNameViewController ()

@end

@implementation GBMNickNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.commonRequest=[[CommonRequest alloc] init];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidAppear:(BOOL)animated{
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    GBMUserModel *user = app.user;
    self.changedNickName.text=user.userName;
}

- (IBAction)doneBtnClicked:(id)sender {
    NSString *changedNickName=self.changedNickName.text;
    if([changedNickName length]==0){
        [CommonTools showMessage:self message:@"请输入新的昵称"];
    }else{
        [self changeNikName:changedNickName];
    }
}

-(void)changeNikName:(NSString *)nickName{
    NSString *renameUrl=[MoranAPI  rename];
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    GBMUserModel *user = app.user;
    
    NSString *encodeUrlString=[renameUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url=[NSURL URLWithString:encodeUrlString];
    NSMutableURLRequest *request=[[NSMutableURLRequest alloc] initWithURL:url];
    request.HTTPMethod=@"POST";
    request.timeoutInterval=60;
    request.cachePolicy=NSURLRequestReloadIgnoringLocalAndRemoteCacheData;
    
    BLMultipartForm *form=[[BLMultipartForm alloc] init];
    [form addValue:user.userId forField:@"user_id"];
    [form addValue:user.token forField:@"token"];
    [form addValue:nickName forField:@"new_name"];
    
    request.HTTPBody=[form httpBody];
    [request setValue:form.contentType forHTTPHeaderField:@"Content-Type"];
    [self.commonRequest sendRequest:request delegate:self];
}
-(void)requestSuccess:(CommonRequest *)request data:(NSData *)data{
    NSString *nickName=self.changedNickName.text;
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    app.user.userName = nickName;
    [[self navigationController] popViewControllerAnimated:YES];
}

-(void)requestFailed:(CommonRequest *)request error:(NSError *)error{
    NSLog(@"error = %@",error);
    [[self navigationController] popViewControllerAnimated:YES];
}

@end








