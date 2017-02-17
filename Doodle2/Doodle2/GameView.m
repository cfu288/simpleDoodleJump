//
//  GameView.m
//  Doodle2
//
//  Created by Patrick Madden on 2/4/17.
//  Copyright © 2017 Binghamton CSD. All rights reserved.
//

#import "GameView.h"

@implementation GameView
@synthesize jumper, bricks;
@synthesize tilt, blockTilt;

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    self.layer.contents = (id)[UIImage imageNamed:@"BackgroundImage.jpg"].CGImage;

    if (self)
    {
        CGRect bounds = [self bounds];
        
        jumper = [[Jumper alloc] initWithFrame:CGRectMake(bounds.size.width/2, bounds.size.height - 20, 50, 50)];
        jumper.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"yoshiLeft34x34.gif"]];
        [jumper setDx:0];
        [jumper setDy:10];
        [self addSubview:jumper];
        [self makeBricks:nil];
    }
    return self;
}

-(IBAction)makeBricks:(id)sender
{
    CGRect bounds = [self bounds];
    float width = bounds.size.width * .2;
    float height = 20;
    
    if (bricks)
    {
        for (Brick *brick in bricks)
        {
            [brick removeFromSuperview];
        }
    }
        
    bricks = [[NSMutableArray alloc] init];
    for (int i = 0; i < 10; ++i)
        {
            Brick *b = [[Brick alloc] initWithFrame:CGRectMake(0, 0, width, height)];
            //[b setBackgroundColor:[UIColor blueColor]];
            b.layer.contents = (id)[UIImage imageNamed:@"platform.png"].CGImage;
            [b setCenter:CGPointMake(rand() % (int)(bounds.size.width * .8), rand() % (int)((bounds.size.height * .8)))];
            
            //need to fix
            //[b setDy:0];
            [bricks addObject:b];[self addSubview:b];
            /*if(i==1){ [bricks addObject:b];[self addSubview:b];}
            else{
                for(int j = 0; j < [bricks count]; ++j){
                    CGRect tmp = [bricks[j] frame];
                    CGPoint tmp1 = [b center];
                    if( !( CGRectContainsPoint(tmp, tmp1) ) ){
                        [bricks addObject:b];[self addSubview:b];
                    }
                }
            }*/
            
            
        }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)arrange:(CADisplayLink *)sender
{
    //CFTimeInterval ts = [sender timestamp];
    
    CGRect bounds = [self bounds];
    
    // Apply gravity to the acceleration of the jumper
    [jumper setDy:[jumper dy] - .3];
    
    // Apply the tilt.  Limit maximum tilt to + or - 5
    [jumper setDx:[jumper dx] + tilt];
    if ([jumper dx] > 5)
        [jumper setDx:5];
    if ([jumper dx] < -5)
        [jumper setDx:-5];
    
    // Apply platform deceleration
    for(Brick *brick in bricks){
        float decel = [brick dy] + .3;
        if(decel > 0) [brick setDy:0];
        else [brick setDy:decel];
    }
    
    // Change L/R orientation
    if(tilt <= 0)
        jumper.layer.contents = (id)[UIImage imageNamed:@"Left34x34.gif"].CGImage;
    else jumper.layer.contents = (id)[UIImage imageNamed:@"Right34x34.gif"].CGImage;
    
    // Jumper moves in the direction of gravity
    CGPoint p = [jumper center];
    p.x += [jumper dx];
    p.y -= [jumper dy];
    
    for(Brick *brick in bricks){
        CGPoint bp = [brick center];
        bp.y -= [brick dy];
        if(bp.y > bounds.size.height)
            bp.y -= bounds.size.height;
        
        [brick setCenter:bp];
    }
    
    // If the jumper has fallen below the bottom of the screen,
    // add a positive velocity to move him
    if (p.y > bounds.size.height)
    {
        [jumper setDy:10];
        p.y = bounds.size.height;
    }
    
    // If we've gone past the top of the screen, wrap around
    if (p.y < 0)
        p.y += bounds.size.height;
    
    // If we have gone too far left, or too far right, wrap around
    if (p.x < 0)
        p.x += bounds.size.width;
    if (p.x > bounds.size.width)
        p.x -= bounds.size.width;
    
    // If we are moving down, and we touch a brick, we get
    // a jump to push us up.
    if ([jumper dy] < 0)
    {
        for (Brick *brick in bricks)
        {
            //CGPoint bl = [brick center];
            CGRect b = [brick frame];
            if (CGRectContainsPoint(b, p))
            {
                [jumper setDy:10];
                if(b.origin.y < bounds.size.height*.1){
                    for(Brick *brick1 in bricks){
                        [jumper setDy:0];
                        [brick1 setDy:-18];
                    }
                }
                else if(b.origin.y < bounds.size.height*.2){
                    for(Brick *brick1 in bricks){
                        [jumper setDy:1];
                        [brick1 setDy:-16];
                    }
                }
                else if(b.origin.y < bounds.size.height*.8){
                    for(Brick *brick1 in bricks){
                        [jumper setDy:6];
                        [brick1 setDy:-10];
                    }
                }
                else{
                    for(Brick *brick1 in bricks){
                        [jumper setDy:10];
                        [brick1 setDy:0];
                    }
                }
            }
        }
    }
    
    [jumper setCenter:p];
    // NSLog(@"Timestamp %f", ts);
}

@end
