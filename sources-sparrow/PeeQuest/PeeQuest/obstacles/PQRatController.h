//
//  PQRatController.h
//  PeeQuest
//
//  Created by Gabriel Pacheco on 1/26/14.
//  Copyright (c) 2014 Doubleleft. All rights reserved.
//

#import "PQBaseObstacle.h"

typedef enum {
    PQRatAnimationTypeIdle,
    PQRatAnimationTypeGoing,
    PQRatAnimationTypeShadow
} PQRatAnimationType;

@interface PQRatController : PQBaseObstacle

- (BOOL)checkColisionWithPlayer:(PQPlayerController *)player;
- (void)switchAnimation;

@end
