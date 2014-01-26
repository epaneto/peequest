//
//  PQSoundPlayer.m
//  PeeQuest
//
//  Created by Gabriel Laet on 1/26/14.
//  Copyright (c) 2014 Doubleleft. All rights reserved.
//

#import "PQSoundPlayer.h"

@implementation PQSoundPlayer
{
    NSMutableDictionary* soundDict;
    
}
+ (PQSoundPlayer *)sharedInstance {
    static PQSoundPlayer *sharedInstance;
    @synchronized(self) {
        if (sharedInstance == nil) {
            sharedInstance = [[PQSoundPlayer alloc] init];
        }
    }
    return sharedInstance;
}

-(void)play:(NSString*)audioName
{
    if(soundDict == NULL){
        soundDict = [[NSMutableDictionary alloc] init];
    }
    
    SPSound* sound = NULL;
    if([soundDict objectForKey:audioName] == NULL){
        sound = [[SPSound alloc] initWithContentsOfFile:audioName];
        [soundDict setObject:sound forKey:audioName];
        
    }else{
        sound = [soundDict objectForKey:audioName];
    }
    
    [sound play];
}

@end
