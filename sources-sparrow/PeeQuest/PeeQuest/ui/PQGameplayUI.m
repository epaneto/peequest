//
//  PQGameplayUI.m
//  PeeQuest
//
//  Created by Gabriel Laet on 1/25/14.
//  Copyright (c) 2014 Doubleleft. All rights reserved.
//

#import "PQGameplayUI.h"
#import "PQGameController.h"

@implementation PQGameplayUI
{
    SPButton *pauseButton;
    SPSprite *lifes;
    NSMutableArray *hearts;
}


static PQGameplayUI *_sharedInstance = nil;

+ (PQGameplayUI *)sharedInstance {
    return _sharedInstance;
}

- (void)updateLifes:(int)lifesCount
{
    SPTexture *heartActive = [[SPTexture alloc] initWithContentsOfFile:@"heart-active.png"];
    SPTexture *heartDisabled = [[SPTexture alloc] initWithContentsOfFile:@"heart-disabled.png"];
    
    for(int i = 0; i<[hearts count]; i++){
        SPImage *heart = [hearts objectAtIndex:i];
        if(i < lifesCount){
            [heart setTexture:heartActive];
        }else{
            [heart setTexture:heartDisabled];
        }
    }
}

-(void)build
{
    _sharedInstance = self;
    int margin = 10;
    
    if(pauseButton == NULL){
        SPTexture *texture = [[SPTexture alloc] initWithContentsOfFile:@"pause-btn.png"];
        pauseButton = [[SPButton alloc] initWithUpState:texture];
        [self addChild:pauseButton];
        
        pauseButton.x = Sparrow.stage.width - pauseButton.width - margin;
        pauseButton.y = margin;
        [pauseButton addEventListener:@selector(pauseTouch:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    }
    
    if(lifes == NULL){
        lifes = [SPSprite sprite];
        lifes.x = margin;
        lifes.y = margin;
        [self addChild:lifes];
        
        hearts = [[NSMutableArray alloc] init];
        for(int i = 0; i<PLAYER_LIFES; i++){
            SPImage *heart = [[SPImage alloc] initWithContentsOfFile:@"heart-active.png"];
            heart.x = (heart.width * i) + 5;
            [hearts addObject:heart];
            [lifes addChild:heart];
        }
    }
}

- (void)pauseTouch:(SPTouchEvent*)event
{
    SPButton *button = (SPButton*)event.currentTarget;
    SPTouch *touch = [[event touchesWithTarget:self andPhase:SPTouchPhaseBegan] anyObject];

    if([touch phase] != SPTouchPhaseEnded && button.isDown){
        [[PQSoundPlayer sharedInstance] play:@"btn-press.caf"];
        [[PQGame sharedInstance] setState:STATE_PAUSE];
    }
}

-(void)show
{
    [self build];
    [super show];
}

-(void)hide
{
    _sharedInstance = NULL;
    [super hide];
    [self removeFromParent];
}
@end
