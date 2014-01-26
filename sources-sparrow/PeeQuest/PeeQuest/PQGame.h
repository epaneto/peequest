//
//  PQGame.h
//  PeeQuest
//
//  Created by Gabriel Laet on 1/25/14.
//  Copyright (c) 2014 Doubleleft. All rights reserved.
//

#import <Foundation/Foundation.h>

#define STATE_HOME 1
#define STATE_PLAY 2
#define STATE_PAUSE 3
#define STATE_FINISH 4
#define STATE_RESTART 5



@interface PQGame : SPSprite
{
    SPSprite *container;
}

+ (PQGame *)sharedInstance;
- (void)setState:(int)state;
- (void)muteSound;
- (void)unmuteSound;
- (BOOL)isSoundMuted;
- (BOOL)isWinner;
@end
