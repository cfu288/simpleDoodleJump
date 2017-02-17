//
//  ViewController.m
//  Doodle2
//
//  Created by Patrick Madden on 2/4/17.
//  Copyright © 2017 Binghamton CSD. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()
@property (nonatomic, strong) CADisplayLink *displayLink;

@end

@implementation ViewController
@synthesize scoreLabel;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _displayLink = [CADisplayLink displayLinkWithTarget:_gameView selector:@selector(arrange:)];
    [_displayLink setPreferredFramesPerSecond:60];
    [_displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
   // [scoreLabel setText:[NSString stringWithFormat:@"Score: %d", [[Universe sharedInstance] score]]];

}

/*
-(IBAction)incrementCounter:(id)sender
{
    int v = [[Universe sharedInstance] score] + 1;
    [[Universe sharedInstance] setScore:v];
    [scoreLabel setText:[NSString stringWithFormat:@"Score: %d", [[Universe sharedInstance] score]]];
}*/

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)speedChange:(id)sender
{
    UISlider *s = (UISlider *)sender;
    // NSLog(@"tilt %f", (float)[s value]);
    [_gameView setTilt:(float)[s value]];
}


-(void)performSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    NSLog(@"Performing segue with ID %@, so we can set things up.", identifier);
}

-(IBAction)unwindForSegue:(UIStoryboardSegue *)unwindSegue towardsViewController:(UIViewController *)subsequentVC
{
    NSLog(@"Backing out of the other view controller.");
}


@end
