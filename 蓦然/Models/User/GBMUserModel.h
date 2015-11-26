//
//  GBMUserModel.h
//  蓦然
//
//  Created by LuoNeo on 15/11/21.
//  Copyright © 2015年 com.carestream. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface GBMUserModel : NSObject

@property (nonatomic,copy) NSString *userName;
@property (nonatomic,copy) NSString *email;
@property (nonatomic,copy) NSString *password;
@property (nonatomic,copy) NSString *loginReturnMessage;
@property (nonatomic,copy) NSString *registerReturnMessage;
@property (nonatomic,copy) NSString *token;
@property (nonatomic,copy) NSString *userId;
@property (nonatomic,strong) UIImage *image;

@end
