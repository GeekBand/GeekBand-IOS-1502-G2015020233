//
//  GBMMyViewController.h
//  蓦然
//
//  Created by LuoNeo on 15/11/22.
//  Copyright © 2015年 com.carestream. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GBMGetImage.h"
#import "AppDelegate.h"
#import "GBMUserModel.h"
#import "CommonRequest.h"
#import "CommonTools.h"

@interface GBMMyViewController : UITableViewController<CommonRequestDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *headImgView;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *emailLbl;
@property (nonatomic,strong) CommonRequest *commonRequest;

- (IBAction)logoutBtnClicked:(id)sender;
@end
