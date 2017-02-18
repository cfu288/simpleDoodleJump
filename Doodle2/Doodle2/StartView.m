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
    self.layer.contents = (id)[UIImage imageNamed:@"BackgroundImage.jpg"].CGImage;
    [self setHighscoreLabel];
    return self;
}

- (void)setHighscoreLabel
{
    [self.HighscoreLabel setText:[NSString stringWithFormat:@"High Score: %d", [[Universe sharedInstance] highscore]]];
}
@end
