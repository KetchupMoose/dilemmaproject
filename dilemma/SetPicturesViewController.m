//
//  SetPicturesViewController.m
//  dilemma
//
//  Created by Macbook on 2014-06-07.
//  Copyright (c) 2014 Bricorp. All rights reserved.
//

#import "SetPicturesViewController.h"
#import <Parse/Parse.h>
#import "MBProgressHUD.h"



@interface SetPicturesViewController ()

@end

@implementation SetPicturesViewController
MBProgressHUD *HUD;
UIImagePickerController *imagePicker;
NSInteger numPhotos;

@synthesize capturedImages;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.capturedImages = [[NSMutableArray alloc] init];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)SendPhotos:(id)sender
{
    //open the photo picker controller
    
    // Check for camera
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] == YES) {
        // Create image picker controller
        imagePicker = [[UIImagePickerController alloc] init];
        
        // Set source to the camera
        imagePicker.modalPresentationStyle = UIModalPresentationCurrentContext;
        imagePicker.sourceType =  UIImagePickerControllerSourceTypeCamera;
        
        // Delegate is self
        imagePicker.delegate = self;
        
        imagePicker.showsCameraControls = NO;
        
        imagePicker.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
        imagePicker.cameraDevice = UIImagePickerControllerCameraDeviceFront;
    
        
        /*
         Load the overlay view from the OverlayView nib file. Self is the File's Owner for the nib file, so the overlayView outlet is set to the main view in the nib. Pass that view to the image picker controller to use as its overlay view, and set self's reference to the view to nil.
         */
        [[NSBundle mainBundle] loadNibNamed:@"SetPicsOverlay" owner:self options:nil];
        self.overlayView.frame = imagePicker.cameraOverlayView.frame;
        [imagePicker.cameraOverlayView addSubview:self.overlayView];
        
        //self.overlayView = nil;
        
         self.imagePickerController = imagePicker;
        // Show image picker
        [self presentViewController:imagePicker animated:YES completion:nil];
       
    }
    else
    {
        
        //device has no camera
        [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"No Camera", nil) message:NSLocalizedString(@"No Camera Detected!", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil] show];
        
        return;
        
    }
}

#pragma mark - UIImagePickerControllerDelegate

// This method is called when an image has been chosen from the library or taken from the camera.
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    
    [self.capturedImages addObject:image];
    
    if(self.capturedImages.count==1)
    {
       [self.imageView1 setImage:[self.capturedImages objectAtIndex:0]];
        [self.previewImageView1 setImage:[self.capturedImages objectAtIndex:0]];
    }
    if(self.capturedImages.count==2)
    {
        [self.imageView2 setImage:[self.capturedImages objectAtIndex:1]];
        [self.previewImageView2 setImage:[self.capturedImages objectAtIndex:1]];
    }
    if(self.capturedImages.count==3)
    {
        [self.imageView3 setImage:[self.capturedImages objectAtIndex:2]];
        [self.previewImageView3 setImage:[self.capturedImages objectAtIndex:2]];
    }
    if(self.capturedImages.count==4)
    {
        [self.imageView4 setImage:[self.capturedImages objectAtIndex:3]];
        [self.previewImageView4 setImage:[self.capturedImages objectAtIndex:3]];
        
        self.ConfirmPicsButton.backgroundColor = [UIColor greenColor];
        
    }
    
    
    if (self.capturedImages.count==numPhotos)
    {
        self.TakePicsButton.enabled = false;
        self.TakePicsButton.backgroundColor = [UIColor grayColor];
        
        self.ConfirmPicsButton.enabled = true;
        self.ConfirmPicsButton.backgroundColor = [UIColor greenColor];
    }
    
}



- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (IBAction)TakePhoto:(id)sender
{
   
[self.imagePickerController takePicture];
  
}
- (IBAction)ConfirmPhotos:(id)sender
{
    //confirm photos
    [self.imagePickerController dismissViewControllerAnimated:YES completion:nil];
    
}

-(IBAction) UploadPhotos:(id)sender
{
    //take the captured images array and upload them to parse.
    NSLog(@"uploading Photos");
    
    
    //show progress views
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    
    // Set determinate mode
    HUD.mode = MBProgressHUDModeDeterminate;
    HUD.delegate = self;
    HUD.labelText = @"Uploading";
    [HUD show:YES];
    

    //create pics set object and add all 4 of the uploaded photos to that pic set
    NSMutableArray *photosUploaded = [[NSMutableArray alloc] init];
    
    
    
    for (int i=0; i<numPhotos;i++)
    {
        UIImage *image = [capturedImages objectAtIndex:i];
        int maxw=320;
        int maxh=2000;
        
        CGSize myimgsize = image.size;
        
        CGSize *thesize = [self scalesize:&myimgsize maxWidth:maxw maxHeight:maxh];
        
        image = [self imageWithImage:image scaledToSize:*thesize];

        int maxwsmall = 145;
        int maxhsmall = 1000;
        
        CGSize *thesmallsize = [self scalesize:&myimgsize maxWidth:maxwsmall maxHeight:maxhsmall];
        
        UIImage *smallimage = [self imageWithImage:image scaledToSize:*thesmallsize];
        
        // Save PFFile
        PFObject *imgObject;
        // set permissions for photoobject
        PFACL *contentPhotoACL = [PFACL ACLWithUser:[PFUser currentUser]];
        [contentPhotoACL setPublicReadAccess:YES];
        [contentPhotoACL setPublicWriteAccess:YES];
        imgObject.ACL = contentPhotoACL;
        imgObject = [self uploadImage2:image withSmallImage:smallimage];
        
        [photosUploaded addObject:imgObject];
        
    }
   
    NSLog(@"create photoSet Object");
    // Create a PFObject around a PFFile and associate it with the current user
     PFObject *photoSet = [PFObject objectWithClassName:@"PhotoSet"];
    
    PFUser *user = [PFUser currentUser];
    [photoSet setObject:user forKey:@"creatorPhotoSet"];
    
    // Set the access control list to current user for security purposes
    PFACL *funPhotoACL = [PFACL ACLWithUser:[PFUser currentUser]];
    [funPhotoACL setPublicReadAccess:YES];
    [funPhotoACL setPublicWriteAccess:YES];
    
    photoSet.ACL = funPhotoACL;
    
    [photoSet setObject:@"testCaption" forKey:@"Caption"];
  
    [photoSet setObject:photosUploaded forKey:@"Photos"];
    
    [photoSet saveInBackground];
    //need success call here.
    
    NSLog(@"Uploaded all 4 images");
    
    //transition to some other screen
}

#pragma mark imagesizehandlingcode
-(CGSize *)scalesize:(CGSize *)imgsize maxWidth:(int) maxWidth maxHeight:(int) maxHeight
{
    
    CGFloat width = imgsize->width;
    
    CGFloat height = imgsize->height;
    
    if (width <= maxWidth && height <= maxHeight)
    {
        return imgsize;
    }
    
    
    CGSize newsize;
    
    
    if (width > maxWidth)
    {
        CGFloat ratio = width/height;
        
        if (ratio > 1)
        {
            newsize.width = maxWidth;
            newsize.height = newsize.width / ratio;
        }
        else
        {
            newsize.width = maxWidth;
            newsize.height = newsize.width/ratio;
        }
    }
    
    if (newsize.height> maxHeight)
    {
        CGFloat maxratio = newsize.height/maxHeight;
        if (maxratio >1)
        {
            newsize.width = newsize.width/maxratio;
            newsize.height = maxHeight;
        }
        
    }
    
    //make sure to enforce a maximum height on upload so you dont get fkin nonsense.
    
    CGSize * size = &newsize;
    
    
    return size;
    
}

-(UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    //UIGraphicsBeginImageContext(newSize);
    // In next line, pass 0.0 to use the current device's pixel scaling factor (and thus account for Retina resolution).
    // Pass 1.0 to force exact pixel size.
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (PFObject*)uploadImage2:(UIImage *)myimage withSmallImage:(UIImage *) smallimage
{
    
    //set image resolution data
    NSData *imageData = UIImageJPEGRepresentation(myimage, 0.8f);
    NSData *smallimageData = UIImageJPEGRepresentation(smallimage, 0.8f);
    
    //check the image height
    
    NSLog(@"first height check image height: %ld", (long)myimage.size.height);
    NSLog(@"first width check image height: %ld", (long)myimage.size.width);
    //create nsnumber for float
    float imghfloat = myimage.size.height;
    float imgwfloat = myimage.size.width;
    
    NSNumber *imgheight = [NSNumber numberWithFloat:imghfloat];
    NSNumber *imgwidth = [NSNumber numberWithFloat:imgwfloat];
    
    PFFile *imageFile = [PFFile fileWithName:@"Image.jpg" data:imageData];
    PFFile *smallImageFile = [PFFile fileWithName:@"smallImage.jpg" data:smallimageData];
    
    // Create a PFObject around a PFFile and associate it with the current user
    PFObject *userPhoto = [PFObject objectWithClassName:@"Photo"];
    
    PFUser *user = [PFUser currentUser];
    [userPhoto setObject:user forKey:@"creator"];
    
    // Set the access control list to current user for security purposes
    PFACL *funPhotoACL = [PFACL ACLWithUser:[PFUser currentUser]];
    [funPhotoACL setPublicReadAccess:YES];
    [funPhotoACL setPublicWriteAccess:YES];
    
    userPhoto.ACL = funPhotoACL;
    
   
    [userPhoto setObject:imgheight forKey:@"imgHeight"];
    [userPhoto setObject:imgwidth forKey:@"imgWidth"];
    
    [imageFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            
            
            //Hide determinate HUD
            [HUD hide:YES];
            
            // Show checkmark
            HUD = [[MBProgressHUD alloc] initWithView:self.view];
            [self.view addSubview:HUD];
            
            // The sample image is based on the work by http://www.pixelpressicons.com, http://creativecommons.org/licenses/by/2.5/ca/
            // Make the customViews 37 by 37 pixels for best results (those are the bounds of the build-in progress indicators)
            //HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
            
            // Set custom view mode
            HUD.mode = MBProgressHUDModeCustomView;
            
            HUD.delegate = self;
            
            
            [userPhoto setObject:imageFile forKey:@"imageFile"];
            
            
            [userPhoto saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (!error) {
                    NSLog(@"image uploaded successfully");
                }
                else{
                    // Log details of the failure
                    NSLog(@"Error: %@ %@", error, [error userInfo]);
                }
            }];
        }
        else{
            [HUD hide:YES];
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    } progressBlock:^(int percentDone) {
        // Update your progress spinner here. percentDone will be between 0 and 100.
        HUD.progress = (float)percentDone/100;
    }
     
     ];
    
    [smallImageFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            [userPhoto setObject:smallImageFile forKey:@"smallimageFile"];
            [userPhoto saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (!error) {
                    NSLog(@"small image uploaded successfully");
                }
                else{
                    // Log details of the failure
                    NSLog(@"Error: %@ %@", error, [error userInfo]);
                }
            }];
        }
        else{
            [HUD hide:YES];
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    } progressBlock:^(int percentDone) {
        // Update your progress spinner here. percentDone will be between 0 and 100.
        //HUD.progress = (float)percentDone/100;
    }
     
     ];
    
    return userPhoto;
    
}

-(IBAction) deletePhoto:(id)sender
{
    //do delete
}
-(IBAction) reverseCamera:(id)sender
{
  if (imagePicker.cameraDevice == UIImagePickerControllerCameraDeviceFront)
  {
      imagePicker.cameraDevice = UIImagePickerControllerCameraDeviceRear;
  }
    else
    {
        imagePicker.cameraDevice = UIImagePickerControllerCameraDeviceFront;
    }
}
-(IBAction) flashToggle:(id)sender
{
    if (imagePicker.cameraFlashMode == UIImagePickerControllerCameraFlashModeOff || imagePicker.cameraFlashMode == UIImagePickerControllerCameraFlashModeAuto)
    {
        imagePicker.cameraFlashMode = UIImagePickerControllerCameraFlashModeOn;
        
    }
    else
    {
        imagePicker.cameraFlashMode = UIImagePickerControllerCameraFlashModeOff;
    }
}

- (IBAction)numPhotosChanged:(id)sender {
    
    if(self.numPhotoChanger.selectedSegmentIndex ==0)
    {
        //2 photo mode
        numPhotos = 2;
        
        self.imageView3.alpha = 0;
        self.imageView4.alpha = 0;
        self.previewImageView3.alpha = 0;
        self.previewImageView4.alpha = 0;
        
        self.previewImageView3.alpha = 0;
        
        
    }
    if(self.numPhotoChanger.selectedSegmentIndex ==1)
    {
        //3 photo mode
        numPhotos = 3;
        
        self.imageView3.alpha = 1;
         self.imageView4.alpha = 0;
        self.previewImageView3.alpha = 1;
        self.previewImageView4.alpha = 0;
    }
    if(self.numPhotoChanger.selectedSegmentIndex ==2)
    {
        //4 photo mode
         numPhotos = 4;
        
        self.imageView3.alpha = 1;
        self.imageView4.alpha = 1;
        self.previewImageView3.alpha = 1;
        self.previewImageView4.alpha = 1;
    }
    
    
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
