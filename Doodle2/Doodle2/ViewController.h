//
//  ViewController.h
//  Doodle2
//
//  Created by Patrick Madden on 2/4/17.
//  Copyright © 2017 Binghamton CSD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameView.h"
#import "Universe.h"

@interface ViewController : UIViewController{
}
@property (nonatomic, strong) IBOutlet GameView *gameView;
@property (nonatomic, strong) IBOutlet UILabel *scoreLabel;
//-(IBAction)incrementCounter:(id)sender;


@end

