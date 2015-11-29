//
//  SquareTableViewCell.h
//  蓦然
//
//  Created by LuoNeo on 15/11/28.
//  Copyright © 2015年 com.carestream. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Picture.h"
#import "SquareCollectionViewCell.h"
#import "AppDelegate.h"

@interface SquareTableViewCell : UITableViewCell<UICollectionViewDelegate,UICollectionViewDataSource>

@property (strong,nonatomic) NSArray *dataArr;

@property (weak, nonatomic) IBOutlet UILabel *addrLbl;
@property (weak, nonatomic) IBOutlet UICollectionView *imgCollectionView;

@end
