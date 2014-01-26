//
//  PQGameController.m
//  PeeQuest
//
//  Created by Epaminondas Neto on 1/25/14.
//  Copyright (c) 2014 Doubleleft. All rights reserved.
//

#import "PQGameController.h"
#import "PQBackgroundController.h"
#import "PQPlayerController.h"

@interface PQGameController ()
@property SPSprite * mainContainer;
@property PQBackgroundController * background;
@property PQPlayerController * player;
@property BOOL paused;
@property NSTimer * mainTimer;
@end

@implementation PQGameController

-(void)setup:(SPSprite *)container
{
    _mainContainer = container;
    
    ////initialize background
    _background = [[PQBackgroundController alloc] init];
    [_background setup];
    [_background show:_mainContainer];
    
    ////initialize player
    _player = [[PQPlayerController alloc] init];
    [_player setup];
    [_player show:_mainContainer];
    
    ////initialize enter frame
    [_mainContainer addEventListener:@selector(updateGame:) atObject:self forType:SP_EVENT_TYPE_ENTER_FRAME];
    
    ////initialize touch
    [_mainContainer addEventListener:@selector(onUserTouch:)  atObject:self forType:SP_EVENT_TYPE_TOUCH];
    
    _paused = YES;
}

-(void)initRainTimer
{
    int randomTime = 2.0 + arc4random() % 5;
    NSLog(@"%i",randomTime);
    _mainTimer = [NSTimer scheduledTimerWithTimeInterval:randomTime target:self selector:@selector(initRain:) userInfo:nil repeats:NO];
}

-(void)initRain:(NSTimer *)timer {
    if(_paused){
        return;
    }
    [self showRain];
    [self initRainTimer];
}

-(void)showRain {
    [_background showRain];
    [_player showRain];
}

- (void)pause
{
    _paused = YES;
    [_player stopWalk];
    if(_mainTimer != NULL){
        [_mainTimer invalidate];
    }
}

- (void)resume
{
    _paused = NO;
    
    ////initialize timer
    [self initRainTimer];
}

- (void)start
{
    [self resume];
}

- (void)onUserTouch:(SPTouchEvent*)event
{
    if(_paused) return;
    SPTouch *touch = [[event touchesWithTarget:_mainContainer
                                      andPhase:SPTouchPhaseBegan] anyObject];
    if (touch && touch.globalY > 100)
    {
        [_player toogleMove];
    }
}

- (void)updateGame:(SPEnterFrameEvent *)event
{
    if(_paused) return;
    [_background updatePosition:[_player getVelocity]];
}
@end
