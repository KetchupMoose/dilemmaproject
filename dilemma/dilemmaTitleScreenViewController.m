//
//  dilemmaTitleScreenViewController.m
//  dilemma
//
//  Created by Macbook on 2014-07-27.
//  Copyright (c) 2014 Bricorp. All rights reserved.
//

#import "dilemmaTitleScreenViewController.h"
#import "VotePicturesViewController.h"
#import "MyDilemmasViewController.h"
#import <Parse/Parse.h>

@interface dilemmaTitleScreenViewController ()

@end

@implementation dilemmaTitleScreenViewController
NSMutableArray *carouselItems;
NSMutableArray *carouselPictures;
@synthesize carousel;

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
    
    self.carousel.dataSource = self;
    self.carousel.delegate = self;
    
    self.carousel.type = iCarouselTypeCoverFlow2;
    
    carouselItems = [NSMutableArray array];
    carouselPictures = [NSMutableArray array];
    
    [carouselItems addObject:@"What to Wear"];
    [carouselItems addObject:@"Profile Pictures"];
    [carouselItems addObject:@"Home Decorating"];
    //[carouselItems addObject:@"Sex Appeal"];
    //[carouselItems addObject:@"All Business"];
    [carouselItems addObject:@"Anything Goes"];
   
    [carouselPictures addObject:@"womanatmirror.jpg"];
    [carouselPictures addObject:@"male-female-profile-picture-vector-abstract-32171668.jpg"];
    [carouselPictures addObject:@"CQ-Web-Interior-Designer-Working-Istock-Purchase.jpg"];
    //[carouselPictures addObject:@"sexappeal.jpg"];
    //[carouselPictures addObject:@"stock-photo-young-business-man-and-woman-in-the-office-260081642.jpg"];
    [carouselPictures addObject:@"random.jpg"];
    
    [self.carousel reloadData];
    [self.carousel setCurrentItemIndex:2];
    
    
    self.helpOthersImgView.layer.cornerRadius = self.helpOthersImgView.frame.size.width / 2;
    self.helpOthersImgView.clipsToBounds = YES;
    
    self.titleBar1.layer.cornerRadius = self.helpOthersImgView.frame.size.width / 2;
    self.titleBar1.clipsToBounds = YES;
    
    self.titleBar2.layer.cornerRadius = self.helpOthersImgView.frame.size.width / 2;
    self.titleBar2.clipsToBounds = YES;
    
    self.titleBar3.layer.cornerRadius = self.helpOthersImgView.frame.size.width / 2;
    self.titleBar3.clipsToBounds = YES;
    
    self.titleBar4.layer.cornerRadius = self.helpOthersImgView.frame.size.width / 2;
    self.titleBar4.clipsToBounds = YES;
    
    self.featuredView.layer.cornerRadius = 4.0f;
    self.featuredView.layer.masksToBounds = YES;
    
    
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

- (IBAction)StartHelping:(id)sender
{
    VotePicturesViewController *vpvc;
    vpvc=[self.storyboard instantiateViewControllerWithIdentifier:@"VotePics"];
       [self.navigationController pushViewController:vpvc animated:YES];
    //[self addChildViewController:vpvc];
    //[self.view addSubview:vpvc.view];

    
}
- (IBAction)MyDilemmas:(id)sender
{
    MyDilemmasViewController *mdvc;
    mdvc = [self.storyboard instantiateViewControllerWithIdentifier:@"MyDilemmas"];
     [self.navigationController pushViewController:mdvc animated:YES];
    //[self addChildViewController:mdvc];
    //[self.view addSubview:mdvc.view];
    
    
}

#pragma mark -
#pragma mark iCarousel methods

- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    //return the total number of items in the carousel
    return [carouselItems count];
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    UILabel *label = nil;
    UIImageView *imgView = nil;
    //create new view if no view is available for recycling
    if (view == nil)
    {
        view = [[UIView alloc] initWithFrame:CGRectMake(0,0,200.0f,self.carousel.frame.size.height)];
        
        view.layer.borderColor = (__bridge CGColorRef)([UIColor blueColor]);
        //view.layer.borderWidth = 25.0f;
        [view.layer setBorderWidth:20];
        view.contentMode = UIViewContentModeCenter;
        
        //view.backgroundColor = [UIColor blueColor];
        
        UIView *borderView = [[UIView alloc] initWithFrame:view.bounds];
        borderView.layer.borderColor =[UIColor blueColor].CGColor;
        borderView.layer.borderWidth = 2.0f;
        borderView.layer.cornerRadius = 10.0f;
        borderView.tag = 77;
        //borderView.backgroundColor = [UIColor redColor];
        
        //[view addSubview:borderView];
        
        label = [[UILabel alloc] initWithFrame:CGRectMake(25,20,150,35)];
        label.font = [UIFont fontWithName:@"FuturaMedium" size:22];
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.backgroundColor = [UIColor colorWithRed:0/255.0f green:122.0/255.0f blue:255.0/255.0f alpha:1];
        label.tag = 1;
        label.layer.cornerRadius = 12.0f;
        label.layer.masksToBounds = YES;
        
        [view addSubview:label];
        
        imgView = [[UIImageView alloc] initWithFrame:CGRectMake(25,75,150,150)];
        imgView.tag = 2;
        
        imgView.layer.cornerRadius = 12.0f;
        imgView.layer.masksToBounds = YES;
        
        
        [view addSubview:imgView];
        
        //0,122,255 background blue color
        
        
    }
    else
    {
        //get a reference to the label in the recycled view
        label = (UILabel *)[view viewWithTag:1];
        imgView = (UIImageView *)[view viewWithTag:2];
        
    }
    
    //set item label
    //remember to always set any properties of your carousel item
    //views outside of the `if (view == nil) {...}` check otherwise
    //you'll get weird issues with carousel item content appearing
    //in the wrong place in the carousel
    label.text = carouselItems[index];
    
    [imgView setImage:[UIImage imageNamed:carouselPictures[index]]];
    
    return view;
}

- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index;
{
    VotePicturesViewController *vpvc =[self.storyboard instantiateViewControllerWithIdentifier:@"VotePics"];
    vpvc.dilemmaCategory = carouselItems[index];
    
    //query for the data in background
    PFQuery *query = [PFQuery queryWithClassName:@"PhotoSet"];
    [query whereKey:@"category" equalTo:vpvc.dilemmaCategory];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        vpvc.VotePictureSets = objects;
       
        [self.navigationController pushViewController:vpvc animated:YES];
    }];
    
    
}





@end
