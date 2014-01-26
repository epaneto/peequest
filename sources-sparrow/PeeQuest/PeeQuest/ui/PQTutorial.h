//
//  PQTutorial.h
//  PeeQuest
//
//  Created by Gabriel Laet on 1/26/14.
//  Copyright (c) 2014 Doubleleft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PQTutorial : SPSprite
-(void)build;
-(void)update;
-(void)next;
-(void)reset;
-(int)step;
-(void)hide;
@end
