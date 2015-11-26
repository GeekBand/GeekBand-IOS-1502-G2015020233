//
//  HomePageViewController.m
//  蓦然
//
//  Created by LuoNeo on 15/11/26.
//  Copyright © 2015年 com.carestream. All rights reserved.
//

#import "HomePageViewController.h"

@implementation HomePageViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    
    [self showHomePage];
}
-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}
-(void)showHomePage{
    NSString *urlString=@"http://geekband.com";
    NSURL *url=[NSURL URLWithString:urlString];
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    [self.WebView loadRequest:request];
}
@end
