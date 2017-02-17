//
//  Universe.h
//  cs441-autolayout
//
//  Created by Patrick Madden on 2/9/17.
//  Copyright © 2017 Binghamton CSD. All rights reserved.
//

// A simple way to have data shared from multiple view controllers and objects.
// And also, a way to have persistent data

#import <Foundation/Foundation.h>

@interface Universe : NSObject{}

+(Universe *)sharedInstance;
@property (nonatomic) int score;

-(void)saveState;
-(void)loadState;

@end