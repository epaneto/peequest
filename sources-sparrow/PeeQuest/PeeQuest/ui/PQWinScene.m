//
//  PQWinScene.m
//  PeeQuest
//
//  Created by Gabriel Laet on 1/26/14.
//  Copyright (c) 2014 Doubleleft. All rights reserved.
//

#import "PQWinScene.h"

@implementation PQWinScene
{
    SPImage *background;
    SPTextureAtlas *playerAtlas;
    SPMovieClip *player;
}

- (void)show
{
    background = [[SPImage alloc] initWithContentsOfFile:@"win-background.png"];
    [self addChild:background];
    
    playerAtlas = [[SPTextureAtlas alloc] initWithContentsOfFile:@"ending_hero.xml"];
    [self playAnimation:@"ending_hero/win_"];
}

-(void)hide
{
    [self removeFromParent];
}

-(void) playAnimation :(NSString * )label
{
    ////clear previous animation
    if(player){
        [self removeChild:player];
        [Sparrow.juggler removeObject:player];
    }
    
    ////show next animation
    NSArray *textures = [playerAtlas texturesStartingWith:label];
    player = [[SPMovieClip alloc] initWithFrames:textures fps:30];
    player.loop = YES;
    [Sparrow.juggler addObject:player];
    [player play];
    
    if([label isEqualToString:@"ending_hero/win_"]){
        [player addEventListener:@selector(loopAnimation) atObject:self forType:SP_EVENT_TYPE_COMPLETED];
    }else{
        player.loop = YES;
    }
    player.x = Sparrow.stage.width / 2 - player.width / 2;
    player.y = Sparrow.stage.height - player.height - 85;
    [self addChild:player];
}

-(void)loopAnimation
{
    if(player != NULL){
        [player removeEventListener:@selector(loopAnimation) atObject:self forType:SP_EVENT_TYPE_COMPLETED];
    }
    [self playAnimation:@"ending_hero/winning_"];
}
@end
