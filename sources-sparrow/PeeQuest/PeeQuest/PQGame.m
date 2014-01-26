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
#import "PQWinScene.h"

@interface PQGame()
{
    BOOL _soundMuted;
    SPSound* trackSound;
    SPSoundChannel *trackSoundChannel;
    PQWinScene *winnerScreen;
    int _state;
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
    
    trackSound = [[SPSound alloc] initWithContentsOfFile:@"track.caf"];
    trackSoundChannel = [trackSound createChannel];
    trackSoundChannel.loop = YES;
    [trackSoundChannel play];
    
    container = [SPSprite sprite];
    [self addChild:container];
    
    containerUI = [SPSprite sprite];
    [self addChild:containerUI];
    
    _game = [[PQGameController alloc]init];
    [_game setup:container];
    
    [self setState:STATE_HOME];
}

- (void)setState:(int)state
{
    if(_state == state){
        return;
    }
    
    if(winnerScreen != NULL){
        [winnerScreen hide];
        winnerScreen = NULL;
    }
    
    NSLog(@"setState %i", state);
    _state = state;
    switch(state){
        case STATE_HOME:
            [self setView:[PQHomeUI class]];
            [containerUI addEventListener:@selector(onStartTouch:)  atObject:self forType:SP_EVENT_TYPE_TOUCH];
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
            
            if([self isWinner]){
                if(winnerScreen == NULL){
                    winnerScreen = [[PQWinScene alloc] init];
                    [winnerScreen show];
                    [self addChild:winnerScreen];
                    [self swapChild:winnerScreen withChild:containerUI];
                }
            }
            [containerUI addEventListener:@selector(onStartTouch:)  atObject:self forType:SP_EVENT_TYPE_TOUCH];
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
        [containerUI addChild:view];
        [view show];
        _currentView = view;
    }
}

- (void)onStartTouch:(SPTouchEvent*)event
{
    SPTouch *touch = [[event touchesWithTarget:self andPhase:SPTouchPhaseBegan] anyObject];
    
    if([touch phase] == SPTouchPhaseBegan){
        [[PQSoundPlayer sharedInstance] play:@"btn-press.caf"];
        [containerUI removeEventListener:@selector(onStartTouch:)  atObject:self forType:SP_EVENT_TYPE_TOUCH];
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
}

- (BOOL)isSoundMuted
{
    return _soundMuted;
}

- (BOOL)isWinner
{
//    return [_game playerState] == PLAYER_STATE_WIN;
    return YES;
}

-(int)state
{
    return _state;
}

@end
