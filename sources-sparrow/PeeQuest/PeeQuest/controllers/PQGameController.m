//
//  PQGameController.m
//  PeeQuest
//
//  Created by Epaminondas Neto on 1/25/14.
//  Copyright (c) 2014 Doubleleft. All rights reserved.
//

#import "PQRatController.h"
#import "PQDoorController.h"
#import "PQBaseObstacle.h"
#import "PQGameController.h"
#import "PQPlantController.h"
#import "PQBackgroundController.h"
#import "PQPlayerController.h"
#import "PQGame.h"
#import "PQGameplayUI.h"
#import "PQTutorial.h"

@interface PQGameController ()
{
    BOOL win;
    int tempTickCounter;
    int lifes;
    PQTutorial *tutorial;
}

@property SPSprite *mainContainer;
@property SPSprite *obstaclesContainer;
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
    
    //obstacles container
    _obstaclesContainer = [SPSprite sprite];
    [_mainContainer addChild:_obstaclesContainer];
    
    ////initialize player
    _player = [[PQPlayerController alloc] init];
    [_player setup];
    [_player show:_mainContainer];
    
    ////initialize enter frame
    [_mainContainer addEventListener:@selector(updateGame:) atObject:self forType:SP_EVENT_TYPE_ENTER_FRAME];
    
    ////initialize touch
    [_mainContainer addEventListener:@selector(onUserTouch:)  atObject:self forType:SP_EVENT_TYPE_TOUCH];
    
    [self loadJSONObstacles];
    [self updatePlacedObstacles];
    _paused = YES;
    levelOffset = 0;
    
}

-(void)initRainTimer
{
//    NSLog(@"initRainTimer");
    int randomTime = 5.0 + arc4random() % 4;
//    NSLog(@"%i",randomTime);
    if(_mainTimer != NULL){
        [_mainTimer invalidate];
    }
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
        id obstacleObject;
        if ([[currentObject objectForKey:@"tag"] integerValue] == PQObstacleTypeDoor) {
            obstacleObject = [[PQDoorController alloc] initWithDict:currentObject];
        } else if([[currentObject objectForKey:@"tag"] integerValue] == PQObstacleTypePlant){
            obstacleObject = [[PQPlantController alloc] initWithDict:currentObject];
        } else if ([[currentObject objectForKey:@"tag"] integerValue] == PQObstacleTypeRat) {
            obstacleObject = [[PQRatController alloc] initWithDict:currentObject];
        } else {
            obstacleObject = [[PQBaseObstacle alloc] initWithDict:currentObject];
        }
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
        if (![placedObstacles containsObject:currentObstacle] && [currentObstacle type] == PQObstacleTypeDecoration) {
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
            
            [_obstaclesContainer addChild:[currentObstacle container]];
            [placedObstacles addObject:currentObstacle];
            [currentObstacle setup];
        } else if (![placedObstacles containsObject:currentObstacle]) {
            if ([currentObstacle isKindOfClass:[PQRatController class]]) {
                [(PQRatController *) currentObstacle setup];
            }else if([currentObstacle isKindOfClass:[PQPlantController class]]) {
                [(PQPlantController *) currentObstacle setup];
            } else if ([currentObstacle isKindOfClass:[PQDoorController class]]) {
                [(PQDoorController *) currentObstacle setup];
                SPImage *image = [SPImage imageWithContentsOfFile:[currentObstacle assestName]];
                [image setX:0];
                [image setY:0];
                [image setScaleX:currentObstacle.scale.width];
                [image setScaleY:currentObstacle.scale.height];
                [[currentObstacle container] addChild:image];
            }
            [[currentObstacle container] setX:currentObstacle.offset.x - levelOffset];
            [[currentObstacle container] setY:currentObstacle.offset.y];
            [_obstaclesContainer addChild:[currentObstacle container]];
            [placedObstacles addObject:currentObstacle];
        }
    }
    
    for (PQBaseObstacle *movingObstacle in placedObstacles) {
        [[movingObstacle container] setX:(movingObstacle.container.x - [_player getVelocity]/1.77)];
        if ([placedObstacles indexOfObject:movingObstacle] < 2 && [movingObstacle checkColisionWithPlayer:_player]) {
            if([movingObstacle isKindOfClass:[PQDoorController class]]){
                [self complete];
            }else{
                [self damage];
            }
            
        }
    }
    
    //removing obstacles
    if ([placedObstacles count] > 0) {
        NSPredicate *predicate = [NSPredicate predicateWithBlock: ^BOOL(id obj, NSDictionary *bind) {
            return (((CGPoint)[obj offset]).x + [[obj container] width]) < (levelOffset - PQ_LEVEL_INITIAL_POSITION);
        }];
        NSArray *removingArray = [placedObstacles filteredArrayUsingPredicate:predicate];
        for (id currentObstacle in removingArray) {
            [_obstaclesContainer removeChild:[currentObstacle container]];
            [placedObstacles removeObject:currentObstacle];
        }
    }
    
}

-(void)showRain {
    [[PQSoundPlayer sharedInstance] play:@"thunder.caf"];
    
    [_background showRain];
    [_player showRain];
    
    for (id currentObstacle in placedObstacles)
    {
        [currentObstacle showRain];
    }
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
    [_player stopWalk];
    [Sparrow.juggler resume];
    ////initialize timer
    [self initRainTimer];
}

- (void)start
{
    if ([placedObstacles count] > 0) {
        NSArray *tempArray = [placedObstacles copy];
        for (id currentObstacle in tempArray) {
            [_obstaclesContainer removeChild:[currentObstacle container]];
            [placedObstacles removeObject:currentObstacle];
        }
        tempArray = NULL;
    }
    
    levelOffset = 0;
     [self updatePlacedObstacles];
    lifes = PLAYER_LIFES;
    [[PQGameplayUI sharedInstance] updateLifes:lifes];
    
    if(![[NSUserDefaults standardUserDefaults] objectForKey:@"tutorialWatched"]){
        if(tutorial == NULL){
            tutorial = [[PQTutorial alloc] init];
            [tutorial build];
            [_mainContainer.parent addChild:tutorial];
        }
    }
    
}

- (void)onUserTouch:(SPTouchEvent*)event
{
    if(_paused || playerState != PLAYER_STATE_PLAYING) return;

    SPTouch *touch = [[event touchesWithTarget:_mainContainer
                                      andPhase:SPTouchPhaseBegan] anyObject];

    
    if (touch && touch.globalY > 100)
    {
        if(tutorial != NULL){
            if([tutorial step] >= 3){
                if([tutorial step] == 4){
                    [tutorial hide];
                    tutorial = NULL;
                    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"tutorialWatched"];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                }else{
                    [tutorial next];
                }
            }else{
                return;
            }
        }
        [_player toogleMove];
        
    }
}

- (void)damage
{
    if(playerState != PLAYER_STATE_PLAYING || [_player damaged]){
        return;
    }
    
    lifes--;
    if(lifes <= 0){
        lifes = 0;
        [[PQSoundPlayer sharedInstance] play:@"pee.caf"];
        playerState = PLAYER_STATE_LOSE;
        [[PQGame sharedInstance] setState:STATE_FINISH];
        [_player showLose];
        
    }else{
        NSString *damageSound = arc4random() * 2.0 < 1.0 ? @"damage1.caf" : @"damage2.caf";
        [[PQSoundPlayer sharedInstance] play:damageSound];
        [_player showDamage];
    }
    
    if([PQGameplayUI sharedInstance] != NULL){
        [[PQGameplayUI sharedInstance] updateLifes:lifes];
    }
}

-(void)complete
{
    if(playerState != PLAYER_STATE_WIN){
        playerState = PLAYER_STATE_WIN;
        [[PQGame sharedInstance] setState:STATE_FINISH];
        [_player showWin];
    }
}

- (void)updateGame:(SPEnterFrameEvent *)event
{
    if(_paused || playerState != PLAYER_STATE_PLAYING) return;
    [_background updatePosition:[_player getVelocity]];
    if (allObstacles != nil && [allObstacles count] > 0) {
        if ([placedObstacles count] > 0) {
            levelOffset += [_player getVelocity]/1.77;
        }
        [self updatePlacedObstacles];
    }
    
}

- (BOOL)tutorialIsOpened
{
    return tutorial != NULL;
}

@end
