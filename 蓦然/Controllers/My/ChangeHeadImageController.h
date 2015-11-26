//
//  ChangeHeadImageController.h
//  蓦然
//
//  Created by LuoNeo on 15/11/25.
//  Copyright © 2015年 com.carestream. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "GBMUserModel.h"
#import "CommonTools.h"
#import "CommonRequest.h"

@interface ChangeHeadImageController : UIViewController<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,CommonRequestDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imgPreview;
@property (strong,nonatomic) UIImagePickerController* pickerController;
@property (nonatomic,strong) CommonRequest *commonRequest;

- (IBAction)changeHeadImgBtnClicked:(id)sender;
- (IBAction)comfirmBtnClicked:(id)sender;

@end
