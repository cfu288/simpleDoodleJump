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
#import "Universe.h"

@interface GameView : UIView {
    bool lost:YES;
}

@property (nonatomic, strong) Jumper *jumper;
@property (nonatomic, strong) NSMutableArray *bricks;
@property (nonatomic, strong) NSMutableArray *enemies;
@property (nonatomic) float tilt;
@property (nonatomic, strong) IBOutlet UILabel *scoreLabel;
@property (nonatomic, strong) IBOutlet UILabel *livesLabel;
-(void)arrange:(CADisplayLink *)sender;

@end
