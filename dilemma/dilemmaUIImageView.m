//
//  dilemmaUIImageView.m
//  dilemma
//
//  Created by Brian Allen on 2015-05-04.
//  Copyright (c) 2015 Bricorp. All rights reserved.
//

#import "dilemmaUIImageView.h"
#import "UIView+Animation.h"
@implementation dilemmaUIImageView

CGPoint startLocation;
UIImageView *heartSymbolToggle;
UIImageView *checkMark;
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithHeart {
    
    self = [super init];
    if (self) {
        //my custom initialization
        heartSymbolToggle = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"heartsymbol.png"]];
        heartSymbolToggle.alpha = 0.4;
        heartSymbolToggle.frame = CGRectMake(50,50,60,60);
        
        checkMark = [[UIImageView alloc] initWithFrame:CGRectMake(heartSymbolToggle.frame.size.width/2-10,heartSymbolToggle.frame.size.height/2-10,20,20)];
        checkMark.image = [UIImage imageNamed:@"check_mark_green.png"];
        checkMark.alpha = 0;
        
        //checkMark.center = heartSymbolToggle.center;
        [heartSymbolToggle addSubview:checkMark];
        
        //[self addSubview:heartSymbolToggle];
        
    }
    return self;
    
}



- (void) touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event {
    
    
    // Retrieve the touch point
    CGPoint pt = [[touches anyObject] locationInView:self];
    startLocation = pt;
    
    self.alpha = 1;
    
    //possibly start an animation
    [self GrowAndShrinkView:self WithRatio:1.1];
    
    
}
- (void) touchesMoved:(NSSet*)touches withEvent:(UIEvent*)event {
    // Move relative to the original touch point
    
    CGPoint pt = [[touches anyObject] locationInView:self.superview];
    CGRect frame = [self frame];
    CGPoint currentLocation = self.center;
    frame.origin.x += pt.x - currentLocation.x;
    frame.origin.y += pt.y - currentLocation.y;
    [self setFrame:frame];
    
    int diffX = heartSymbolToggle.center.x-75;
    int diffAbs = abs(diffX);
    
    //check to see if the new point is in one of the array of points
    
    
    for(NSValue *myval in self.pointCoordinates)
    {
        CGPoint pointCompare = myval.CGPointValue;
        
        float distance = [self distanceFrom:pointCompare to:currentLocation];
        NSLog(@"%f",distance);
        
        if(fabs(distance)<=20)
        {
            NSLog(@"found a center");
            [self GrowAndShrinkView:self WithRatio:1.5];
            checkMark.alpha = 1;
            
            break;
            
        }
        else
        {
            checkMark.alpha = 0;
        }
    }
   
    
    
}

-(float)distanceFrom:(CGPoint)point1 to:(CGPoint)point2
{
    CGFloat xDist = (point2.x - point1.x);
    CGFloat yDist = (point2.y - point1.y);
    return sqrt((xDist * xDist) + (yDist * yDist));
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    //check to see if the location is centered on one of the coordinates, if so trigger the delegate to select that point.
    CGPoint currentLocation = self.center;
    NSInteger pointIndex = 0;
    for(NSValue *myval in self.pointCoordinates)
    {
        CGPoint pointCompare = myval.CGPointValue;
        
        float distance = [self distanceFrom:pointCompare to:currentLocation];
        NSLog(@"%f",distance);
        
        if(fabs(distance)<=20)
        {
            NSLog(@"triggering delegate function");
            
            [self.delegate selectImgView:pointIndex];
            
            break;
            
        }
        pointIndex = pointIndex+1;
    }


}

@end
