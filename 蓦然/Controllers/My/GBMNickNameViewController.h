//
//  GBMNickNameViewController.h
//  蓦然
//
//  Created by LuoNeo on 15/11/23.
//  Copyright © 2015年 com.carestream. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonTools.h"
#import "MoranAPI.h"
#import "CommonRequest.h"
#import "GBMUserModel.h"
#import "AppDelegate.h"
#import "BLMultipartForm.h"

@interface GBMNickNameViewController : UIViewController<CommonRequestDelegate>

@property (weak, nonatomic) IBOutlet UITextField *changedNickName;
@property (nonatomic,strong) CommonRequest *commonRequest;

- (IBAction)doneBtnClicked:(id)sender;

@end
