//
//  BackgroundController.m
//  PeeQuest
//
//  Created by Epaminondas Neto on 1/25/14.
//  Copyright (c) 2014 Doubleleft. All rights reserved.
//

#import "BackgroundController.h"

@interface BackgroundController()
@property SKSpriteNode * view;
@end

@implementation BackgroundController

-(void)setup
{
    _view = [[SKSpriteNode alloc]init];
    _view.texture = [SKTexture textureWithImageNamed:@"background.png"];
}

-(void)show:(SKScene *)scene
{
    [scene addChild:_view];
}

@end
