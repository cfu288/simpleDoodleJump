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

@interface GameView : UIView {
    int score;
}
@property (nonatomic, strong) Jumper *jumper;
@property (nonatomic, strong) NSMutableArray *bricks;
@property (nonatomic) float tilt;
@property (nonatomic) float blockTilt;
-(void)arrange:(CADisplayLink *)sender;


@end
