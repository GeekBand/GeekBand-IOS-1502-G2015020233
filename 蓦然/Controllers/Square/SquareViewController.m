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
    id data=[[requestedDic valueForKey:@"data"] allValues];
    for(id tmpDic in data){
        self.addrArray=[NSMutableArray array];
        self.picArray=[NSMutableArray array];
        
        SquareModel *sm=[[SquareModel alloc] init];
        [sm setValuesForKeysWithDictionary:tmpDic[@"node"]];
        for(id picDic in tmpDic[@"pic"]){
            Picture *pic=[[Picture alloc] init];
            [pic setValuesForKeysWithDictionary:picDic];
            [self.picArray addObject:pic];
        }
        [self.addrArray addObject:sm];
        [dic setObject:_picArray forKey:_addrArray];
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
    
    SquareModel *square=self.addrArray[indexPath.row][0];
    cell.addrLbl.text=square.addr;
    cell.dataArr=self.dataDic[self.addrArray[indexPath.row]];
    [cell.imgCollectionView reloadData];
    return cell;
}
@end





