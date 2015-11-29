//
//  Picture.h
//  蓦然
//
//  Created by LuoNeo on 15/11/27.
//  Copyright © 2015年 com.carestream. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Picture : NSObject

@property(nonatomic,copy) NSString *pic_link;
@property(nonatomic,copy) NSString *pic_id;
@property(nonatomic,copy) NSString *title;

-(void)setValue:(id)value forUndefinedKey:(NSString *)key;

@end
