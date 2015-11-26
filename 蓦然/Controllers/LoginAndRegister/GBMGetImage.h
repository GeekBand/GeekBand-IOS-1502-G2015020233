//
//  GBMGetImage.h
//  蓦然
//
//  Created by LuoNeo on 15/11/23.
//  Copyright © 2015年 com.carestream. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GBMUserModel.h"
#import "CommonRequest.h"
#import "MoranAPI.h"
#import "BLMultipartForm.h"

@interface GBMGetImage : NSObject<CommonRequestDelegate>

@property (nonatomic, weak) UIImageView *imgView;

-(void) getHeadImg:(GBMUserModel *)user;

@end
