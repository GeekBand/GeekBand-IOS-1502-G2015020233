//
//  CommonParser.m
//  蓦然
//
//  Created by LuoNeo on 15/11/22.
//  Copyright © 2015年 com.carestream. All rights reserved.
//

#import "CommonParser.h"

@implementation CommonParser

+(NSDictionary *)parseJson:(NSData *)data{
    NSError *error=nil;
    
    id jsonDic=[NSJSONSerialization JSONObjectWithData:data
                                               options:NSJSONReadingAllowFragments
                                                 error:&error
                ];
    if(error){
        NSLog(@"The common parser is not work");
    }else{
        if([[jsonDic class] isSubclassOfClass:[NSDictionary class]]){
            return (NSDictionary *)jsonDic;
        }
    }
    
    return [[NSDictionary alloc] init];
}

@end
