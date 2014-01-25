//
//  PQGame.m
//  PeeQuest
//
//  Created by Gabriel Laet on 1/25/14.
//  Copyright (c) 2014 Doubleleft. All rights reserved.
//

#import "PQGame.h"
#import "PQGameController.h"

@interface PQGame()
@property PQGameController * game;
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
    
    [self addEventListener:@selector(onResize:) atObject:self forType:SP_EVENT_TYPE_RESIZE];
    [self updateLocations];
    
    _game = [[PQGameController alloc]init];
    [_game setup:container];
    
}


- (void)updateLocations
{
    int gameWidth  = Sparrow.stage.width;
    int gameHeight = Sparrow.stage.height;
    
    container.x = (int) (gameWidth  - container.width)  / 2;
    container.y = (int) (gameHeight - container.height) / 2;
}

- (void)onResize:(SPResizeEvent *)event
{
    [self updateLocations];
}

@end
