//
//  GBMLoginViewController.h
//  蓦然
//
//  Created by LuoNeo on 15/11/19.
//  Copyright © 2015年 com.carestream. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GBMUserModel.h"
#import "GBMLoginRequest.h"
#import "CommonTools.h"
#import "AppDelegate.h"

@interface GBMLoginViewController : UIViewController<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *psdTextField;
@property (nonatomic,strong) GBMLoginRequest *loginRequest;
- (IBAction)loginBtnClicked:(id)sender;
- (IBAction)touchDownAction:(id)sender;
- (IBAction)imgTouchDownAction:(id)sender;

@end
