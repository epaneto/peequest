//
//  PQGame.m
//  PeeQuest
//
//  Created by Gabriel Laet on 1/25/14.
//  Copyright (c) 2014 Doubleleft. All rights reserved.
//

#import "PQLevelController.h"
#import "PQGame.h"
#import "PQGameController.h"
#import "PQHomeUI.h"
#import "PQPauseUI.h"
#import "PQFinishUI.h"
#import "PQBaseUI.h"

#define STATE_HOME 1
#define STATE_PLAY 2
#define STATE_PAUSE 3
#define STATE_FINISH 4

@interface PQGame()
@property PQGameController * game;
@property PQBaseUI *currentView;
@end

@implementation PQGame : SPSprite

- (id)init
{
    if ((self = [super init]))
    {
        [self setup];
    }
    return self;
}

- (void)setup
{
    [SPAudioEngine start];
    
    container = [SPSprite sprite];
    [self addChild:container];
    
    _game = [[PQGameController alloc]init];
    [_game setup:container];
    
    NSData *jsonData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"peeQuest" ofType:@"json"]];
    
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
    
    SPSprite *levelContainer = [[PQLevelController sharedInstance] makeLevelWithDict:dict];
    [container addChild:levelContainer];
    
    [self setState:STATE_HOME];
}

- (void)setState:(int)state
{
    switch(state){
        case STATE_HOME:
            [self setView:[PQHomeUI class]];
            break;
            
        case STATE_PLAY:
            [self setView:NULL];
            break;
            
        case STATE_PAUSE:
            [self setView:[PQPauseUI class]];
            break;
            
        case STATE_FINISH:
            [self setView:[PQFinishUI class]];
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

@end
