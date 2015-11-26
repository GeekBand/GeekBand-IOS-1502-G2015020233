//
//  GBMLoginRequestParser.h
//  蓦然
//
//  Created by LuoNeo on 15/11/21.
//  Copyright © 2015年 com.carestream. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GBMUserModel.h"

@interface GBMLoginRequestParser : NSObject

-(GBMUserModel *)parseJson:(NSData *)data;

@end
