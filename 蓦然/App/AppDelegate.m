//
//  AppDelegate.m
//  蓦然
//
//  Created by LuoNeo on 15/11/19.
//  Copyright © 2015年 com.carestream. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    return YES;
}

-(void)logoutView{
    UIStoryboard *loginStoryboard=[UIStoryboard storyboardWithName:@"LoginAndRegister"
                                                         bundle:[NSBundle mainBundle]];
    UIViewController *loginVC = [loginStoryboard instantiateViewControllerWithIdentifier:@"LoginStoryboard"];
    
    self.loginViewController = loginVC;
    [self.tabBarController presentViewController:self.loginViewController
                                        animated:YES
                                      completion:nil];

    
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.tabBarController.view.alpha = 0;
                     }
                     completion:^(BOOL finished){
                         self.tabBarController = nil;
                         self.user = nil;
                     }
     ];
}

-(void)loadMainViewWithController:(GBMUserModel *)loginUser{
    
    self.user=loginUser;
    
    UINavigationController *nav1=[[UINavigationController alloc] init];
    nav1.navigationBar.barTintColor=[[UIColor alloc] initWithRed:230/255.0
                                                           green:106/255.0
                                                            blue:58/255.0
                                                           alpha:1];
    nav1.tabBarItem.title=@"广场";
    nav1.tabBarItem.image=[UIImage imageNamed:@"square"];
    
    UIStoryboard *myStoryboard=[UIStoryboard storyboardWithName:@"GBMMy"
                                                         bundle:[NSBundle mainBundle]];
    MyNavController *myVC=[myStoryboard instantiateViewControllerWithIdentifier:@"MyNavStoryboard"];
    myVC.navigationBar.barTintColor=[[UIColor alloc] initWithRed:230/255.0
                                                           green:106/255.0
                                                            blue:58/255.0
                                                           alpha:1];
    myVC.tabBarItem.title=@"我的";
    myVC.tabBarItem.image=[UIImage imageNamed:@"my"];
    
    self.tabBarController=[[UITabBarController alloc] init];
    self.tabBarController.viewControllers=@[nav1,myVC];
    
    [self.loginViewController presentViewController:self.tabBarController
                                           animated:YES
                                         completion:nil];
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.loginViewController.view.alpha=0;
                     }
                     completion:^(BOOL finished){
                         self.loginViewController=nil;
                     }
     ];
    
    UIButton *photoBtn=[[UIButton alloc] initWithFrame:CGRectMake(self.loginViewController.view.frame.size.width/2-60, -25, 120, 50)];
    [photoBtn setImage:[UIImage imageNamed:@"publish"] forState:UIControlStateNormal];
    [photoBtn addTarget:self action:@selector(addOrderView) forControlEvents:UIControlEventTouchUpInside];
    [self.tabBarController.tabBar addSubview:photoBtn];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end














