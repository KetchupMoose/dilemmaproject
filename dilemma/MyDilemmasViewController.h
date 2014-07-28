//
//  MyDilemmasViewController.h
//  dilemma
//
//  Created by Macbook on 2014-07-27.
//  Copyright (c) 2014 Bricorp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyDilemmasViewController : UIViewController

@property (nonatomic, weak) IBOutlet UITableView *MyDilemmasTableView;

@property (nonatomic, weak) IBOutlet UIButton *GetHelpButton;

-(IBAction)GetHelp:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *backButton;
- (IBAction)Back:(id)sender;

@end
