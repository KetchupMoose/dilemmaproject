//
//  VotePicturesViewController.h
//  dilemma
//
//  Created by Macbook on 2014-06-07.
//  Copyright (c) 2014 Bricorp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VotePicturesViewController : UIViewController

@property (nonatomic,strong) NSArray *VotePictureSets;
@property NSArray *PhotoSetObjects;
@property (weak, nonatomic) IBOutlet UIImageView *imgView1;
@property (weak, nonatomic) IBOutlet UIImageView *imgView2;
@property (weak, nonatomic) IBOutlet UIImageView *imgView3;
@property (weak, nonatomic) IBOutlet UIImageView *imgView4;

@property (weak, nonatomic) IBOutlet UIButton *menuButton;

- (IBAction)Menu:(id)sender;

@property (weak,nonatomic) IBOutlet UILabel *styleScore;
@property (weak,nonatomic) IBOutlet UILabel *karmaScore;

-(IBAction)sendComment:(id)sender;
-(IBAction)createDilemma:(id)sender;

@property (weak,nonatomic) IBOutlet UILabel *dilemmaQuote;

@property (nonatomic, strong) NSString *dilemmaCategory;


@end
