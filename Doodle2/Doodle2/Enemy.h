//
//  Enemy.h
//  Doodle2
//
//  Created by Christopher Fu on 2/5/17.
//  Copyright © 2017 Binghamton CSD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Enemy : UIImageView
@property (nonatomic) float dx, dy;  // Velocity
@property (nonatomic) int direction;
-(void)toggleDir;
@end
