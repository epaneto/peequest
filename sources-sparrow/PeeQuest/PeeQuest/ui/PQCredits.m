//
//  PQCredits.m
//  PeeQuest
//
//  Created by Gabriel Laet on 1/26/14.
//  Copyright (c) 2014 Doubleleft. All rights reserved.
//

#import "PQCredits.h"
#import "PQGame.h"

@implementation PQCredits
{
    NSMutableArray *steps;
    SPImage *current;
    SPButton *closeButton;
    int step;
    BOOL hidden;
}

-(void)show
{
    if(steps == NULL){
        steps = [[NSMutableArray alloc] init];
        [steps addObject:[[SPImage alloc] initWithContentsOfFile:@"credits1.png"]];
        [steps addObject:[[SPImage alloc] initWithContentsOfFile:@"credits2.png"]];
        [steps addObject:[[SPImage alloc] initWithContentsOfFile:@"credits3.png"]];
        [steps addObject:[[SPImage alloc] initWithContentsOfFile:@"credits4.png"]];
        [steps addObject:[[SPImage alloc] initWithContentsOfFile:@"credits5.png"]];
        [steps addObject:[[SPImage alloc] initWithContentsOfFile:@"credits6.png"]];
    }
    
    if(closeButton == NULL){
        SPTexture* closeButtonTexture = [[SPTexture alloc] initWithContentsOfFile:@"credits-close.png"];
        closeButton = [[SPButton alloc] initWithUpState:closeButtonTexture];
        closeButton.x = Sparrow.stage.width - closeButton.width - 10;
        closeButton.y = Sparrow.stage.height - closeButton.height - 10;
        [closeButton addEventListener:@selector(buttonTouch:) atObject:self forType:SP_EVENT_TYPE_TOUCH];

        [self addChild:closeButton];
    }
    
    step = 0;
    [self next];
    hidden = NO;
}

-(void)hide
{
    hidden = YES;
    if(current != NULL){
        [Sparrow.juggler removeObjectsWithTarget:current];
    }
    [self removeFromParent];
    [steps removeAllObjects];
    [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(next) object:nil];
    
}

-(void)next
{
    if(hidden) return;
    if(current != NULL){
        SPTween *currentTween = [SPTween tweenWithTarget:current time:0.8 transition:SP_TRANSITION_EASE_OUT_BACK];
        [currentTween moveToX:-Sparrow.stage.width y:0];
        [Sparrow.juggler addObject:currentTween];
        current = NULL;
    }
    
    if(step < [steps count]){
        SPImage *next = [steps objectAtIndex:step];
        next.x = Sparrow.stage.width;
        SPTween *nextTween = [SPTween tweenWithTarget:next time:0.8 transition:SP_TRANSITION_EASE_IN_OUT_BACK];
        [nextTween moveToX:0 y:0];
        [Sparrow.juggler addObject:nextTween];
        [self addChild:next];
        
        current = next;
        [self performSelector:@selector(next) withObject:self afterDelay:3.0];
        step++;
        [self addChild:closeButton];
        
    }else{
        [[PQGame sharedInstance] setState:STATE_HOME];
    }
}


- (void)buttonTouch:(SPTouchEvent*)event
{
    SPButton *button = (SPButton*)event.currentTarget;
    SPTouch *touch = [[event touchesWithTarget:self andPhase:SPTouchPhaseBegan] anyObject];
    
    NSSet *touches = [event touchesWithTarget:self];
    if (touches.count) [event stopPropagation];
    
    if([touch phase] == SPTouchPhaseBegan && button.isDown){
        [[PQGame sharedInstance] setState:STATE_HOME];
    }
}

@end
