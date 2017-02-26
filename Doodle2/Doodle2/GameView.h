//
//  GameView.h
//  Doodle2
//
//  Created by Patrick Madden on 2/4/17.
//  Copyright © 2017 Binghamton CSD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Jumper.h"
#import "Brick.h"
#import "Enemy.h"
#import "Spring.h"
#import "Universe.h"
#import <AudioToolbox/AudioToolbox.h>


@interface GameView : UIView {
    bool lost:YES;
    double time;
    double timeevent;
    double timeevent1;
    NSString *soundPath;
    NSString *soundPath1;
    NSString *soundPath2;
    SystemSoundID soundID;
    SystemSoundID soundID1;
    SystemSoundID soundID2;
}

@property (nonatomic, strong) Jumper *jumper;
@property (nonatomic, strong) NSMutableArray *bricks;
@property (nonatomic, strong) NSMutableArray *enemies;
@property (nonatomic, strong) NSMutableArray *springs;
@property (nonatomic) float tilt;
@property (nonatomic, strong) IBOutlet UILabel *scoreLabel;
@property (nonatomic, strong) IBOutlet UILabel *livesLabel;
@property (nonatomic, strong) IBOutlet UILabel *lostLabel;
@property (nonatomic, strong) IBOutlet UIButton *resetButton;
-(void)arrange:(CADisplayLink *)sender;

@end
