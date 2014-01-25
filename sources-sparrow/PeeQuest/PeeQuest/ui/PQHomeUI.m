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
        [self addChild:logo];
    }
    
    if(tapToStart == NULL){
        tapToStart = [[SPImage alloc] initWithContentsOfFile:@"taptostart-title.png"];
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
