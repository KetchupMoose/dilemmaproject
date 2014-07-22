//
//  dilemmaViewController.m
//  dilemma
//
//  Created by Macbook on 2014-06-07.
//  Copyright (c) 2014 Bricorp. All rights reserved.
//

#import "dilemmaViewController.h"
#import "SetPicturesViewController.h"

@interface dilemmaViewController ()

@end

@implementation dilemmaViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)SetPhotos:(id)sender
{
    SetPicturesViewController *spvc;
    spvc=[self.storyboard instantiateViewControllerWithIdentifier:@"SetPics"];
    
    [self addChildViewController:spvc];
    [self.view addSubview:spvc.view];
    
}

@end
