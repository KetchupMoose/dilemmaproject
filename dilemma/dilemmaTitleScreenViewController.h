//
//  dilemmaTitleScreenViewController.h
//  dilemma
//
//  Created by Macbook on 2014-07-27.
//  Copyright (c) 2014 Bricorp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface dilemmaTitleScreenViewController : UIViewController

- (IBAction)StartHelping:(id)sender;
- (IBAction)MyDilemmas:(id)sender;

@property (nonatomic, weak) IBOutlet UIButton *StartHelpingButton;
@property (nonatomic, weak) IBOutlet UIButton *MyDilemmasButton;

@end
