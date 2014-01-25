//
//  PQBackgroundController.m
//  PeeQuest
//
//  Created by Epaminondas Neto on 1/25/14.
//  Copyright (c) 2014 Doubleleft. All rights reserved.
//

#import "PQBackgroundController.h"

@interface PQBackgroundController()
@property SPImage * view;
@property (nonatomic,strong) SPTexture * texture;
@property float offset;
@end

@implementation PQBackgroundController

-(void)setup
{
    _texture = [[SPTexture alloc] initWithContentsOfFile:@"background.png"];
    _texture.repeat = YES;

    
    _view = [[SPImage alloc] initWithTexture:_texture];
}

-(void)show :(SPSprite * )scene
{
    _view.x = -_view.width/2;
    _view.y = -_view.height/2;
    
    [scene addChild:_view];
}

-(void)updatePosition:(float)speed
{
    _offset += (speed/1) * 0.001;
    
    [_view setTexCoordsWithX:  _offset y:0 ofVertex:0];
    [_view setTexCoordsWithX:1+_offset y:0 ofVertex:1];
    [_view setTexCoordsWithX:  _offset y:1 ofVertex:2];
    [_view setTexCoordsWithX:1+_offset y:1 ofVertex:3];

}
@end
