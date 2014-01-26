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
{
    int walkStep;
}
@property SPMovieClip * view;
@property SPMovieClip * shadow_view;
@property (nonatomic,strong) SPTexture * texture;
@property BOOL isWalking;
@property BOOL isDamaged;
@property uint idleColor;
@property uint darkColor;
@property (nonatomic,strong) SPTextureAtlas * playerAtlas;
@property (nonatomic,strong) SPTextureAtlas * shadowAtlas;
@property (nonatomic,strong) NSArray *player_textures;
@property (nonatomic,strong) NSArray *shadow_textures;
@property (nonatomic,strong) SPSprite * container;
@end

@implementation PQPlayerController
-(void)setup
{
    _isWalking = NO;
    
    // initialize player atlas
    _playerAtlas = [SPTextureAtlas atlasWithContentsOfFile:@"player.xml"];
    
    // initialize shadow atlas
    _shadowAtlas = [SPTextureAtlas atlasWithContentsOfFile:@"player_shadow.xml"];

    ///show player animation
    [self showPlayerAnimation:@"hero_idle/idle_"];
    
    [self showShadowAnimation:@"shadow_walk/walk_"];
}

-(void)walkLoop
{
    if(_isWalking){
        NSString *soundName = walkStep % 2 == 0 ? @"wood2.caf" : @"wood1.caf";
        [[PQSoundPlayer sharedInstance] play:soundName];
        walkStep++;
    }
}

-(void)show:(SPSprite *)container
{
    _container = container;
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
    
    if(_isWalking)
       [self startWalk];
    else
        [self stopWalk];
}

-(void)stopWalk
{
    _isWalking = NO;
    
    [self showShadowAnimation:@"shadow_idle/idle_"];

    [self showPlayerAnimation:@"hero_idle/idle_"];
    
}
-(void)startWalk
{
    _isWalking = YES;
    
    [self showShadowAnimation:@"shadow_walk/walk_"];

    [self showPlayerAnimation:@"hero_walk/walk_"];
}

-(void)showWin
{
//    [self showPlayerAnimation:@"hero_export/"];
}

-(void)showLose
{
    [self showPlayerAnimation:@"hero_die/die_"];
    
    
    __block PQPlayerController * myself = self;
    [_view addEventListenerForType:SP_EVENT_TYPE_COMPLETED block:^(id event) {
        [myself showPlayerAnimation:@"hero_die/dead_"];
    }];
    
    if(_shadow_view){
        [_container removeChild:_shadow_view];
        [Sparrow.juggler removeObject:_shadow_view];
    }
}

-(void)showDamage
{
    if(_isDamaged){
        return;
    }
    SPTween * tween = [SPTween tweenWithTarget:_view time:0.4 transition:SP_TRANSITION_EASE_OUT_BOUNCE];
    [tween fadeTo:0];
    tween.repeatCount = 2;
    tween.reverse = YES;
    _isDamaged = YES;
    [Sparrow.juggler addObject:tween];
    [self performSelector:@selector(resetDamage) withObject:self afterDelay:1.0];
}

-(void)resetDamage
{
    _isDamaged = NO;
}

-(void) showPlayerAnimation :(NSString * )label
{
    ////clear previous animation
    if(_view){
        [_container removeChild:_view];
        [Sparrow.juggler removeObject:_view];
        [_view removeEventListener:@selector(walkLoop) atObject:self forType:SP_EVENT_TYPE_COMPLETED];
    }
    
    ////show next animation
    _player_textures = [_playerAtlas texturesStartingWith:label];
    _view = [[SPMovieClip alloc] initWithFrames:_player_textures fps:30];
    _view.loop = YES;
    [Sparrow.juggler addObject:_view];
    [_view play];
    [_view addEventListener:@selector(walkLoop) atObject:self forType:SP_EVENT_TYPE_COMPLETED];
    
    _idleColor = _view.color;
    _darkColor = 0xb49c9c;
    _view.color = _darkColor;
    
    _view.x = 123;
    _view.y = 190;
    [_container addChild:_view];
}

-(void) showShadowAnimation :(NSString * )label
{
    ////clear previous animation
    if(_shadow_view){
        [_container removeChild:_shadow_view];
        [Sparrow.juggler removeObject:_shadow_view];
    }
    
    ////show next animation
    _shadow_textures = [_shadowAtlas texturesStartingWith:label];
    _shadow_view = [[SPMovieClip alloc] initWithFrames:_shadow_textures fps:30];
    _shadow_view.loop = YES;
    [Sparrow.juggler addObject:_shadow_view];
    [_shadow_view play];
    
    _shadow_view.x = 130;
    _shadow_view.y = 50;
    
    _shadow_view.scaleX = _shadow_view.scaleY = 1.7;

    [_container addChild:_shadow_view];
}

-(int)getVelocity
{
    if(_isDamaged)
        return -1;
    else if(_isWalking)
        return 2;
    else
        return 0;
}

-(SPRectangle * )getShadow
{
    return _shadow_view.bounds;
}

-(SPRectangle * )getBody
{
    return _view.bounds;
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