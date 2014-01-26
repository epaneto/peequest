//
//  PQTutorial.m
//  PeeQuest
//
//  Created by Gabriel Laet on 1/26/14.
//  Copyright (c) 2014 Doubleleft. All rights reserved.
//

#import "PQTutorial.h"

@implementation PQTutorial
{
    NSMutableArray *steps;
    SPImage *current;
    int _currentStep;
}

- (void)build
{
    if(steps == NULL){
        steps = [[NSMutableArray alloc] init];
        [steps addObject:[[SPImage alloc] initWithContentsOfFile:@"tutorial01.png"]];
        [steps addObject:[[SPImage alloc] initWithContentsOfFile:@"tutorial02.png"]];
        [steps addObject:[[SPImage alloc] initWithContentsOfFile:@"tutorial05.png"]];
        [steps addObject:[[SPImage alloc] initWithContentsOfFile:@"tutorial03.png"]];
        [steps addObject:[[SPImage alloc] initWithContentsOfFile:@"tutorial04.png"]];
    }
    
    _currentStep = 0;
    [self update];
    [self performSelector:@selector(next) withObject:self afterDelay:4.0];
    [self performSelector:@selector(next) withObject:self afterDelay:7.0];
    [self performSelector:@selector(next) withObject:self afterDelay:10.0];
    
    [self setTouchable:NO];
    
}

- (void)update
{
    if(current != NULL){
        
        SPTween *tween = [SPTween tweenWithTarget:current time:0.5];
        [tween fadeTo:0.0];
        [Sparrow.juggler addObject:tween];
    }
    
    current = [steps objectAtIndex:_currentStep];
    current.alpha = 0;
    [self addChild:current];
    
    SPTween *tween = [SPTween tweenWithTarget:current time:0.5];
    [tween setDelay:0.3];
    [tween fadeTo:1.0];
    [Sparrow.juggler addObject:tween];
    
}

-(void)next
{
    _currentStep++;
    _currentStep = MIN(_currentStep,[steps count]-1);
    [self update];
}

-(void)reset
{
    _currentStep = 0;
    [self update];
}

-(int)step
{
    return _currentStep;
}
-(void)hide
{
    SPTween *tween = [SPTween tweenWithTarget:self time:0.5];
    [tween fadeTo:0.0];
    tween.onComplete = ^(){
        [self removeFromParent];
    };
    [Sparrow.juggler addObject:tween];
}
@end
