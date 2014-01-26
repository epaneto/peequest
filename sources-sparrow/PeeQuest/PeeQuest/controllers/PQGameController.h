//
//  PQGameController.h
//  PeeQuest
//
//  Created by Epaminondas Neto on 1/25/14.
//  Copyright (c) 2014 Doubleleft. All rights reserved.
//

#import <Foundation/Foundation.h>

#define PLAYER_STATE_WIN 1
#define PLAYER_STATE_LOSE 2
#define PLAYER_STATE_PLAYING 3
#define PLAYER_LIFES 3

@interface PQGameController : NSObject
{
    int playerState;
}
@property(nonatomic,assign) int playerState;
-(void)setup :(SPSprite * )container;
-(void)start;
-(void)resume;
-(void)pause;
-(void)damage;
@end
