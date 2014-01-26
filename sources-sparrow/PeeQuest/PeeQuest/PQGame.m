//
//  PQGame.m
//  PeeQuest
//
//  Created by Gabriel Laet on 1/25/14.
//  Copyright (c) 2014 Doubleleft. All rights reserved.
//

#import "PQGame.h"
#import "PQGameController.h"
#import "PQHomeUI.h"
#import "PQPauseUI.h"
#import "PQFinishUI.h"
#import "PQBaseUI.h"
#import "PQGameplayUI.h"
#import "SPAVSoundChannel.h"

@interface PQGame()
{
    BOOL _soundMuted;
    SPSound* trackSound;
    SPSoundChannel *trackSoundChannel;
}
@property PQGameController * game;
@property PQBaseUI *currentView;
@end

@implementation PQGame : SPSprite

static PQGame *_sharedInstance = nil;

+ (PQGame *)sharedInstance {
    
    return _sharedInstance;
}

- (id)init
{
    if ((self = [super init]))
    {
        [self setup];
    }
    _sharedInstance = self;
    return self;
}

- (void)setup
{
    [SPAudioEngine start];
    _soundMuted = NO;
    
    trackSound = [[SPSound alloc] initWithContentsOfFile:@"track.aifc"];
    trackSoundChannel = [trackSound createChannel];
    trackSoundChannel.loop = YES;
    [trackSound play];
    
    container = [SPSprite sprite];
    [self addChild:container];
    
    _game = [[PQGameController alloc]init];
    [_game setup:container];
    
    [self setState:STATE_HOME];
}

- (void)setState:(int)state
{
    NSLog(@"setState %i", state);
    switch(state){
        case STATE_HOME:
            [self setView:[PQHomeUI class]];
            [container addEventListener:@selector(onStartTouch:)  atObject:self forType:SP_EVENT_TYPE_TOUCH];
            break;
            
        case STATE_PLAY:
            [self setView:[PQGameplayUI class]];
            [_game resume];
            break;
            
        case STATE_PAUSE:
            [self setView:[PQPauseUI class]];
            [_game pause];
            break;
            
        case STATE_FINISH:
            [self setView:[PQFinishUI class]];
            break;
            
        case STATE_RESTART:
            [_game start];
            [self setState:STATE_PLAY];
            break;
    }
}

-(void)setView:(Class)viewClass
{
    if(_currentView != NULL){
        [_currentView hide];
        _currentView = NULL;
    }
    
    if(viewClass != NULL){
        PQBaseUI *view = [[viewClass alloc] init];
        [container addChild:view];
        [view show];
        _currentView = view;
    }
}

- (void)onStartTouch:(SPTouchEvent*)event
{
    SPTouch *touch = [[event touchesWithTarget:self andPhase:SPTouchPhaseBegan] anyObject];
    if([touch phase] == SPTouchPhaseBegan){
        [[PQSoundPlayer sharedInstance] play:@"btn-press.caf"];
        [container removeEventListener:@selector(onStartTouch:)  atObject:self forType:SP_EVENT_TYPE_TOUCH];
        [self setState:STATE_RESTART];
    }
}

- (void)muteSound
{
    if(_soundMuted){
        return;
    }
    
   _soundMuted = YES;
    [SPAudioEngine setMasterVolume:0.0];
}

- (void)unmuteSound
{
    if(!_soundMuted){
        return;
    }
    _soundMuted = NO;
    [SPAudioEngine setMasterVolume:1.0];
    [trackSoundChannel play];
}

- (BOOL)isSoundMuted
{
    return _soundMuted;
}

- (BOOL)isWinner
{
    return [_game playerState] == PLAYER_STATE_WIN;
}

@end
