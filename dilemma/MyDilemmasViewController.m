//
//  MyDilemmasViewController.m
//  dilemma
//
//  Created by Macbook on 2014-07-27.
//  Copyright (c) 2014 Bricorp. All rights reserved.
//

#import "MyDilemmasViewController.h"
#import "SetPicturesViewController.h"

@interface MyDilemmasViewController ()

@end

@implementation MyDilemmasViewController

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

-(IBAction)GetHelp:(id)sender
{
    SetPicturesViewController *spvc;
    spvc = [self.storyboard instantiateViewControllerWithIdentifier:@"SetPics"];
    
    [self.navigationController pushViewController:spvc animated:YES];
    
    [self addChildViewController:spvc];
    [self.view addSubview:spvc.view];
}

- (IBAction)Back:(id)sender
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

@end
