//
//  CommonRequest.m
//  蓦然
//
//  Created by LuoNeo on 15/11/24.
//  Copyright © 2015年 com.carestream. All rights reserved.
//

#import "CommonRequest.h"

@implementation CommonRequest

static NSURLSessionDataTask *requestTask;

-(void)sendRequest:(NSMutableURLRequest *)request
          delegate:(id<CommonRequestDelegate>)delegate{
    if(urlConnection){
        [urlConnection cancel];
    }
    self.delegate=delegate;
    urlConnection=[[NSURLConnection alloc] initWithRequest:request
                                                       delegate:self
                                               startImmediately:YES];
}

-(void)sendRequest:(NSMutableURLRequest *)request complete:(RequestCompleteBlock)complete failed:(RequestFailedBlock)failed{
    
    if(urlConnection){
        [urlConnection cancel];
    }
    
    completeFunc=complete;
    failedFunc=failed;
    
    urlConnection=[[NSURLConnection alloc] initWithRequest:request
                                                  delegate:self
                                          startImmediately:YES];
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    NSHTTPURLResponse *httpResponse=(NSHTTPURLResponse *)response;
    if(httpResponse.statusCode==200){
        receivedData=[NSMutableData data];
    }
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    receivedData=[NSMutableData data];
    [receivedData appendData:data];
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    if(completeFunc){
        completeFunc(receivedData);
    }
    if(self.delegate && [self.delegate respondsToSelector:@selector(requestSuccess:data:)]){
        [self.delegate requestSuccess:self data:receivedData];
    }
}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    if(failedFunc){
        failedFunc(error);
    }
    if(self.delegate && [self.delegate respondsToSelector:@selector(requestFailed:error:)]){
        [self.delegate requestFailed:self error:error];
    }
}

@end
