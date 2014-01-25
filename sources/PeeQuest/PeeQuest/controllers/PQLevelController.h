//
//  PQLevelController.h
//  PeeQuest
//
//  Created by Gabriel Pacheco on 1/25/14.
//  Copyright (c) 2014 Doubleleft. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <Foundation/Foundation.h>

@interface PQLevelController : NSObject

+ (PQLevelController *)sharedInstance;

- (SKScene *)levelMakerWithDict:(NSDictionary *)levelDict;
- (SKScene *)updatedScene:(SKScene *)scene withCurrentPosition:(CGPoint)point;

@end
