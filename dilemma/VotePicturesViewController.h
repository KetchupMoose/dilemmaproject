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
@property NSArray *PhotoObjects;
@property (weak, nonatomic) IBOutlet UIImageView *imgView1;
@property (weak, nonatomic) IBOutlet UIImageView *imgView2;
@property (weak, nonatomic) IBOutlet UIImageView *imgView3;
@property (weak, nonatomic) IBOutlet UIImageView *imgView4;

@end
