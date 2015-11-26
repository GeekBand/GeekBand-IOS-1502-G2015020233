//
//  GBMRegisterRequest.m
//  蓦然
//
//  Created by LuoNeo on 15/11/22.
//  Copyright © 2015年 com.carestream. All rights reserved.
//

#import "GBMRegisterRequest.h"

@implementation GBMRegisterRequest

-(void)sendRegisterRequestWithUserName:(NSString *)username
                                 email:(NSString *)email
                              password:(NSString *)password
                                  gbid:(NSString *)gbid
                              delegate:(id<GBMRegisterRequestDelegate>)delegate
{
    [self.urlConnection cancel];
    self.delegate = delegate;
    
    NSString *urlString=@"http://moran.chinacloudapp.cn/moran/web/user/register";
    
    NSString *encodeUrlString=[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url=[NSURL URLWithString:encodeUrlString];
    NSMutableURLRequest *request=[[NSMutableURLRequest alloc] initWithURL:url];
    request.HTTPMethod=@"POST";
    request.timeoutInterval=60;
    request.cachePolicy=NSURLRequestReloadIgnoringLocalAndRemoteCacheData;
    
    BLMultipartForm *form=[[BLMultipartForm alloc] init];
    [form addValue:username forField:@"username"];
    [form addValue:email forField:@"email"];
    [form addValue:password forField:@"password"];
    [form addValue:gbid forField:@"gbid"];
    
    request.HTTPBody=[form httpBody];
    [request setValue:form.contentType forHTTPHeaderField:@"Content-Type"];
    self.urlConnection=[[NSURLConnection alloc] initWithRequest:request
                                                       delegate:self
                                               startImmediately:YES];
}
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    NSHTTPURLResponse *httpResponse=(NSHTTPURLResponse *)response;
    if(httpResponse.statusCode==200){
        self.receivedData=[NSMutableData data];
    }
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    self.receivedData=[NSMutableData data];
    [self.receivedData appendData:data];
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    NSString *string = [[NSString alloc] initWithData:self.receivedData encoding:NSUTF8StringEncoding];
    NSLog(@"received data string:%@",string);
    GBMUserModel *user=[[GBMUserModel alloc] init];
    user.registerReturnMessage=[CommonParser parseJson:self.receivedData];
    
    if([self.delegate respondsToSelector:@selector(registerRequestSuccess:user:)]){
        [self.delegate registerRequestSuccess:self user:user];
    }
}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    NSLog(@"error = %@",error);
    if([self.delegate respondsToSelector:@selector(registerRequestFailed:error:)]){
        [self.delegate registerRequestFailed:self error:error];
    }
}
@end













