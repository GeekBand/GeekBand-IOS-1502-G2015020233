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

@interface ChangeHeadImageController : UIViewController<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imgPreview;
@property (strong,nonatomic) UIImagePickerController* pickerController;

- (IBAction)changeHeadImgBtnClicked:(id)sender;
- (IBAction)comfirmBtnClicked:(id)sender;

@end
