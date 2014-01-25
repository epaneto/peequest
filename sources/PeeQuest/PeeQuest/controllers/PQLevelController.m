//
//  PQLevelController.m
//  PeeQuest
//
//  Created by Gabriel Pacheco on 1/25/14.
//  Copyright (c) 2014 Doubleleft. All rights reserved.
//

#import "PQLevelController.h"

@implementation PQLevelController

+ (PQLevelController *)sharedInstance {
    static PQLevelController *_sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [PQLevelController new];
    });
    
    return _sharedInstance;
}

- (SKScene *)levelMakerWithDict:(NSDictionary *)levelDict {
    SKScene *newScene = [SKScene new];
    
    PQ_LEVEL_SET_SJON(levelDict)
    
    
    
    return newScene;
}

- (SKScene *)updatedScene:(SKScene *)scene withCurrentPosition:(CGPoint)point {
    
    return scene;
}

@end
