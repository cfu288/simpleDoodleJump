//
//  StartView.m
//  Doodle2
//
//  Created by Christopher Fu on 2/18/17.
//  Copyright © 2017 Binghamton CSD. All rights reserved.
//

#import "StartView.h"

@implementation StartView
-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    [_HighscoreLabel setText:[NSString stringWithFormat:@"High Score: %d", [[Universe sharedInstance] highscore]]];
    self.layer.contents = (id)[UIImage imageNamed:@"BackgroundImage.jpg"].CGImage;
    return self;
}
-(void)setHighscoreLab{
    [_HighscoreLabel setText:[NSString stringWithFormat:@"High Score: %d", [[Universe sharedInstance] highscore]]];
    NSLog(@"High Score: %d", [[Universe sharedInstance] highscore]);
}
@end
