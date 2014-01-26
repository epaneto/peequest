//
//  PQRatController.m
//  PeeQuest
//
//  Created by Gabriel Pacheco on 1/26/14.
//  Copyright (c) 2014 Doubleleft. All rights reserved.
//

#import "PQRatController.h"

typedef enum {
    PQRatAnimationTypeIdle,
    PQRatAnimationTypeComing,
    PQRatAnimationTypeGoing,
    PQRatAnimationTypeShadow
} PQRatAnimationType;

@interface PQRatController ()

@property (nonatomic, strong) SPMovieClip * rat;
@property (nonatomic, strong) SPMovieClip * shadow;
@property (nonatomic, assign) PQRatAnimationType currentAnimation;
@property SPTextureAtlas * atlas;
@property (nonatomic,strong) NSArray *asset_textures;
@property (nonatomic,strong) NSArray *shadow_textures;

@end

@implementation PQRatController
@synthesize rat;
@synthesize shadow;
@synthesize currentAnimation;

- (id)initWithDict:(NSDictionary *)dict {
    self = [super initWithDict:dict];
    currentAnimation = PQRatAnimationTypeIdle;
    return self;
}

- (BOOL)checkColisionWithPlayer:(PQPlayerController *)player {
    if ([[[self container] bounds] x] > Sparrow.stage.width) {
        return NO;
    }
    if (currentAnimation == PQRatAnimationTypeIdle) {
        return NO;
    } else if (currentAnimation == PQRatAnimationTypeShadow) {
        return NO;
    }
    
    return NO;
}

- (void)switchAnimation {
    [self clearAnimations];
    
    switch (currentAnimation) {
        case PQRatAnimationTypeIdle:
            [rat setY:self.bounds.origin.y];
            currentAnimation = PQRatAnimationTypeShadow;
            [self showShadowAnimation:@"sombra/" :YES];
            [self showAssetAnimation:@"rato_2/levantando_" :NO];

            break;
        case PQRatAnimationTypeShadow:
            if ((rand() % 1000) % 2 == 0) {
                currentAnimation = PQRatAnimationTypeGoing;
                [self showAssetAnimation:@"rato_2/correndo_": YES];
                [self leaveStage];
            } else {
                currentAnimation = PQRatAnimationTypeIdle;
                [self showAssetAnimation:@"rato_2/idle_": YES];
            }
            break;
        case PQRatAnimationTypeGoing: {
            currentAnimation = PQRatAnimationTypeIdle;
            [rat setY:self.bounds.origin.y];
            [self showAssetAnimation:@"rato_2/idle_": YES];
            break;
        }
        default:
            break;
    }
}

-(void)showAssetAnimation :(NSString * )label :(BOOL)loop
{
    _asset_textures = [_atlas texturesStartingWith:label];
    
    rat = [[SPMovieClip alloc] initWithFrames:_asset_textures fps:31];
    if(loop)
        rat.loop = YES;
    else
        rat.loop = NO;
    
    [Sparrow.juggler addObject:rat];
    [rat play];
    
    [self.container addChild:rat];
}

-(void)showShadowAnimation :(NSString * )label :(BOOL)loop
{
    _shadow_textures = [_atlas texturesStartingWith:label];
    
    shadow = [[SPMovieClip alloc] initWithFrames:_shadow_textures fps:31];
    
    if(loop)
        shadow.loop = YES;
    
    [Sparrow.juggler addObject:shadow];
    [shadow play];
    
    [shadow setScaleX:1.3];
    [shadow setScaleY:1.3];
    [shadow setY:shadow.y - (97 * 1.3)];
    [shadow setX:shadow.x - (36 * 1.3)];
    
    [self.container addChild:shadow];
}

-(void)clearAnimations
{
    if(rat)
    {
        [Sparrow.juggler removeObject:rat];
        [self.container removeChild:rat];
    }
    
    if(shadow)
    {
        [Sparrow.juggler removeObject:shadow];
        [self.container removeChild:shadow];
    }
}

- (void)showRain {
    if ([[[self container] bounds] x] > (Sparrow.stage.width - 30)) {
        return;
    }
    
    [self switchAnimation];
}

-(void)leaveStage
{
    SPTween * tween = [SPTween tweenWithTarget:rat time:1.6];
    [tween moveToX:rat.x y:rat.y + 150];
    [Sparrow.juggler addObject:tween];
}

- (void)setup {
    self.container = [SPSprite sprite];
    
    NSString * path = [NSString stringWithFormat:@"%@.xml", self.assestName];
    
    // initialize player atlas
    _atlas = [SPTextureAtlas atlasWithContentsOfFile:path];
    
    [self showAssetAnimation:@"rato_2/idle_" :YES];
    
    currentAnimation = PQRatAnimationTypeIdle;

}

@end
