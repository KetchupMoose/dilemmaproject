//
//  dilemmaUIImageView.h
//  dilemma
//
//  Created by Brian Allen on 2015-05-04.
//  Copyright (c) 2015 Bricorp. All rights reserved.
//

#import <UIKit/UIKit.h>

//delegate protocol--mark heart with checkmark
//delegate protocol--fire selection

@protocol dilemmaUIImageViewDelegate

- (void)markHeartCheck;
- (void)selectImgView:(NSInteger) index;
- (void)moveHeartImg:(CGPoint) point;

@end


@interface dilemmaUIImageView : UIImageView
- (id)initWithHeart;
@property (strong,nonatomic) NSString *imgViewIndex;
@property (weak,nonatomic) id<dilemmaUIImageViewDelegate> delegate;
@property (strong,nonatomic) NSArray *pointCoordinates;
@property (strong,nonatomic) UIImageView *checkmarkImg;

@end
