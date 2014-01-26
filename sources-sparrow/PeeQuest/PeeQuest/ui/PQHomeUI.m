//
//  PQHomeUI.m
//  PeeQuest
//
//  Created by Gabriel Laet on 1/25/14.
//  Copyright (c) 2014 Doubleleft. All rights reserved.
//

#import "PQHomeUI.h"
#import "PQGame.h"

@implementation PQHomeUI
{
    SPMovieClip *logo;
    SPImage *tapToStart;
    SPButton *creditsButton;
    SPTextureAtlas* logoAtlas;
    NSArray *textures;
}

-(void)build
{
    if(logo == NULL){
        
        logoAtlas = [[SPTextureAtlas alloc] initWithContentsOfFile:@"logo.xml"];
        textures = [logoAtlas texturesStartingWith:@"logo/intro_"];
        
        logo = [[SPMovieClip alloc] initWithFrames:textures fps:30];
        logo.loop = NO;
        logo.x = Sparrow.stage.width / 2 - logo.width / 2;
        logo.y = 45;
        [self addChild:logo];
    }
    
    if(tapToStart == NULL){
        tapToStart = [[SPImage alloc] initWithContentsOfFile:@"taptostart-title.png"];
        tapToStart.x = Sparrow.stage.width / 2 - tapToStart.width / 2;
        tapToStart.y = logo.y + logo.height + 20;
        tapToStart.alpha = 0.0;
        
        SPTween *tapToStartTween = [SPTween tweenWithTarget:tapToStart time:0.5 transition:SP_TRANSITION_EASE_OUT];
        [tapToStartTween setDelay:1.2];
        [tapToStartTween fadeTo:1.0];
        [tapToStartTween moveToX:tapToStart.x y:logo.y + logo.height + 10];
        [Sparrow.juggler addObject:tapToStartTween];
        [self addChild:tapToStart];
    }
    
    if(creditsButton == NULL){
        SPTexture* creditsButtonTexture = [[SPTexture alloc] initWithContentsOfFile:@"credits-info.png"];
        creditsButton = [[SPButton alloc] initWithUpState:creditsButtonTexture];
        creditsButton.x = Sparrow.stage.width - creditsButton.width - 10;
        creditsButton.y = Sparrow.stage.height - creditsButton.height - 10;
        [creditsButton addEventListener:@selector(buttonTouch:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
        [self addChild:creditsButton];
    }
}


- (void)buttonTouch:(SPTouchEvent*)event
{
    SPButton *button = (SPButton*)event.currentTarget;
    SPTouch *touch = [[event touchesWithTarget:self andPhase:SPTouchPhaseBegan] anyObject];
    
    NSSet *touches = [event touchesWithTarget:self];
    if (touches.count) [event stopPropagation];
    
    if([touch phase] == SPTouchPhaseBegan && button.isDown){
        [[PQGame sharedInstance] setState:STATE_CREDITS];
    }
}

- (void)show
{
    [self build];
    [super show];
    
    [Sparrow.juggler addObject:logo];
}

- (void)hide
{
    [super hide];
    
    SPTween *tweenLogo = [SPTween tweenWithTarget:logo time:0.5 transition:SP_TRANSITION_EASE_OUT];
    [tweenLogo moveToX:logo.x y:-100];
    [tweenLogo fadeTo:0.0f];
    
    SPTween *tweenTitle = [SPTween tweenWithTarget:tapToStart time:0.5 transition:SP_TRANSITION_EASE_OUT];
    [tweenTitle moveToX:tapToStart.x y:400];
    [tweenTitle fadeTo:0.0f];
    
    [Sparrow.juggler addObject:tweenTitle];
    [Sparrow.juggler addObject:tweenLogo];
    
    tweenLogo.onComplete =  ^() {
        [self removeFromParent];
    };
}
@end
