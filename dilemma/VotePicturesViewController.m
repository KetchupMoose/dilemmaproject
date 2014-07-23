//
//  VotePicturesViewController.m
//  dilemma
//
//  Created by Macbook on 2014-06-07.
//  Copyright (c) 2014 Bricorp. All rights reserved.
//

#import "VotePicturesViewController.h"
#import <Parse/Parse.h>
#import "UIImageView+UIActivityIndicatorForSDWebImage.h"

@interface VotePicturesViewController ()

@end

@implementation VotePicturesViewController

@synthesize VotePictureSets;
@synthesize PhotoSetObjects;
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
    
    //load 4 images
    [self loadImages];
    
    
}

-(void) loadImages
{
    
    PFQuery *PhotoSetQuery = [PFQuery queryWithClassName:@"PhotoSet"];
    
    //you can keep entering more or queries to get more terms
    [PhotoSetQuery orderByDescending:@"createdAt"];
    int r2querylimit = 25;
    NSInteger *query2limitnum = &r2querylimit;
    PhotoSetQuery.limit = *query2limitnum;
    
    [PhotoSetQuery findObjects];
    
    
    
    
     PFQuery *photosQuery = [PFQuery queryWithClassName:@"Photo"];
    [photosQuery whereKey:@"objectId"
 
   
    [photosQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if  (!error)
        {
            PhotoSetObjects =  objects;
            PFObject *firstPhotoSet = [PhotoSetObjects objectAtIndex:0];
            NSLog(@"loading images");
            int j = 0;
            NSArray *photoList = [[NSArray alloc] init];
            photoList = [firstPhotoSet objectForKey:@"Photos"];
            
            
            for (PFObject *photoObj in photoList)
            {
                
                
                
                PFFile *imgFile = [photoObj objectForKey:@"imageFile"];
                //get URL from imgfile
                NSString *imgurl;
                
                j = j+1;
                
                imgurl = imgFile.url;
                UIActivityIndicatorViewStyle activityStyle = UIActivityIndicatorViewStyleGray;
                
                if(j==1)
                {
                    [self.imgView1 setImageWithURL:[NSURL URLWithString:imgurl] usingActivityIndicatorStyle:(UIActivityIndicatorViewStyle)activityStyle ];
                }
                if(j==2)
                {
                    [self.imgView2 setImageWithURL:[NSURL URLWithString:imgurl] usingActivityIndicatorStyle:(UIActivityIndicatorViewStyle)activityStyle ];
                }
                if(j==3)
                {
                    [self.imgView3 setImageWithURL:[NSURL URLWithString:imgurl] usingActivityIndicatorStyle:(UIActivityIndicatorViewStyle)activityStyle ];
                }
                if(j==4)
                {
                    [self.imgView4 setImageWithURL:[NSURL URLWithString:imgurl] usingActivityIndicatorStyle:(UIActivityIndicatorViewStyle)activityStyle ];
                }
                
            }

       
        }
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
