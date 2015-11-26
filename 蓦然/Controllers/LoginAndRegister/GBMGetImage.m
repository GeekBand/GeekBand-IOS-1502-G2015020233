//
//  GBMGetImage.m
//  蓦然
//
//  Created by LuoNeo on 15/11/23.
//  Copyright © 2015年 com.carestream. All rights reserved.
//

#import "GBMGetImage.h"

@implementation GBMGetImage

-(void)getHeadImg:(GBMUserModel *)user{
    NSString *headUrl=[MoranAPI  headImg];
    NSString *urlString=[NSString stringWithFormat:@"%@?user_id=%@",headUrl,user.userId];
    
    NSString *encodeUrlString=[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url=[NSURL URLWithString:encodeUrlString];
    NSMutableURLRequest *request=[[NSMutableURLRequest alloc] initWithURL:url];
    request.HTTPMethod=@"GET";
    request.timeoutInterval=60;
    request.cachePolicy=NSURLRequestReloadIgnoringLocalAndRemoteCacheData;
    
    BLMultipartForm *form=[[BLMultipartForm alloc] init];
    
    request.HTTPBody=[form httpBody];
    [request setValue:form.contentType forHTTPHeaderField:@"Content-Type"];
    
    CommonRequest *requestTask=[[CommonRequest alloc] init];
    [requestTask sendRequest:request delegate:self];
}

-(void)requestSuccess:(CommonRequest *)request data:(NSData *)data{
    if(self.imgView){
        self.imgView.image=[[UIImage alloc] initWithData:data];
    }
}

-(void)requestFailed:(CommonRequest *)request error:(NSError *)error{
    NSLog(@"获取头像失败: %@",error);
}
@end
