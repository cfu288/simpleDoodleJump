//
//  StartView.h
//  Doodle2
//
//  Created by Christopher Fu on 2/18/17.
//  Copyright © 2017 Binghamton CSD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Universe.h"
@interface StartView : UIView{}
@property (atomic,strong) IBOutlet UILabel *HighscoreLabel;
-(id)initWithCoder:(NSCoder *)aDecoder;
-(void)setHighscoreLab;

@end
