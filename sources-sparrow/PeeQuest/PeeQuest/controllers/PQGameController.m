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
    
    ////initialize timer
    [_mainContainer addEventListener:@selector(updateGame:) atObject:self forType:SP_EVENT_TYPE_ENTER_FRAME];
}

- (void)updateGame:(SPEnterFrameEvent *)event
{
    [_background updatePosition:10];
}
@end
