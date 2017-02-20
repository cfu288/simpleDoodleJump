//
//  Enemy.m
//  Doodle2
//
//  Created by Patrick Madden on 2/5/17.
//  Copyright © 2017 Binghamton CSD. All rights reserved.
//

#import "Enemy.h"

@implementation Enemy
@synthesize dx, dy, direction;

-(void)toggleDir{
    if(self.direction == -1)
        self.direction = 1;
    else self.direction = -1;
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
