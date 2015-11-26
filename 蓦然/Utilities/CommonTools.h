//
//  CommonTools.h
//  蓦然
//
//  Created by LuoNeo on 15/11/22.
//  Copyright © 2015年 com.carestream. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CommonTools : NSObject

+(BOOL)isValidEmail:(NSString *)email;
+(BOOL)isvalidPassword:(NSString *)password;
+(void)showConfirmMessage:(UIViewController *)uiView
                  message:(NSString *)msg
                  confirm:(void(^)(void))callback
                   cancel:(void(^)(void))cancel;
+(void)showMessage:(UIViewController *)uiView
           message:(NSString *)msg
          complete:(void(^)(void))confirm;
+(void)showMessage:(UIViewController *)uiView message:(NSString *)msg;
+(NSString *)gbid;
@end
