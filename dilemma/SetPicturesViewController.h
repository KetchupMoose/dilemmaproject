//
//  SetPicturesViewController.h
//  dilemma
//
//  Created by Macbook on 2014-06-07.
//  Copyright (c) 2014 Bricorp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface SetPicturesViewController : UIViewController <UINavigationControllerDelegate,UIImagePickerControllerDelegate,MBProgressHUDDelegate>


@property (strong, nonatomic) IBOutlet UIButton *SendPhotosButton;
- (IBAction)SendPhotos:(id)sender;

@property (nonatomic, weak) IBOutlet UIImageView *imageView1;
@property (nonatomic, weak) IBOutlet UIImageView *imageView2;
@property (nonatomic, weak) IBOutlet UIImageView *imageView3;
@property (nonatomic, weak) IBOutlet UIImageView *imageView4;

@property (nonatomic, weak) IBOutlet UIImageView *previewImageView1;
@property (nonatomic, weak) IBOutlet UIImageView *previewImageView2;
@property (nonatomic, weak) IBOutlet UIImageView *previewImageView3;
@property (nonatomic, weak) IBOutlet UIImageView *previewImageView4;

@property (nonatomic, weak) IBOutlet UIImageView *imageView;

@property (nonatomic,weak) IBOutlet UIButton *ConfirmPicsButton;
@property (nonatomic,weak) IBOutlet UIButton *TakePicsButton;
@property (nonatomic,weak) IBOutlet UIButton *BackButton;

@property (nonatomic) IBOutlet UIView *overlayView;
@property (nonatomic) UIImagePickerController *imagePickerController;

@property (nonatomic,strong) NSMutableArray *capturedImages;

- (IBAction)TakePhoto:(id)sender;
- (IBAction)ConfirmPhotos:(id)sender;
- (IBAction)Back:(id)sender;

-(IBAction) UploadPhotos:(id)sender;


-(IBAction) deletePhoto:(id)sender;
-(IBAction) reverseCamera:(id)sender;
-(IBAction) flashToggle:(id)sender;

@property (weak, nonatomic) IBOutlet UISegmentedControl *numPhotoChanger;

@end
