//
//  BackgroundController.h
//  PeeQuest
//
//  Created by Epaminondas Neto on 1/25/14.
//  Copyright (c) 2014 Doubleleft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

@interface PQBackgroundController : NSObject
-(void)setup;
-(void)show:(SKScene *)scene;
-(void)updatePosition:(int)speed;
@end
