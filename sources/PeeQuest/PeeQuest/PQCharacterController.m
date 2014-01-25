//
//  PQCharacterController.m
//  PeeQuest
//
//  Created by Gabriel Laet on 1/25/14.
//  Copyright (c) 2014 Doubleleft. All rights reserved.
//

#import "PQCharacterController.h"

@interface PQCharacterController ()
@property SKSpriteNode * view;
@end

@implementation PQCharacterController

-(void)setup
{
    _view = [SKSpriteNode spriteNodeWithImageNamed:@"character"];
}

-(void)show:(SKScene *)scene
{
    _view.position = CGPointMake(100,_view.size.height);
    [scene addChild:_view];
}

@end
