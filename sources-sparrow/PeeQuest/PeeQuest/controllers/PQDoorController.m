//
//  PQDoorController.m
//  PeeQuest
//
//  Created by Gabriel Pacheco on 1/26/14.
//  Copyright (c) 2014 Doubleleft. All rights reserved.
//

#import "PQDoorController.h"

@implementation PQDoorController

- (id)initWithDict:(NSDictionary *)dict {
    self = [super initWithDict:dict];
    return self;
}

- (BOOL)checkColisionWithPlayer:(PQPlayerController *)player {
//    if (self.container.bounds.x < (player.getBody.x + player.getBody.width - 10) && self.container.bounds.x + 6 > (player.getBody.x + player.getBody.width - 10)) {
//        return YES;
//    }
    if (player.getBody.x >= self.container.bounds.x + self.container.bounds.width/2) {
        return YES;
    }
    return NO;
}

@end
