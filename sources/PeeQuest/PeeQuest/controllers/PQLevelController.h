//
//  PQLevelController.h
//  PeeQuest
//
//  Created by Gabriel Pacheco on 1/25/14.
//  Copyright (c) 2014 Doubleleft. All rights reserved.
//

#import "PQScene.h"
#import <SpriteKit/SpriteKit.h>
#import <Foundation/Foundation.h>

@interface PQLevelController : NSObject

+ (PQLevelController *)sharedInstance;

- (PQScene *)levelMakerWithDict:(NSDictionary *)levelDict;
- (PQScene *)updatedScene:(PQScene *)scene withCurrentPosition:(CGPoint)point;

@end
