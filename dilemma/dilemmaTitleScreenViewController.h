//
//  dilemmaTitleScreenViewController.h
//  dilemma
//
//  Created by Macbook on 2014-07-27.
//  Copyright (c) 2014 Bricorp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iCarousel.h"


@interface dilemmaTitleScreenViewController : UIViewController <iCarouselDataSource,iCarouselDelegate>

- (IBAction)StartHelping:(id)sender;
- (IBAction)MyDilemmas:(id)sender;

@property (nonatomic, weak) IBOutlet UIButton *StartHelpingButton;
@property (nonatomic, weak) IBOutlet UIButton *MyDilemmasButton;

@property (nonatomic, weak) IBOutlet UIImageView *helpOthersImgView;

@property (nonatomic, weak) IBOutlet UIImageView *titleBar1;
@property (nonatomic, weak) IBOutlet UIImageView *titleBar2;
@property (nonatomic, weak) IBOutlet UIImageView *titleBar3;
@property (nonatomic, weak) IBOutlet UIImageView *titleBar4;

@property (nonatomic, weak) IBOutlet UIView *featuredView;

@property (nonatomic, weak) IBOutlet iCarousel *carousel;


@end
