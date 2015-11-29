//
//  SquareViewController.m
//  蓦然
//
//  Created by LuoNeo on 15/11/27.
//  Copyright © 2015年 com.carestream. All rights reserved.
//

#import "SquareViewController.h"

@interface SquareViewController ()

@end

@implementation SquareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.locationDic=[NSMutableDictionary dictionary];
    self.locationManager=[[CLLocationManager alloc] init];
    self.locationManager.delegate=self;
    self.locationManager.desiredAccuracy=kCLLocationAccuracyBest;
    self.locationManager.distanceFilter=1000.0f;
    
    if([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0){
        [_locationManager requestWhenInUseAuthorization];
    }
    if([CLLocationManager locationServicesEnabled]){
        [self.locationManager startUpdatingLocation];
    }else{
        [CommonTools showMessage:self message:@"定位失败"];
    }
    
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"全部" forState:UIControlStateNormal];
    btn.frame=CGRectMake(0, 0, 200, 35);
    [btn addTarget:self action:@selector(titleBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [btn setImage:[UIImage imageNamed:@"icon_arrow_down"] forState:UIControlStateNormal];
    btn.imageEdgeInsets=UIEdgeInsetsMake(0, 133, 0, 0);
    btn.titleEdgeInsets=UIEdgeInsetsMake(0, 0, 0, 40);
    
    self.navigationItem.titleView=btn;
    [self requestAllData];
}

-(void)viewDidAppear:(BOOL)animated{
    
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    CLLocation *newLocation=[locations lastObject];
    
    self.locationDic = [NSMutableDictionary dictionary];
    
    CLLocationDegrees latitude = newLocation.coordinate.latitude;
    CLLocationDegrees longitude = newLocation.coordinate.longitude;
    
    NSString *latitudeString = [NSString stringWithFormat:@"%f", latitude];
    NSString *longitudeString = [NSString stringWithFormat:@"%f", longitude];
    
    [self.locationDic setValue:latitudeString forKey:@"latitude"];
    [self.locationDic setValue:longitudeString forKey:@"longitude"];
    
    CLLocation *c = [[CLLocation alloc]initWithLatitude:latitude longitude:longitude];
    CLGeocoder *revGeo = [[CLGeocoder alloc]init];
    
    [revGeo reverseGeocodeLocation:c
                 completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
                     if (!error && [placemarks count] > 0) {
                         NSDictionary *dict = [[placemarks objectAtIndex:0] addressDictionary];
                         NSLog(@"Street address %@", [dict objectForKey:@"Street"]);
                         [self.locationDic setValue:dict[@"Name"] forKey:@"location"];
                     } else {
                         NSLog(@"Error: %@", error);
                     }
                 }];
    [manager stopUpdatingLocation];

}

//- (void)locationManager:(CLLocationManager *)manager
//    didUpdateToLocation:(CLLocation *)newLocation
//           fromLocation: (CLLocation *)oldLocation{
//    self.locationDic = [NSMutableDictionary dictionary];
//    
//    CLLocationDegrees latitude = newLocation.coordinate.latitude;
//    CLLocationDegrees longitude = newLocation.coordinate.longitude;
//    
//    NSString *latitudeString = [NSString stringWithFormat:@"%f", latitude];
//    NSString *longitudeString = [NSString stringWithFormat:@"%f", longitude];
//    
//    [self.locationDic setValue:latitudeString forKey:@"latitude"];
//    [self.locationDic setValue:longitudeString forKey:@"longitude"];
//    
//    CLLocation *c = [[CLLocation alloc]initWithLatitude:latitude longitude:longitude];
//    CLGeocoder *revGeo = [[CLGeocoder alloc]init];
//    
//    [revGeo reverseGeocodeLocation:c
//                 completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
//        if (!error && [placemarks count] > 0) {
//            NSDictionary *dict = [[placemarks objectAtIndex:0] addressDictionary];
//            NSLog(@"Street address %@", [dict objectForKey:@"Street"]);
//            [self.locationDic setValue:dict[@"Name"] forKey:@"location"];
//        } else {
//            NSLog(@"Error: %@", error);
//        }
//    }];
//    [manager stopUpdatingLocation];
//}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(nonnull NSError *)error{
    NSLog(@"error:%@",error);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)titleBtnClicked{
    
}

-(void)requestAllData{
    NSDictionary *paramDic=@{@"distance":@"1000",@"latitude":@"31.22516",@"longitude":@"121.47794"};
    [self getLocation:paramDic];
}
-(void)getLocation:(NSDictionary *)paramDic{
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    GBMUserModel *user = app.user;
    NSString *locationUrl=[MoranAPI  location];
    NSString *urlString=[NSString stringWithFormat:@"%@?distance=%@&latitude=%@&longitude=%@&token=%@&user_id=%@",locationUrl,paramDic[@"distance"],paramDic[@"latitude"],paramDic[@"longitude"],user.token,user.userId];
    NSData *requestedData=[NSData dataWithContentsOfURL:[NSURL URLWithString: urlString]];
    NSDictionary *requestedDic=[CommonParser parseJson:requestedData];
    
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    self.addrArray=[NSMutableArray array];
    id data=[[requestedDic valueForKey:@"data"] allValues];
    for(id tmpDic in data){
        self.picArray=[NSMutableArray array];
        SquareModel *sm=[[SquareModel alloc] init];
        [sm setValuesForKeysWithDictionary:tmpDic[@"node"]];
        for(id picDic in tmpDic[@"pic"]){
            Picture *pic=[[Picture alloc] init];
            [pic setValuesForKeysWithDictionary:picDic];
            [self.picArray addObject:pic];
        }
        [self.addrArray addObject:sm];
        [dic setObject:_picArray forKey:sm.addr];
    }
    
    self.dataDic = dic;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.addrArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SquareTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"squareTableCell" forIndexPath:indexPath];
    if(!cell){
        cell=[[SquareTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"squareTableCell"];
    }
    cell.imgCollectionView.delegate = cell;
    cell.imgCollectionView.dataSource = cell;
    NSInteger row=indexPath.row;
    
    SquareModel *square=self.addrArray[row];
    cell.addrLbl.text=square.addr;
    cell.dataArr=self.dataDic[square.addr];
    [cell.imgCollectionView reloadData];
    return cell;
}
@end








