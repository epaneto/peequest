//
//  PQRatController.h
//  PeeQuest
//
//  Created by Gabriel Pacheco on 1/26/14.
//  Copyright (c) 2014 Doubleleft. All rights reserved.
//

#import "PQBaseObstacle.h"

@interface PQRatController : PQBaseObstacle

- (BOOL)checkColisionWithPlayer:(PQPlayerController *)player;
- (void)switchAnimation;

@end
