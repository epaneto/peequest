//
//  PQLevelController.h
//  PeeQuest
//
//  Created by Gabriel Pacheco on 1/25/14.
//  Copyright (c) 2014 Doubleleft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PQLevelController : NSObject

+ (PQLevelController *)sharedInstance;

- (SPSprite *)makeLevelWithDict:(NSDictionary *)levelDict;
- (SPSprite *)makeLevelWithContainer:(SPSprite *)container levelDict:(NSDictionary *)levelDict;
- (SPSprite *)updatedContainer:(SPSprite *)container withCurrentPosition:(float)positionX;

@end
