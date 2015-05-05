//
//  VotePicturesViewController.m
//  dilemma
//
//  Created by Macbook on 2014-06-07.
//  Copyright (c) 2014 Bricorp. All rights reserved.
//

#import "VotePicturesViewController.h"
#import <Parse/Parse.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "UIImageView+UIActivityIndicatorForSDWebImage.h"
#import <QuartzCore/QuartzCore.h>

@interface VotePicturesViewController ()

@end

@implementation VotePicturesViewController

@synthesize VotePictureSets;
@synthesize PhotoSetObjects;
@synthesize heartSymbol;
PFObject *activePhotoSet;
CGPoint *lastLocation;
UIImageView *checkMark;
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
    
    /*
    self.imgView1.userInteractionEnabled = YES;
    self.imgView2.userInteractionEnabled = YES;
    self.imgView3.userInteractionEnabled = YES;
    self.imgView4.userInteractionEnabled = YES;
    */
    
    //add checkmark image inside heartsymbol
    checkMark = [[UIImageView alloc] initWithFrame:CGRectMake(heartSymbol.frame.size.width/2-10,heartSymbol.frame.size.height/2-10,20,20)];
    checkMark.image = [UIImage imageNamed:@"check_mark_green.png"];
    checkMark.alpha = 0;
    
    //checkMark.center = heartSymbol.center;
    [heartSymbol addSubview:checkMark];
    heartSymbol.checkmarkImg = checkMark;
    
    
    heartSymbol.userInteractionEnabled = YES;
    heartSymbol.alpha = 0.4;
    heartSymbol.delegate = self;
    
 
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
   
    [PhotoSetQuery includeKey:@"Photos"];
    
    //[PhotoSetQuery findObjects];
   
    [PhotoSetQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if  (!error)
        {
            PhotoSetObjects =  objects;
            activePhotoSet = [PhotoSetObjects objectAtIndex:0];
            NSLog(@"loading images");
            int j = 0;
            NSArray *photoList = [[NSArray alloc] init];
            photoList = [activePhotoSet objectForKey:@"Photos"];
            NSArray *voteList = [[NSArray alloc] init];
            voteList = [activePhotoSet objectForKey:@"PhotoVotes"];
            
            
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
                      //[self.imgView1 setImageWithURL:[NSURL URLWithString:imgurl] usingActivityIndicatorStyle:(UIActivityIndicatorViewStyle)activityStyle ];
                    [self.imgView1 setImageWithURL:[NSURL URLWithString:imgurl] usingActivityIndicatorStyle:activityStyle];
                    
                    UILabel *voteScore = [[UILabel alloc] init];
                    NSNumber *votenum = [voteList objectAtIndex:0];
                    voteScore.text = [votenum stringValue];
                    voteScore.textColor = [UIColor whiteColor];
                    voteScore.frame = self.imgView1.bounds;
                    
                    [self.imgView1 addSubview:voteScore];
                 
                }
                if(j==2)
                {
                   [self.imgView2 setImageWithURL:[NSURL URLWithString:imgurl] usingActivityIndicatorStyle:activityStyle];
                    UILabel *voteScore = [[UILabel alloc] init];
                    NSNumber *votenum = [voteList objectAtIndex:1];
                    voteScore.text = [votenum stringValue];
                    voteScore.textColor = [UIColor whiteColor];
                    voteScore.frame = self.imgView1.bounds;
                    [self.imgView2 addSubview:voteScore];
                    
                    
                }
                if(j==3)
                {
                    [self.imgView3 setImageWithURL:[NSURL URLWithString:imgurl] usingActivityIndicatorStyle:activityStyle];
                    UILabel *voteScore = [[UILabel alloc] init];
                    NSNumber *votenum = [voteList objectAtIndex:2];
                    voteScore.text = [votenum stringValue];
                    voteScore.textColor = [UIColor whiteColor];
                    voteScore.frame = self.imgView1.bounds;
                    [self.imgView3 addSubview:voteScore];
                }
                if(j==4)
                {
                    [self.imgView4 setImageWithURL:[NSURL URLWithString:imgurl] usingActivityIndicatorStyle:activityStyle];
                    UILabel *voteScore = [[UILabel alloc] init];
                    NSNumber *votenum = [voteList objectAtIndex:3];
                    voteScore.text = [votenum stringValue];
                    voteScore.textColor = [UIColor whiteColor];
                    voteScore.frame = self.imgView1.bounds;
                    [self.imgView4 addSubview:voteScore];
                }
                
            }

       [self setHeartSymbolCoordinates];
        }
    }];
    
    
    
}

-(void)setHeartSymbolCoordinates
{
    //sets the coordinates for img1,2, 3, and 4's center points
    NSMutableArray *imgCoordinates = [[NSMutableArray alloc] init];
    NSArray *photoList = [activePhotoSet objectForKey:@"Photos"];
    NSInteger photoCount = [photoList count];
    
    if(photoCount ==2)
    {
        [imgCoordinates addObject:[NSValue valueWithCGPoint:self.imgView1.center]];
       [imgCoordinates addObject:[NSValue valueWithCGPoint:self.imgView2.center]];
        
    }
    
    if(photoCount ==3)
    {
        [imgCoordinates addObject:[NSValue valueWithCGPoint:self.imgView1.center]];
        [imgCoordinates addObject:[NSValue valueWithCGPoint:self.imgView2.center]];
        [imgCoordinates addObject:[NSValue valueWithCGPoint:self.imgView3.center]];
    }
    
    if(photoCount ==4)
    {
        [imgCoordinates addObject:[NSValue valueWithCGPoint:self.imgView1.center]];
        [imgCoordinates addObject:[NSValue valueWithCGPoint:self.imgView2.center]];
        [imgCoordinates addObject:[NSValue valueWithCGPoint:self.imgView3.center]];
        [imgCoordinates addObject:[NSValue valueWithCGPoint:self.imgView4.center]];
    }
    
    self.heartSymbol.pointCoordinates = [imgCoordinates copy];
}

#pragma mark dilemmaUIImageViewDelegate Methods
- (void)selectImgView:(NSInteger) index
{
    NSLog(@"selected this image!");
    NSLog(@"%ld",index);
    
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

- (IBAction)Back:(id)sender
{
    
    NSLog(@"back got touched");
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


@end
