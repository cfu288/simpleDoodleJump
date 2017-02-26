//
//  GameView.m
//  Doodle2
//
//  Created by Patrick Madden on 2/4/17.
//  Copyright © 2017 Binghamton CSD. All rights reserved.
//

#import "GameView.h"


@implementation GameView
@synthesize jumper, bricks, enemies, springs;
@synthesize tilt, scoreLabel, livesLabel, lostLabel;

-(void)resetScore{
    //[[Universe sharedInstance] setScore:0];
}

-(void)resetLives{
    //[[Universe sharedInstance] setScore:0];
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    self.layer.contents = (id)[UIImage imageNamed:@"BackgroundImage.jpg"].CGImage;

    if (self)
    {
        [self newGame:nil];
    }
    return self;
}

-(IBAction)newGame:(id)sender{
    CGRect bounds = [self bounds];
    if(jumper) [jumper removeFromSuperview];
    jumper = [[Jumper alloc] initWithFrame:CGRectMake(bounds.size.width/2.1, bounds.size.height - 20, 50, 50)];
    jumper.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"yoshiLeft34x34.gif"]];
    [jumper setDx:0];
    [jumper setDy:10];
    [self addSubview:jumper];
    [self makeBricks:nil];
    [self makeEnemies];
    [self makeSprings];
    [[Universe sharedInstance] setLives:10];
    time = 0.0;
    timeevent = 0.0;
    soundPath = [[NSBundle mainBundle] pathForResource:@"jump" ofType:@"wav"];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:soundPath], &soundID);
    soundPath1 = [[NSBundle mainBundle] pathForResource:@"boing" ofType:@"wav"];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:soundPath1], &soundID1);
    soundPath2 = [[NSBundle mainBundle] pathForResource:@"ouch" ofType:@"mp3"];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:soundPath2], &soundID2);
}

-(void)makeEnemies{
    CGRect bounds = [self bounds];
    float width = 70;
    float height = 70;
    
    if (enemies)
    {
        for (Enemy *en in enemies)
        {
            [en removeFromSuperview];
        }
    }
    enemies = [[NSMutableArray alloc] init];
        Enemy *e = [[Enemy alloc] initWithFrame:CGRectMake(0, 0, width, height)];
        e.direction = -1;
        e.layer.contents = (id)[UIImage imageNamed:@"Flying-Turtle.GIF"].CGImage;
        //[e startAnimating];
        [e setCenter:CGPointMake(rand() % (int)(bounds.size.width * .8), 0)];
        [enemies addObject:e];
        [self addSubview:e];
    
}

-(void)makeSprings{
    CGRect bounds = [self bounds];
    float width = bounds.size.width * .22;
    float height = 25;
    
    if (springs)
    {
        for (Spring *s in springs)
        {
            [s removeFromSuperview];
        }
    }
    
    springs = [[NSMutableArray alloc] init];
    if(rand() % 100 < 25){ // come back to later
        Spring *s = [[Spring alloc] initWithFrame:CGRectMake(0, 0, width, height)];
        s.layer.contents = (id)[UIImage imageNamed:@"springPlat.png"].CGImage;
        [s setCenter:CGPointMake(rand() % (int)(bounds.size.width * .8), 0)];
        [springs addObject:s];
        [self addSubview:s];
    }
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
            b.layer.contents = (id)[UIImage imageNamed:@"platform.png"].CGImage;
            if( i == 1){
                [b setCenter:CGPointMake(bounds.size.width/2, bounds.size.height - 20)];
            }
            else{
                [b setCenter:CGPointMake(rand() % (int)(bounds.size.width * .8), i*100 % (int)((bounds.size.height * .93)))];
            }
            [bricks addObject:b];[self addSubview:b];
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
    //random generate enemies and springs
    CFTimeInterval ts = [sender timestamp];
    if(timeevent == 0) timeevent = ts;
    printf("time: %f\n",timeevent-ts);
    if(timeevent-ts < -3){
        printf("PRNT");
        if(rand() % 100 < 50){
            if(springs == nil | [springs count] == 0)[self makeSprings];
        }
        timeevent = ts;
    }
    if(timeevent1 == 0) timeevent1 = ts;
    if(timeevent1-ts < -3){
        if(enemies == nil | [enemies count] == 0){
            if(rand() % 100 < 70){
                [self makeEnemies];
            }
            timeevent1 = ts;
        }
    }
    
    CGRect bounds = [self bounds];
    
    // Apply gravity to the acceleration of the jumper
    [jumper setDy:[jumper dy] - .3];
    
    if(lost == YES){
        [scoreLabel setText:[NSString stringWithFormat:@"YOU LOST"]];
        [lostLabel setText:[NSString stringWithFormat:@"YOU LOST"]];
    }
    else{
    
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
        
        for(Spring *sp in springs){
            float decel = [sp dy] + .3;
            if(decel > 0) [sp setDy:0];
            else [sp setDy:decel];
        }
        
        for(Enemy *en in enemies){
            float decel = [en dy] + .3;
            if(decel > 0) [en setDy:0];
            else [en setDy:decel];
            [en setDx:[en dx] *1.01];
            int dir = en.direction;
            if ([en dx] > 3 || [en dx] < 3 ){
                [en setDx:(3*dir)];
            }
            if(rand()%100<2){
                [en toggleDir];
            }
        }
        
        // Change L/R orientation
        if(tilt <= 0)
            jumper.layer.contents = (id)[UIImage imageNamed:@"Left34x34.gif"].CGImage;
        else jumper.layer.contents = (id)[UIImage imageNamed:@"Right34x34.gif"].CGImage;
        
        // Jumper moves in the direction of gravity
        CGPoint p = [jumper center];
        p.x += [jumper dx];
        p.y -= [jumper dy];
        
        
        
        //brick movement
        for(Brick *brick in bricks){
            CGPoint bp = [brick center];
            bp.y -= [brick dy];
            if(bp.y > bounds.size.height){
                bp.y -= bounds.size.height;
                bp.x = rand() % (int)(bounds.size.width * .8);
                [[Universe sharedInstance] setScore:[[Universe sharedInstance] score] + 1];
                if([[Universe sharedInstance] score] > [[Universe sharedInstance] highscore]){
                    [[Universe sharedInstance] setHighscore:[[Universe sharedInstance] score]];
                }
            }
            [brick setCenter:bp];
        }
        //enemies movement
        for(Enemy *en in enemies){
            CGPoint bp = [en center];
            bp.y -= [en dy];
            bp.x += [en dx];
            if(bp.y > bounds.size.height){
                //[en removeFromSuperview];
                //[en delete:nil];
                //if(ts - time > 3){
                //    printf("TS:%f,TE:%f",ts,time);
                //    [en setDy:+100];
                 //   time = ts;
                //}
                //bp.y -= bounds.size.height;
                //bp.x = rand() % (int)(bounds.size.width * .8);
                //[en toggleDir];
                if(bp.y > bounds.size.height){
                    if (enemies)
                    {
                        for (Enemy *s in enemies)
                        {
                            [s removeFromSuperview];
                        }
                    }
                    enemies = nil;
                }
            }
            //else{
                if (bp.x < 0)
                    bp.x += bounds.size.width;
                if (bp.x > bounds.size.width)
                    bp.x -= bounds.size.width;
                [en setCenter:bp];
            //}
        }
        for(Spring *en in springs){
            CGPoint bp = [en center];
            bp.y -= [en dy];
            bp.x += [en dx];
            [en setCenter:bp];
            if(bp.y > bounds.size.height){
                if (springs)
                {
                    for (Spring *s in springs)
                    {
                        [s removeFromSuperview];
                    }
                }
                springs = nil;
            }
        }
        // If the jumper has fallen below the bottom of the screen,
        // add a positive velocity to move him
        if (p.y > bounds.size.height)
        {
            [jumper setDy: 10];
            AudioServicesPlaySystemSound(soundID2);
            if([[Universe sharedInstance] lives] - 1 == 0){
                [[Universe sharedInstance] setLives:[[Universe sharedInstance] lives]-1];
                lost = YES;
            }
            else{
                [[Universe sharedInstance] setLives:[[Universe sharedInstance] lives]-1];
            }
            p.y = bounds.size.height;
        }
        
        // If we've gone past the top of the screen, wrap around, random x
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
            //bounce off enemy
            for(Enemy *en in enemies){
                CGRect e = [en frame];
                if(CGRectContainsPoint(e, p) && [jumper dy] < .7){
                    [[Universe sharedInstance] setScore:[[Universe sharedInstance] score] + 5   ];
                    [jumper setDy: 12];
                    [en setDy:-25];
                    time = ts; //won't count as hit
                }
            }
            //bounce off spring
            for (Spring *sp in springs){
                CGRect s = [sp frame];
                if (CGRectContainsPoint(s, p)){
                    AudioServicesPlaySystemSound(soundID1);
                    [jumper setDy:10];
                    for(Brick *brick1 in bricks) [brick1 setDy:-25];
                    for(Enemy *en in enemies) [en setDy:-25];
                    for(Spring *s in springs) [s setDy:-25];
                }
            }
            //bounce off brick
            for (Brick *brick in bricks)
            {
                CGRect b = [brick frame];
                if (CGRectContainsPoint(b, p))
                {   // Play sound
                    AudioServicesPlaySystemSound(soundID);
                    // variable acceleration based on height
                    if(b.origin.y < bounds.size.height*.1){
                        for(Brick *brick1 in bricks){
                            [jumper setDy:0];
                            [brick1 setDy:-18];
                            for(Enemy *en in enemies) [en setDy:-18];
                            for(Spring *s in springs) [s setDy:-18];
                        }
                    }
                    else if(b.origin.y < bounds.size.height*.25){
                        for(Brick *brick1 in bricks){
                            [jumper setDy:1];
                            [brick1 setDy:-15];
                            for(Enemy *en in enemies) [en setDy:-15];
                            for(Spring *s in springs) [s setDy:-15];
                        }
                    }
                    else if(b.origin.y < bounds.size.height*.8){
                        for(Brick *brick1 in bricks){
                            [jumper setDy:6];
                            [brick1 setDy:-10];
                            for(Enemy *en in enemies) [en setDy:-10];
                            for(Spring *s in springs) [s setDy:-10];
                        }
                    }
                    else{
                        for(Brick *brick1 in bricks){
                            [jumper setDy:10];
                            [brick1 setDy:0];
                            for(Enemy *en in enemies) [en setDy:0];
                            for(Spring *s in springs) [s setDy:0];
                        }
                    }
                }
            }
        }
        
        //if you hit enemy from under
        for(Enemy *en in enemies){
            CGRect e = [en frame];
            if(CGRectContainsPoint(e, p)){
                AudioServicesPlaySystemSound(soundID2);
                [jumper setDy: 5];
                if(tilt <=0) [jumper setDx:5];
                else [jumper setDx:-5];
                if([[Universe sharedInstance] lives] - 1 == 0)
                    lost = YES;
                else{
                    if(ts - time > 1){ [[Universe sharedInstance] setLives:[[Universe sharedInstance] lives]-1];
                        time = ts;
                    }
                }
            }
        }
        
        [scoreLabel setText:[NSString stringWithFormat:@"Score: %d", [[Universe sharedInstance] score]]];
        [livesLabel setText:[NSString stringWithFormat:@"Lives: %d", [[Universe sharedInstance] lives]]];
        [jumper setCenter:p];
        // NSLog(@"Timestamp %f", ts);
    }
}

@end
