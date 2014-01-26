//
//  PQPlayerController.m
//  PeeQuest
//
//  Created by Epaminondas Neto on 1/25/14.
//  Copyright (c) 2014 Doubleleft. All rights reserved.
//

#import "PQPlayerController.h"
#import "SHAnimatableColor.h"

@interface PQPlayerController()
@property SPMovieClip * view;
@property (nonatomic,strong) SPTexture * texture;
@property BOOL isWalking;
@property uint idleColor;
@property uint darkColor;
@end

@implementation PQPlayerController
-(void)setup
{
//    _texture = [[SPTexture alloc] initWithContentsOfFile:@"character.png"];
//    _view = [[SPImage alloc] initWithTexture:_texture];
    
    _isWalking = YES;
    
    // we're using the textures from an atlas
    SPTextureAtlas *atlas = [SPTextureAtlas atlasWithContentsOfFile:@"player.xml"];
    
    // this method returns all textures starting with the given string, sorted alphabetically.
    NSArray *textures = [atlas texturesStartingWith:@"hero_test/walk_"];
    
    // create movie clip
   _view = [[SPMovieClip alloc] initWithFrames:textures fps:60];
    _view.loop = YES;
    [Sparrow.juggler addObject:_view];
    [_view play];
    
    _idleColor = _view.color;
    _darkColor = 0xb49c9c;
    _view.color = _darkColor;
}

-(void)show:(SPSprite *)container
{
    _view.x = 120;
    _view.y = 160;
    
    [container addChild:_view];
}

-(void)toogleMove
{
    _isWalking = !_isWalking;
}

-(void)stopWalk
{
    _isWalking = NO;
}
-(void)startWalk
{
    _isWalking = YES;
}

-(int)getVelocity
{
    if(_isWalking)
        return 3;
    else
        return 0;
}

-(void)showRain
{
    SPTween * tween = [SPTween tweenWithTarget:_view time:0.4 transition:SP_TRANSITION_EASE_OUT_BOUNCE];
    [tween animateColorWithTargetValue:_idleColor];
    tween.repeatCount = 2;
    tween.reverse = YES;
    [Sparrow.juggler addObject:tween];
    
    NSLog(@"show rain");
}

@end