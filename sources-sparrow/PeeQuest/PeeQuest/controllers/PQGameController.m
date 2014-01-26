//
//  PQGameController.m
//  PeeQuest
//
//  Created by Epaminondas Neto on 1/25/14.
//  Copyright (c) 2014 Doubleleft. All rights reserved.
//

#import "PQBaseObstacle.h"
#import "PQGameController.h"
#import "PQBackgroundController.h"
#import "PQPlayerController.h"
#import "PQGame.h"


@interface PQGameController ()
{
    BOOL win;
    int tempTickCounter;
    int lifes;
}

@property SPSprite *mainContainer;
@property PQBackgroundController *background;
@property PQPlayerController *player;
@property BOOL paused;
@property NSTimer *mainTimer;
@property (nonatomic, strong) NSMutableArray *allObstacles;
@property (nonatomic, strong) NSMutableArray *placedObstacles;
@property (nonatomic, assign) float levelOffset;

@end

@implementation PQGameController
@synthesize playerState;
@synthesize allObstacles;
@synthesize placedObstacles;
@synthesize levelOffset;

-(void)setup:(SPSprite *)container
{
    _mainContainer = container;
    
    ////initialize background
    _background = [[PQBackgroundController alloc] init];
    [_background setup];
    [_background show:_mainContainer];
    
    ////initialize player
    _player = [[PQPlayerController alloc] init];
    [_player setup];
    [_player show:_mainContainer];
    
    ////initialize enter frame
    [_mainContainer addEventListener:@selector(updateGame:) atObject:self forType:SP_EVENT_TYPE_ENTER_FRAME];
    
    ////initialize touch
    [_mainContainer addEventListener:@selector(onUserTouch:)  atObject:self forType:SP_EVENT_TYPE_TOUCH];
    
    [self loadJSONObstacles];
    _paused = YES;
}

-(void)initRainTimer
{
    int randomTime = 2.0 + arc4random() % 5;
    NSLog(@"%i",randomTime);
    _mainTimer = [NSTimer scheduledTimerWithTimeInterval:randomTime target:self selector:@selector(initRain:) userInfo:nil repeats:NO];
}

-(void)initRain:(NSTimer *)timer {
    if(_paused){
        return;
    }
    [self showRain];
    [self initRainTimer];
}

- (void)loadJSONObstacles {
    NSData *jsonData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"peeQuest" ofType:@"json"]];
    
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
    
    if (allObstacles == nil) {
        allObstacles = [NSMutableArray new];
    }
    if (placedObstacles == nil) {
        placedObstacles = [NSMutableArray new];
    }
    
    NSArray *objects = [[[dict objectForKey:@"layers"] lastObject] objectForKey:@"entities"];
    
    for (NSDictionary *currentObject in objects) {
        PQBaseObstacle *obstacleObject = [[PQBaseObstacle alloc] initWithDict:currentObject];
        [allObstacles addObject:obstacleObject];
    }
}

- (void)updatePlacedObstacles {
    float chunkSize = PQ_LEVEL_SCENE_CHUNK_SIZE;
    
    //adding obstacles
    NSPredicate *predicate = [NSPredicate predicateWithBlock: ^BOOL(id obj, NSDictionary *bind) {
        return ((CGPoint)[obj offset]).x >= levelOffset && ((CGPoint)[obj offset]).x < (chunkSize + levelOffset);
    }];
    
    NSArray *obstacles = [allObstacles filteredArrayUsingPredicate:predicate];
    
    for (PQBaseObstacle *currentObstacle in obstacles) {
        if (![placedObstacles containsObject:currentObstacle]) {
            SPImage *image = [SPImage imageWithContentsOfFile:[currentObstacle assestName]];
            [image setX:0];
            [image setY:0];
            [image setScaleX:currentObstacle.scale.width];
            [image setScaleY:currentObstacle.scale.height];
            
            SPSprite *obstacleContainer = [SPSprite sprite];
            [obstacleContainer addChild:image];
            [obstacleContainer setX:currentObstacle.offset.x - levelOffset];
            [obstacleContainer setY:currentObstacle.offset.y];
            
            [currentObstacle setContainer:obstacleContainer];
            
            [_mainContainer addChild:[currentObstacle container]];
            [placedObstacles addObject:currentObstacle];
        }
    }
    
    for (PQBaseObstacle *movingObstacle in placedObstacles) {
        [[movingObstacle container] setX:(movingObstacle.offset.x - levelOffset)];
    }
    
    //removing obstacles
    if ([placedObstacles count] > 0) {
        NSPredicate *predicate = [NSPredicate predicateWithBlock: ^BOOL(id obj, NSDictionary *bind) {
            return (((CGPoint)[obj offset]).x + [[obj container] width]) < (levelOffset - PQ_LEVEL_INITIAL_POSITION);
        }];
        NSArray *removingArray = [placedObstacles filteredArrayUsingPredicate:predicate];
        for (id currentObstacle in removingArray) {
            [_mainContainer removeChild:[currentObstacle container]];
            [placedObstacles removeObject:currentObstacle];
        }
    }
}

-(void)showRain {
    [_background showRain];
    [_player showRain];
}

- (void)pause
{
    if(playerState == PLAYER_STATE_PLAYING) {
        _paused = YES;
        [_player stopWalk];
        if(_mainTimer != NULL){
            [_mainTimer invalidate];
        }
        [Sparrow.juggler pause];
    }
}

- (void)resume
{
    tempTickCounter = 0;
    playerState = PLAYER_STATE_PLAYING;
    _paused = NO;
    [Sparrow.juggler resume];
    ////initialize timer
    [self initRainTimer];
}

- (void)start
{
    lifes = PLAYER_LIFES;
    [self resume];
}

- (void)onUserTouch:(SPTouchEvent*)event
{
    if(_paused) return;
    if(playerState != PLAYER_STATE_PLAYING) {
        [[PQGame sharedInstance] setState:STATE_RESTART];
        return;
    }
    SPTouch *touch = [[event touchesWithTarget:_mainContainer
                                      andPhase:SPTouchPhaseBegan] anyObject];
    
    if (touch && touch.globalY > 100)
    {
        [_player toogleMove];
    }
}

- (void)damage
{
    lifes--;
    if(lifes <= 0){
        lifes = 0;
        playerState = PLAYER_STATE_LOSE;
        [[PQGame sharedInstance] setState:STATE_FINISH];

    }
}

- (void)updateGame:(SPEnterFrameEvent *)event
{
    if(_paused) return;
    [_background updatePosition:[_player getVelocity]];
    
    /*TEMP BLOCK TO SIMULATE GAME OVER SCREEN */
    levelOffset += [_player getVelocity];
    if (allObstacles != nil && [allObstacles count] > 0) {
        [self updatePlacedObstacles];
    }
    if(playerState == PLAYER_STATE_PLAYING) {
        if(tempTickCounter > 100){
            playerState = PLAYER_STATE_WIN;
            [[PQGame sharedInstance] setState:STATE_FINISH];
        }
    }
    tempTickCounter++;
    /*END TEMP BLOCK*/
}
@end
