//
//  SquareViewController.h
//  蓦然
//
//  Created by LuoNeo on 15/11/27.
//  Copyright © 2015年 com.carestream. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "GBMUserModel.h"
#import "CommonParser.h"
#import "SquareModel.h"
#import "Picture.h"
#import "SquareTableViewCell.h"
#import <CoreLocation/CoreLocation.h>
#import "CommonTools.h"

@interface SquareViewController : UITableViewController<CLLocationManagerDelegate>

@property (nonatomic, strong) NSMutableArray *addrArray;
@property (nonatomic, strong) NSMutableArray *picArray;
@property (nonatomic, strong) NSDictionary *dataDic;
@property (nonatomic, copy) NSString *picUrl;
@property (nonatomic, copy) NSString *picId;
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) NSMutableDictionary *locationDic;

@end
