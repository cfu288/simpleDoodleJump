//
//  ViewController.m
//  Doodle2
//
//  Created by Patrick Madden on 2/4/17.
//  Copyright © 2017 Binghamton CSD. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()
@end

@implementation ViewController
@synthesize sv;
@synthesize back;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    dl = [CADisplayLink displayLinkWithTarget:_gameView selector:@selector(arrange:)];
    [dl setPreferredFramesPerSecond:60];
    [dl addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];

}

-(void)newDisplay{
    [sv setHighscoreLab];
    [dl invalidate];
    dl = [CADisplayLink displayLinkWithTarget:_gameView selector:@selector(arrange:)];
    [dl setPreferredFramesPerSecond:60];
    [dl addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
}

-(IBAction)resetGame:(id)sender{
    [sv setHighscoreLab];
    [dl invalidate];
    if([Universe sharedInstance].highscore < [Universe sharedInstance].score){
        [[Universe sharedInstance]setHighscore:[Universe sharedInstance].score];
    }
    [[Universe sharedInstance] setScore:0];
}

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
    printf("Performing segue with ID, so we can set things up.");
}

-(IBAction)unwindForSegue:(UIStoryboardSegue *)unwindSegue towardsViewController:(UIViewController *)subsequentVC
{
    [sv setHighscoreLab];
    printf("Backing out of the other view controller.");
}


@end
