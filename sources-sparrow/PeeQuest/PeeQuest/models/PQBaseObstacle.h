//
//  PQBaseObstacle.h
//  PeeQuest
//
//  Created by Epaminondas Neto on 1/25/14.
//  Copyright (c) 2014 Doubleleft. All rights reserved.
//
#import "PQPlayerController.h"
#import <Foundation/Foundation.h>

typedef enum {
    PQObstacleTypeDecoration,
    PQObstacleTypeDoor,
    PQObstacleTypeRat,
    PQObstacleTypeShadow,
    PQObstacleTypePlant
} PQObstacleType;

@interface PQBaseObstacle : NSObject

@property (nonatomic, strong) NSString *assestName;
@property (nonatomic, strong) SPSprite *container;
@property (nonatomic, assign) CGRect bounds;
@property (nonatomic, assign) CGPoint offset;
@property (nonatomic, assign) CGSize scale;
@property (nonatomic, assign) float zIndex;
@property (nonatomic, assign) PQObstacleType type;


- (id)initWithDict:(NSDictionary *)dict;
- (BOOL)checkColisionWithPlayer:(PQPlayerController *)player;

@end
