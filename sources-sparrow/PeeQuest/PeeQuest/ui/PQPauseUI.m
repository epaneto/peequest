//
//  PQPauseUI.m
//  PeeQuest
//
//  Created by Gabriel Laet on 1/25/14.
//  Copyright (c) 2014 Doubleleft. All rights reserved.
//

#import "PQPauseUI.h"
#import "PQGame.h"

@implementation PQPauseUI
{
    SPImage *title;
    SPSprite *menu;
    SPButton *returnButton;
    SPButton *retryButton;
    SPButton *soundButton;
}

-(void)build
{
    int spacing = 10;
    
    if(title == NULL){
        title = [[SPImage alloc] initWithContentsOfFile:@"pause-title.png"];
        title.x = Sparrow.stage.width / 2 - title.width / 2;
        [self addChild:title];
    }
    
    if(menu == NULL){
        menu = [SPSprite sprite];
        menu.y = 75;
        [self addChild:menu];
    }
    if(returnButton == NULL){
        returnButton = [self addButton:@"pause-return-btn.png"];
        [menu addChild:returnButton];
    }

    if(retryButton == NULL){
        retryButton = [self addButton:@"pause-retry-btn.png"];
        retryButton.y = returnButton.y + returnButton.height + spacing;
        [menu addChild:retryButton];
    }

    if(soundButton == NULL){
        soundButton = [self addButton:[self soundButtonTextureImage]];
        soundButton.y = retryButton.y + retryButton.height + spacing;
        [menu addChild:soundButton];
    }
    
    menu.x = Sparrow.stage.width / 2 - menu.width / 2;
    self.y = (Sparrow.stage.height / 2 - self.height / 2);
}

-(SPButton*)addButton:(NSString*)image
{
    SPTexture *texture = [[SPTexture alloc] initWithContentsOfFile:image];
    SPButton *button = [[SPButton alloc] initWithUpState:texture];
    [button addEventListener:@selector(buttonTouch:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    return button;
}

- (void)buttonTouch:(SPTouchEvent*)event
{
    SPButton *button = (SPButton*)event.currentTarget;
    SPTouch *touch = [[event touchesWithTarget:self andPhase:SPTouchPhaseBegan] anyObject];
    if([touch phase] != SPTouchPhaseEnded && button.isDown){
        if([button isEqual:returnButton]){
            [[PQGame sharedInstance] setState:STATE_PLAY];
            
        }else if([button isEqual:retryButton]){
            [[PQGame sharedInstance] setState:STATE_RESTART];
            
        }else if([button isEqual:soundButton]){
            [self toggleSound];
        }
    }
}

-(void)show
{
    [self build];
    [super show];
}

-(void)hide
{
    [self removeFromParent];
    [super hide];
}

- (void)toggleSound
{
    if([[PQGame sharedInstance] isSoundMuted]){
        [[PQGame sharedInstance] unmuteSound];
    }else{
        [[PQGame sharedInstance] muteSound];
    }
    
    SPTexture *texture = [[SPTexture alloc] initWithContentsOfFile:[self soundButtonTextureImage]];
    [soundButton setUpState:texture];
}

-(NSString*)soundButtonTextureImage
{
    return [[PQGame sharedInstance] isSoundMuted] ? @"pause-soundoff-btn.png" : @"pause-soundon-btn.png";
}
@end

