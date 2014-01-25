//
//  PQPlayerController.m
//  PeeQuest
//
//  Created by Epaminondas Neto on 1/25/14.
//  Copyright (c) 2014 Doubleleft. All rights reserved.
//

#import "PQPlayerController.h"

@interface PQPlayerController()
@property SPImage * view;
@property (nonatomic,strong) SPTexture * texture;
@property BOOL isWalking;
@end

@implementation PQPlayerController
-(void)setup
{
    _texture = [[SPTexture alloc] initWithContentsOfFile:@"character.png"];
    _view = [[SPImage alloc] initWithTexture:_texture];
    
    _isWalking = YES;
}

-(void)show:(SPSprite *)container
{
    _view.x = 120;
    _view.y = 200;
    
    [container addChild:_view];
}

-(void)toogleMove
{
    _isWalking = !_isWalking;
}

-(int)getVelocity
{
    if(_isWalking)
        return 10;
    else
        return 0;
}

@end