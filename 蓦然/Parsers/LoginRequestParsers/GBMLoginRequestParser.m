//
//  GBMLoginRequestParser.m
//  蓦然
//
//  Created by LuoNeo on 15/11/21.
//  Copyright © 2015年 com.carestream. All rights reserved.
//

#import "GBMLoginRequestParser.h"

@implementation GBMLoginRequestParser

-(GBMUserModel *)parseJson:(NSData *)data{
    NSError *error=nil;
    
    id jsonDic=[NSJSONSerialization JSONObjectWithData:data
                                               options:NSJSONReadingAllowFragments
                                                 error:&error
                ];
    if(error){
        NSLog(@"The parser is not work");
    }else{
        GBMUserModel *user=[[GBMUserModel alloc] init];
        if([[jsonDic class] isSubclassOfClass:[NSDictionary class]]){
            
            id returnMessage=[jsonDic valueForKey:@"message"];
            if([[returnMessage class] isSubclassOfClass:[NSString class]]){
                user.loginReturnMessage=returnMessage;
            }
            
            id data=[jsonDic valueForKey:@"data"];
            if([[data class] isSubclassOfClass:[NSDictionary class]]){
                id userId=[data valueForKey:@"user_id"];
                if([[userId class] isSubclassOfClass:[NSString class]]){
                    user.userId=userId;
                }
                id token=[data valueForKey:@"token"];
                if([[token class] isSubclassOfClass:[NSString class]]){
                    user.token=token;
                }
                id userName=[data valueForKey:@"user_name"];
                if([[userName class] isSubclassOfClass:[NSString class]]){
                    user.userName=userName;
                }
            }
            return user;
        }
    }
    return nil;
}

@end
