//
//  PQLevelController.m
//  PeeQuest
//
//  Created by Gabriel Pacheco on 1/25/14.
//  Copyright (c) 2014 Doubleleft. All rights reserved.
//

#import "PQBaseObstacle.h"
#import "PQLevelController.h"

@interface PQLevelController ()

@property (nonatomic, strong) NSMutableArray *obstacles;
@property (nonatomic, strong) NSMutableArray *childrens;

@end

@implementation PQLevelController

@synthesize obstacles;
@synthesize childrens;

+ (PQLevelController *)sharedInstance {
    static PQLevelController *_sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [PQLevelController new];
    });
    
    return _sharedInstance;
}

- (SPSprite *)makeLevelWithDict:(NSDictionary *)levelDict {
    CGSize size = CGSizeMake([[[levelDict objectForKey:@"canvas"] objectForKey:@"width"] floatValue], [[[levelDict objectForKey:@"canvas"] objectForKey:@"height"] floatValue]);
    SPSprite *newContainer = [SPSprite sprite];
    [newContainer setWidth:size.width];
    [newContainer setHeight:size.height];

    return [self makeLevelWithContainer:newContainer levelDict:levelDict];
}

- (SPSprite *)makeLevelWithContainer:(SPSprite *)container levelDict:(NSDictionary *)levelDict {
    if (obstacles == nil) {
        obstacles = [NSMutableArray new];
    }
    if (childrens == nil) {
        childrens = [NSMutableArray new];
    }
    
    NSArray *objects = [[[levelDict objectForKey:@"layers"] lastObject] objectForKey:@"entities"];
    
    for (NSDictionary *currentObject in objects) {
        PQBaseObstacle *obstacleObject = [[PQBaseObstacle alloc] initWithDict:currentObject];
        [obstacles addObject:obstacleObject];
    }
    
    return [self updatedContainer:container withCurrentPosition:PQ_LEVEL_INITIAL_POSITION];
}

- (SPSprite *)updatedContainer:(SPSprite *)container withCurrentPosition:(float)positionX {
    float chunkSize = PQ_LEVEL_SCENE_CHUNK_SIZE;
    
    if ([childrens count] > 0) {
        NSPredicate *predicate = [NSPredicate predicateWithBlock: ^BOOL(id obj, NSDictionary *bind) {
            return ((CGPoint)[obj offset]).x < (positionX - PQ_LEVEL_INITIAL_POSITION - 50);
        }];
        NSArray *removingArray = [childrens filteredArrayUsingPredicate:predicate];
        for (id currentObstacle in removingArray) {
            [container removeChild:currentObstacle];
        }
    }
    
    NSPredicate *predicate = [NSPredicate predicateWithBlock: ^BOOL(id obj, NSDictionary *bind) {
        return ((CGPoint)[obj offset]).x >= positionX && ((CGPoint)[obj offset]).x < (chunkSize + positionX);
    }];
    
    NSArray *currentObstacles = [obstacles filteredArrayUsingPredicate:predicate];
    
    for (PQBaseObstacle *currentObstacle in currentObstacles) {
        SPQuad *quad = [[SPQuad alloc] initWithWidth:currentObstacle.bounds.size.width height:currentObstacle.bounds.size.height];
        [quad setX:currentObstacle.offset.x];
        [quad setY:currentObstacle.offset.y];
        [quad setScaleX:currentObstacle.scale.width];
        [quad setScaleY:currentObstacle.scale.height];

        [container addChild:quad];
        [childrens addObject:quad];
    }
    
    return container;
}

@end
