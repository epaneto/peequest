//
//  PQSoundPlayer.h
//  PeeQuest
//
//  Created by Gabriel Laet on 1/26/14.
//  Copyright (c) 2014 Doubleleft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PQSoundPlayer : NSObject
+ (PQSoundPlayer *)sharedInstance;
-(void)play:(NSString*)audioName;
@end
