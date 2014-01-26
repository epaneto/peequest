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
@property SPMovieClip * shadow_view;
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
    NSArray *player_textures = [atlas texturesStartingWith:@"hero_export/"];
    NSLog(@"%@",player_textures);
    NSArray *shadow_textures = [atlas texturesStartingWith:@"shadow_export/walk_"];
    NSLog(@"%@",shadow_textures);
    
    // create movie clip
    _shadow_view = [[SPMovieClip alloc] initWithFrames:shadow_textures fps:60];
    _shadow_view.loop = YES;
    [Sparrow.juggler addObject:_shadow_view];
    [_shadow_view play];
    
   _view = [[SPMovieClip alloc] initWithFrames:player_textures fps:60];
    _view.loop = YES;
    [Sparrow.juggler addObject:_view];
    [_view play];
    
    
    
    _idleColor = _view.color;
    _darkColor = 0xb49c9c;
    _view.color = _darkColor;
}

-(void)show:(SPSprite *)container
{
    _view.x = 123;
    _view.y = 190;
    
    _shadow_view.x = 130;
    _shadow_view.y = 50;
    
    _shadow_view.scaleX = _shadow_view.scaleY = 1.7;
    
    [container addChild:_shadow_view];
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
        return 2;
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

-(SPRectangle*)bounds
{
    return _view.bounds;
}


-(SPRectangle*)shadowBounds
{
    return _shadow_view.bounds;
}

@end