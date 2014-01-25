//
//  PQCharacterController.m
//  PeeQuest
//
//  Created by Gabriel Laet on 1/25/14.
//  Copyright (c) 2014 Doubleleft. All rights reserved.
//

#import "PQCharacterController.h"

@interface PQCharacterController ()
{
    float velocity;
    bool isIdle;
}
@property SKSpriteNode * view;
@end

@implementation PQCharacterController

-(void)setup
{
    velocity = 0.0;
    isIdle = YES;
    _view = [SKSpriteNode spriteNodeWithImageNamed:@"character"];
}

-(void)show:(SKScene *)scene
{
    _view.position = CGPointMake(-_view.size.width, CGRectGetMidY(scene.frame));
    [scene addChild:_view];
}

- (void)toggleWalk
{
    if(isIdle){
        [self walk];
    }else{
        [self idle];
    }
}

- (void)walk
{
    isIdle = NO;
    velocity = 3.0;
}

- (void)idle
{
    isIdle = YES;
    velocity = 0.0;
}

-(void)updatePosition:(int)speed
{
    CGPoint position = _view.position;
    position.x += ((position.x+velocity) - position.x) / 4;
    [_view setPosition:position];
}

@end
