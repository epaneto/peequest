//
//  PQHomeUI.m
//  PeeQuest
//
//  Created by Gabriel Laet on 1/25/14.
//  Copyright (c) 2014 Doubleleft. All rights reserved.
//

#import "PQHomeUI.h"

@implementation PQHomeUI
{
    SPImage *logo;
    SPImage *tapToStart;
}

-(void)build
{
    if(logo == NULL){
        logo = [[SPImage alloc] initWithContentsOfFile:@"logo.png"];
        logo.x = Sparrow.stage.width / 2 - logo.width / 2;
        logo.y = 45;
        [self addChild:logo];
    }
    
    if(tapToStart == NULL){
        tapToStart = [[SPImage alloc] initWithContentsOfFile:@"taptostart-title.png"];
        tapToStart.x = Sparrow.stage.width / 2 - tapToStart.width / 2;
        tapToStart.y = logo.y + 100;
        [self addChild:tapToStart];
    }
}

- (void)show
{
    [self build];
    [super show];
}

- (void)hide
{
    [super hide];
    [self removeFromParent];
}
@end
