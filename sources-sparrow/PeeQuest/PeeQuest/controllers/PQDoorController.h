//
//  PQDoorController.h
//  PeeQuest
//
//  Created by Gabriel Pacheco on 1/26/14.
//  Copyright (c) 2014 Doubleleft. All rights reserved.
//

#import "PQPlayerController.h"
#import "PQBaseObstacle.h"

@interface PQDoorController : PQBaseObstacle

- (BOOL)checkColisionWithPlayer:(PQPlayerController *)player;

@end
