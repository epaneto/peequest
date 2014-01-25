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
@end

@implementation PQPlayerController
-(void)setup
{
    _texture = [[SPTexture alloc] initWithContentsOfFile:@"character.png"];
    _view = [[SPImage alloc] initWithTexture:_texture];
}

-(void)show:(SPSprite *)container
{
    _view.x = -190;
    _view.y = 60;
    
    [container addChild:_view];
}

@end