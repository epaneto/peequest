//
//  PQBackgroundController.m
//  PeeQuest
//
//  Created by Epaminondas Neto on 1/25/14.
//  Copyright (c) 2014 Doubleleft. All rights reserved.
//

#import "PQBackgroundController.h"
#import "SHAnimatableColor.h"

@interface PQBackgroundController()
@property SPImage * view;
@property (nonatomic,strong) SPTexture * texture;
@property float offset;
@property uint idleColor;
@property uint darkColor;
@property NSTimer * rainTimer;
@property BOOL isDark;
@end

@implementation PQBackgroundController

-(void)setup
{
    _texture = [[SPTexture alloc] initWithContentsOfFile:@"background.png"];
    _texture.repeat = YES;
    
    _view = [[SPImage alloc] initWithTexture:_texture];
    _idleColor = _view.color;
    _view.width = Sparrow.stage.width;
    _darkColor = 0xb49c9c;
    _view.color = _darkColor;
}

-(void)show :(SPSprite * )scene
{
    [scene addChild:_view];
}

-(void)updatePosition:(float)speed
{
    _offset += (speed) * 0.001;
    if(_offset > 1.0){
        _offset = 0.0;
    }
    
    [_view setTexCoordsWithX:  _offset y:0 ofVertex:0];
    [_view setTexCoordsWithX:1+_offset y:0 ofVertex:1];
    [_view setTexCoordsWithX:  _offset y:1 ofVertex:2];
    [_view setTexCoordsWithX:1+_offset y:1 ofVertex:3];
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
