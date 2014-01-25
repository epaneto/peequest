//
//  PQBackgroundController.h
//  PeeQuest
//
//  Created by Epaminondas Neto on 1/25/14.
//  Copyright (c) 2014 Doubleleft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PQBackgroundController : NSObject
-(void)setup;
-(void)show :(SPSprite *)scene;
-(void)updatePosition:(float)speed;
-(void)showRain;
@end
