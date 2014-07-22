//
//  VotePicturesViewController.m
//  dilemma
//
//  Created by Macbook on 2014-06-07.
//  Copyright (c) 2014 Bricorp. All rights reserved.
//

#import "VotePicturesViewController.h"
#import <Parse/Parse.h>

@interface VotePicturesViewController ()

@end

@implementation VotePicturesViewController

@synthesize VotePictureSets;
@synthesize PhotoObjects;
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
    
    for (PFObject *imgObj in PhotoObjects)
    {
        PFFile *imgFile = [imgObj objectForKey:@"imageFile"];
        
        
    }
    
}

-(void) loadImages
{
    //query for data
    PFQuery * cpqueryr2 = [PFQuery queryWithClassName:@"PhotoSet"];
    [cpqueryr2 orderByDescending:@"createdAt"];
    int r2querylimit = 25;
    NSInteger *query2limitnum = &r2querylimit;
    cpqueryr2.limit = *query2limitnum ;
    [cpqueryr2 findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if  (!error)
        {
            PhotoObjects =objects;
            
       
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
