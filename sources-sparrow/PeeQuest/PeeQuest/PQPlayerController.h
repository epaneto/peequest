//
//  PQPlayerController.h
//  PeeQuest
//
//  Created by Epaminondas Neto on 1/25/14.
//  Copyright (c) 2014 Doubleleft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PQPlayerController : NSObject
-(int)getVelocity;
-(void)setup;
-(void)show :(SPSprite * )container;
-(void)toogleMove;
-(void)stopWalk;
-(void)startWalk;
@end
