//
//  GBMRegisterRequest.h
//  蓦然
//
//  Created by LuoNeo on 15/11/22.
//  Copyright © 2015年 com.carestream. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GBMUserModel.h"
#import "BLMultipartForm.h"
#import "CommonParser.h"

@class GBMRegisterRequest;
@protocol GBMRegisterRequestDelegate<NSObject>

-(void)registerRequestSuccess:(GBMRegisterRequest *)request user:(GBMUserModel *)user;
-(void)registerRequestFailed:(GBMRegisterRequest *)request error:(NSError *)error;

@end

@interface GBMRegisterRequest : NSObject<NSURLConnectionDataDelegate>

@property (nonatomic, strong) NSURLConnection *urlConnection;
@property (nonatomic, strong) NSMutableData *receivedData;
@property (nonatomic,assign)id<GBMRegisterRequestDelegate> delegate;

- (void)sendRegisterRequestWithUserName:(NSString *)username
                                  email:(NSString *)email
                               password:(NSString *)password
                                   gbid:(NSString *)gbid
                               delegate:(id<GBMRegisterRequestDelegate>)delegate;


@end
