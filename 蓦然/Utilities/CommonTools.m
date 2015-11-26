//
//  CommonTools.m
//  蓦然
//
//  Created by LuoNeo on 15/11/22.
//  Copyright © 2015年 com.carestream. All rights reserved.
//

#import "CommonTools.h"

@implementation CommonTools

+(BOOL)isValidEmail:(NSString *)email{
    NSString *emailRegex=@"^[\\w-]+@[\\w-]+\\.[a-zA-Z]{2,4}$";
    NSPredicate *emailTest=[NSPredicate predicateWithFormat:@"SELF MATCHES %@",emailRegex];
    return [emailTest evaluateWithObject:email];
}

+(BOOL)isvalidPassword:(NSString *)password{
    NSString *passwordRegex=@"^.{6,20}$";
    NSPredicate *psdTest=[NSPredicate predicateWithFormat:@"SELF MATCHES %@",passwordRegex];
    return [psdTest evaluateWithObject:password];
}

+(void)showMessage:(UIViewController *)uiView
           message:(NSString *)msg
          complete:(void(^)(void))callback{
    //    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil
    //                                                  message:msg
    //                                                 delegate:nil
    //                                        cancelButtonTitle:@"确定"
    //                                        otherButtonTitles:nil];
    //    [alert show];
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:nil
                                                                   message:msg
                                                            preferredStyle:UIAlertControllerStyleAlert
                                ];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"确定"
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
                                                              if(callback){
                                                                  callback();
                                                              }
                                                          }];
    
    [alert addAction:defaultAction];
    [uiView presentViewController:alert animated:YES completion:nil];
}

+(void)showMessage:(UIViewController *)uiView message:(NSString *)msg{
    [self showMessage:uiView message:msg complete:nil];
}
+(NSString *)gbid{
    return @"G2015020233";
}
@end
