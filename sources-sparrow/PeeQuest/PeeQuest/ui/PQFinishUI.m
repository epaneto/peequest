//
//  PQFinishUI.m
//  PeeQuest
//
//  Created by Gabriel Laet on 1/25/14.
//  Copyright (c) 2014 Doubleleft. All rights reserved.
//

#import "PQFinishUI.h"
#import "PQGame.h"

@implementation PQFinishUI
{
    SPImage *title;
    SPButton *facebookButton;
    SPButton *twitterButton;
    SPSprite *buttons;
    SPQuad *hitArea;
    
    BOOL winner;
}

-(void)build
{
    winner = [[PQGame sharedInstance] isWinner];
    
    
    if(hitArea == NULL){
        hitArea = [[SPQuad alloc] initWithWidth:Sparrow.stage.width height:Sparrow.stage.height];
        hitArea.alpha = 0.0;
        [self addChild:hitArea];
    }
    
    if(title == NULL){
        title = [[SPImage alloc] initWithContentsOfFile:winner ? @"win-title.png" : @"lose-title.png"];
        title.x = Sparrow.stage.width / 2 - title.width / 2;
        if(!winner){
            title.x += 10;
            title.y = 20;
        }else{
            title.y = 40;
        }
        [self addChild:title];
    }
    
    if(buttons == NULL){
        buttons = [SPSprite sprite];
        [self addChild:buttons];
    }
    
    if(facebookButton == NULL){
        SPTexture *facebookTexture = [[SPTexture alloc] initWithContentsOfFile:@"facebook-btn.png"];
        facebookButton = [[SPButton alloc] initWithUpState:facebookTexture];
        [facebookButton addEventListener:@selector(share:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
        [buttons addChild:facebookButton];
    }
    
    if(twitterButton == NULL){
        SPTexture *twitterTexture = [[SPTexture alloc] initWithContentsOfFile:@"twitter-btn.png"];
        twitterButton = [[SPButton alloc] initWithUpState:twitterTexture];
        twitterButton.x = facebookButton.width + 20;
        
        [twitterButton addEventListener:@selector(share:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
        [buttons addChild:twitterButton];
    }
    
    
    buttons.x = Sparrow.stage.width / 2 - buttons.width / 2;
    buttons.y = Sparrow.stage.height - buttons.height - (winner ? 30 : 50);
    
}

-(void)share:(SPTouchEvent*)event
{
    SPButton *button = (SPButton*)event.currentTarget;
    SPTouch *touch = [[event touchesWithTarget:self andPhase:SPTouchPhaseBegan] anyObject];
    
    NSSet *touches = [event touchesWithTarget:self];
    if (touches.count) [event stopPropagation];
    
    if([touch phase] == SPTouchPhaseBegan && button.isDown){
        
        [[PQSoundPlayer sharedInstance] play:@"btn-press.caf"];
        BOOL facebook = [button isEqual:facebookButton];
        
        NSString *texttoshare = winner ? @"Pee faced his fears and made it! Face the dark with him too!  #ggj14 #peequest #doubleleft" : @"Pee didn’t make it this time… Are you afraid of the dark too? #ggj14 #peequest #doubleleft";
        
        UIImage *imagetoshare = [UIImage imageNamed:winner ? @"share-win.png" : @"share-lose.png"];
        NSArray *activityItems = @[texttoshare, imagetoshare];
        
        UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
        
        if(facebook){
            activityVC.excludedActivityTypes = @[UIActivityTypePostToTwitter, UIActivityTypeAssignToContact, UIActivityTypePrint, UIActivityTypePostToWeibo];
        }else{
            activityVC.excludedActivityTypes = @[UIActivityTypePostToFacebook, UIActivityTypeAssignToContact, UIActivityTypePrint, UIActivityTypePostToWeibo];
        }
        

        [[[[UIApplication sharedApplication] keyWindow] rootViewController] presentViewController:activityVC animated:YES completion:nil];
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
