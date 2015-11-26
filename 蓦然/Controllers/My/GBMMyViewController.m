//
//  GBMMyViewController.m
//  蓦然
//
//  Created by LuoNeo on 15/11/22.
//  Copyright © 2015年 com.carestream. All rights reserved.
//

#import "GBMMyViewController.h"

@interface GBMMyViewController ()

@end

@implementation GBMMyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.headImgView.layer.cornerRadius=self.headImgView.frame.size.width/2.0f;
    self.headImgView.clipsToBounds=YES;
    
    self.commonRequest=[[CommonRequest alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)viewDidAppear:(BOOL)animated{
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    GBMUserModel *user = app.user;
    
    self.nickNameLbl.text=user.userName;
    self.emailLbl.text=user.email;
    
    if(!user.image){
        NSString *headUrl=[MoranAPI  headImg];
        NSString *urlString=[NSString stringWithFormat:@"%@?user_id=%@",headUrl,user.userId];
        
        UIImage* serverImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString: @"http://www.baidu.com/img/bd_logo1.png"]]];
        user.image=serverImage;
    }
    self.headImgView.image=user.image;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    CGFloat header;
    if(section==0){
        header=13.0;
    }else if(section==1){
        header=10;
    }
    return header;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}

@end
