//
//  CommonRequest.h
//  蓦然
//
//  Created by LuoNeo on 15/11/24.
//  Copyright © 2015年 com.carestream. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^RequestCompleteBlock)(NSData *);
typedef void(^RequestFailedBlock)(NSError *);

@class CommonRequest;
@protocol CommonRequestDelegate<NSObject>

-(void)requestSuccess:(CommonRequest *)request data:(NSData *)data;
-(void)requestFailed:(CommonRequest *)request error:(NSError *)error;

@end

@interface CommonRequest : NSObject<NSURLConnectionDataDelegate>{
    NSURLConnection *urlConnection;
    NSMutableData *receivedData;
    RequestCompleteBlock completeFunc;
    RequestFailedBlock failedFunc;
}

@property (nonatomic,assign)id<CommonRequestDelegate> delegate;


-(void)sendRequest:(NSMutableURLRequest *)request
          delegate:(id<CommonRequestDelegate>)delegate;

-(void)sendRequest:(NSMutableURLRequest *)request
          complete:(RequestCompleteBlock)complete
            failed:(RequestFailedBlock)failed;
@end
