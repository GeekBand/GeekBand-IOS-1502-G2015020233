//
//  GBMRegisterViewController.h
//  蓦然
//
//  Created by LuoNeo on 15/11/21.
//  Copyright © 2015年 com.carestream. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonTools.h"
#import "GBMRegisterRequest.h"

@interface GBMRegisterViewController : UIViewController<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIButton *registerBtn;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *psdTextField;
@property (weak, nonatomic) IBOutlet UITextField *repeatPsdTextField;
@property (nonatomic,strong) GBMRegisterRequest *registerRequest;
- (IBAction)registerBtnClicked:(id)sender;
- (IBAction)loginBtnClicked:(id)sender;
- (IBAction)ViewCtrlClicked:(id)sender;
- (IBAction)imgCtrlClicked:(id)sender;
@end
