//
//  BackgroundController.m
//  PeeQuest
//
//  Created by Epaminondas Neto on 1/25/14.
//  Copyright (c) 2014 Doubleleft. All rights reserved.
//

#import "PQBackgroundController.h"
#import "PQBackgroundView.h"

@interface PQBackgroundController()
@property PQBackgroundView * view;
@end

@implementation PQBackgroundController

-(void)setup
{
    _view = [[PQBackgroundView alloc]init];
    _view.texture = [SKTexture textureWithImageNamed:@"background.png"];
}

-(void)show:(SKScene *)scene
{
    [scene addChild:_view];
}

@end
