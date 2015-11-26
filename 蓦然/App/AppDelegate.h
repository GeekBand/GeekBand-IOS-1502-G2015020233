//
//  AppDelegate.h
//  蓦然
//
//  Created by LuoNeo on 15/11/19.
//  Copyright © 2015年 com.carestream. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GBMMyViewController.h"
#import "MyNavController.h"
#import "GBMUserModel.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UITabBarController *tabBarController;
@property (strong, nonatomic) UIViewController *loginViewController;
@property (strong, nonatomic) GBMUserModel *user;

-(void)loadMainViewWithController:(GBMUserModel *)loginUser;
-(void)logoutView;
@end

