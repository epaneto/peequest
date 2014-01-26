//
//  PQGameplayUI.m
//  PeeQuest
//
//  Created by Gabriel Laet on 1/25/14.
//  Copyright (c) 2014 Doubleleft. All rights reserved.
//

#import "PQGameplayUI.h"

@implementation PQGameplayUI
{
    SPButton *pauseButton;
}

-(void)build
{
    if(pauseButton == NULL){
        SPTexture *texture = [[SPTexture alloc] initWithContentsOfFile:@"pause-btn.png"];
        pauseButton = [[SPButton alloc] initWithUpState:texture];
        [self addChild:pauseButton];
        
        int margin = 10;
        pauseButton.x = Sparrow.stage.width - pauseButton.width - margin;
        pauseButton.y = margin;
        [pauseButton addEventListener:@selector(pauseTouch:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
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
    [super hide];
    [self removeFromParent];
}
@end
