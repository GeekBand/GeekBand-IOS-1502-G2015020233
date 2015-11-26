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
    
    self.pickerController=[[UIImagePickerController alloc] init];
    self.pickerController.allowsEditing=YES;
    self.pickerController.delegate=self;
    
    self.commonRequest=[[CommonRequest alloc] init];
}

-(void)viewDidAppear:(BOOL)animated{
    if(!self.imgPreview.image){
        AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
        GBMUserModel *user = app.user;
        self.imgPreview.image=user.image;
    }
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
                                            otherButtonTitles:@"拍照",@"从相册选择", nil];
    [sheet showInView:self.tabBarController.view];
}

- (IBAction)comfirmBtnClicked:(id)sender {
    NSString *avatarUrl=[MoranAPI  avatar];
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    GBMUserModel *user = app.user;
    
    NSData *data=UIImageJPEGRepresentation(self.imgPreview.image, 0.000001);
    
    NSString *encodeUrlString=[avatarUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url=[NSURL URLWithString:encodeUrlString];
    NSMutableURLRequest *request=[[NSMutableURLRequest alloc] initWithURL:url];
    request.HTTPMethod=@"POST";
    request.timeoutInterval=60;
    request.cachePolicy=NSURLRequestReloadIgnoringLocalAndRemoteCacheData;
    
    BLMultipartForm *form=[[BLMultipartForm alloc] init];
    [form addValue:user.userId forField:@"user_id"];
    [form addValue:user.token forField:@"token"];
    [form addValue:data forField:@"data"];
    
    request.HTTPBody=[form httpBody];
    [request setValue:form.contentType forHTTPHeaderField:@"Content-Type"];
    [self.commonRequest sendRequest:request delegate:self];
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex==0){
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
            self.pickerController.sourceType=UIImagePickerControllerSourceTypeCamera;
            
            [self.tabBarController presentViewController:self.pickerController
                                                animated:YES
                                              completion:nil];
        }else{
            [CommonTools showMessage:self message:@"无法获取相机"];
        }
    }else if(buttonIndex==1){
        self.pickerController.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
        [self.tabBarController presentViewController:self.pickerController
                                            animated:YES
                                          completion:nil];
    }
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *img=info[UIImagePickerControllerEditedImage];
    CGSize imgSize=img.size;
    imgSize.height=self.imgPreview.frame.size.height;
    imgSize.width=self.imgPreview.frame.size.width;
    
    img=[self imageWithImage:img scaledToSize:imgSize];
    self.imgPreview.image=img;
    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContext(newSize);
    
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}

-(void)requestSuccess:(CommonRequest *)request data:(NSData *)data{
    NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"更换头像成功:%@",string);
    
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    GBMUserModel *user = app.user;
    user.image=nil;
    
    [[self navigationController] popViewControllerAnimated:YES];
}

-(void)requestFailed:(CommonRequest *)request error:(NSError *)error{
    NSLog(@"error = %@",error);
    [[self navigationController] popViewControllerAnimated:YES];
}
@end





