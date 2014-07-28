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

@interface dilemmaTitleScreenViewController ()

@end

@implementation dilemmaTitleScreenViewController

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

@end
