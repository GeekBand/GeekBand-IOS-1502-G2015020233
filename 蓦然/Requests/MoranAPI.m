//
//  MoranAPI.m
//  蓦然
//
//  Created by LuoNeo on 15/11/24.
//  Copyright © 2015年 com.carestream. All rights reserved.
//

#import "MoranAPI.h"

@implementation MoranAPI

+(NSString *)login{
    return @"http://moran.chinacloudapp.cn/moran/web/user/login";
}
+(NSString *)regist{
    return @"http://moran.chinacloudapp.cn/moran/web/user/register";
}
+(NSString *)headImg{
    return @"http://moran.chinacloudapp.cn/moran/web/user/show";
}
+(NSString *)rename{
    return @"http://moran.chinacloudapp.cn/moran/web/user/rename";
}
@end
