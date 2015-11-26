//
//  ChangeHeadImageController.m
//  蓦然
//
//  Created by LuoNeo on 15/11/25.
//  Copyright © 2015年 com.carestream. All rights reserved.
//

#import "ChangeHeadImageController.h"

@interface ChangeHeadImageController ()

@end

@implementation ChangeHeadImageController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated{
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    GBMUserModel *user = app.user;
    NSString *headUrl=[MoranAPI  headImg];
    NSString *urlString=[NSString stringWithFormat:@"%@?user_id=%@",headUrl,user.userId];
    
    UIImage* serverImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString: urlString]]];
    self.imgPreview.image=serverImage;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)changeHeadImgBtnClicked:(id)sender {
    UIActionSheet *sheet=[[UIActionSheet alloc] initWithTitle:nil
                                                     delegate:self
                                            cancelButtonTitle:@"取消"
                                       destructiveButtonTitle:nil
                                            otherButtonTitles:@"拍照",@"从照相机选择", nil];
    [sheet showInView:self.tabBarController.view];
}

- (IBAction)comfirmBtnClicked:(id)sender {
    
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    self.pickerController=[[UIImagePickerController alloc] init];
    if(buttonIndex==0){
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
            self.pickerController.sourceType=UIImagePickerControllerSourceTypeCamera;
            self.pickerController.allowsEditing=NO;
            self.pickerController.delegate=self;
            
            [self.tabBarController presentViewController:self.pickerController animated:YES completion:nil];
        }else{
            [CommonTools showMessage:self message:@"无法获取相机"];
        }
    }else if(buttonIndex==1){
        self.pickerController.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
        self.pickerController.delegate=self;
        [self.tabBarController presentViewController:self.pickerController animated:YES completion:nil];
    }
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *img=info[UIImagePickerControllerOriginalImage];
    CGSize imgSize=img.size;
    imgSize.height=self.imgPreview.frame.size.height;
    imgSize.width=self.imgPreview.frame.size.width;
    
    img=[self imageWithImage:img scaledToSize:imgSize];
    self.imgPreview.image=img;
}

- (UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContext(newSize);
    
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}
@end





