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
@property SKSpriteNode * view;
@end

@implementation PQBackgroundController

-(void)setup
{
    _view = [SKSpriteNode spriteNodeWithImageNamed:@"bg"];
}

-(void)show:(SKScene *)scene
{
    _view.position = CGPointMake(100,_view.size.height);
    [scene addChild:_view];
}

@end
