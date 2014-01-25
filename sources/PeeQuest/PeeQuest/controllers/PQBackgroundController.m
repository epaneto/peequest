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
@property SKSpriteNode * firstView;
@property SKSpriteNode * secondView;
@property int count;
@end

@implementation PQBackgroundController

-(void)setup
{
    _firstView = [SKSpriteNode spriteNodeWithImageNamed:@"bg"];
    _secondView = [SKSpriteNode spriteNodeWithImageNamed:@"bg"];
}

-(void)show:(SKScene *)scene
{
    _firstView.position = CGPointMake(0,_firstView.size.height);
    [scene addChild:_firstView];
    
    _secondView.position = CGPointMake(_secondView.size.width,_secondView.size.height);
    [scene addChild:_secondView];
}


-(void)updatePosition :(int)speed
{
    CGPoint position = CGPointMake(_firstView.position.x - speed, _firstView.position.y);
    CGPoint position2 = CGPointMake(_secondView.position.x - speed, _secondView.position.y);
    
    [_firstView setPosition:position];
    [_secondView setPosition:position2];
    
    if(_firstView.position.x < -_firstView.size.width)
    {
        position = CGPointMake(_secondView.position.x + _firstView.size.width, _firstView.position.y);
        [_firstView setPosition:position];
    }else if(_secondView.position.x < -_secondView.size.width)
    {
        position2 = CGPointMake(_firstView.position.x + _secondView.size.width, _secondView.position.y);
        [_secondView setPosition:position2];
    }
}

@end
