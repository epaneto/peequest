//
//  MyScene.m
//  PeeQuest
//
//  Created by Epaminondas Neto on 1/25/14.
//  Copyright (c) 2014 Doubleleft. All rights reserved.
//

#import "PQScene.h"
#import "PQBackgroundController.h"
#import "PQCharacterController.h"

@interface PQScene()
@property PQBackgroundController * background;
@property PQCharacterController * character;
@property NSTimer * mainTimer;
@end

@implementation PQScene

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        
        
        [self setup];
    }
    return self;
}

-(void)setup{
    _background = [[PQBackgroundController alloc]init];
    [_background setup];
    
    _character = [[PQCharacterController alloc] init];
    [_character setup];
    
    [self show];
    
    _mainTimer = [NSTimer scheduledTimerWithTimeInterval: 0.01 target: self selector:@selector(onTick:) userInfo: nil repeats:YES];
    [_mainTimer fire];
}

-(void)show{
    [_background show:self];
    [_character show:self];
    
    SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"Verdana"];
    myLabel.text = @"Press to Play!";
    myLabel.fontSize = 30;
    myLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                   CGRectGetMidY(self.frame));
    [self addChild:myLabel];
}

-(void)onTick:(NSTimer *)timer {
    [self updatePosition:1];
}

-(void)updatePosition :(int) speed
{
    [_background updatePosition:speed];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
//    for (UITouch *touch in touches) {
//        CGPoint location = [touch locationInNode:self];
//        
//        SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:@"Spaceship"];
//        
//        sprite.position = location;
//        
//        SKAction *action = [SKAction rotateByAngle:M_PI duration:1];
//        
//        [sprite runAction:[SKAction repeatActionForever:action]];
//        
//        [self addChild:sprite];
//    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
