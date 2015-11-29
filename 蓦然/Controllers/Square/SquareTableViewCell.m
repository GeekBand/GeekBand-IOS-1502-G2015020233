//
//  SquareTableViewCell.m
//  蓦然
//
//  Created by LuoNeo on 15/11/28.
//  Copyright © 2015年 com.carestream. All rights reserved.
//

#import "SquareTableViewCell.h"

@implementation SquareTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    return self;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArr.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
    SquareCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"squareCollectionCell" forIndexPath:indexPath];
    
    Picture *pic=self.dataArr[indexPath.row];
    NSString *urlString=pic.pic_link;
    NSURL *url=[NSURL URLWithString:urlString];
    
    cell.descLbl.text=pic.title;
    [cell.imgView sd_setImageWithURL:url];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
    Picture *pic = self.dataArr[indexPath.row];
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    app.selectedPicture = pic;
}

@end








