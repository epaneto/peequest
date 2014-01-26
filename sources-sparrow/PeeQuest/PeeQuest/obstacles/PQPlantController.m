//
//  PQPlantController.m
//  PeeQuest
//
//  Created by Epaminondas Neto on 1/26/14.
//  Copyright (c) 2014 Doubleleft. All rights reserved.
//


typedef enum{
    PQPlantModeIdle,
    PQPLantModeShadow
} PQPlantMode;

#import "PQPlantController.h"


@interface PQPlantController()
@property SPMovieClip * assetView;
@property SPMovieClip * shadowView;
@property SPTextureAtlas * atlas;
@property (nonatomic,strong) NSArray *asset_textures;
@property (nonatomic,strong) NSArray *shadow_textures;
@property PQPlantMode mode;

@end

@implementation PQPlantController
- (id)initWithDict:(NSDictionary *)dict {
    self = [super initWithDict:dict];
    return self;
}

-(void)showRain
{
    int random = rand() % 100;
    
    if(random % 2 == 0)
    {
        _mode = PQPLantModeShadow;
    }else{
        _mode = PQPlantModeIdle;
    }

    
    [self clearAnimations];
    
    if(_mode == PQPlantModeIdle)
    {
        [self showAssetAnimation:@"vaso/"];
        
    }else if(_mode == PQPLantModeShadow)
    {
        [self showShadowAnimation:@"medusa/idle_"];
        [self showAssetAnimation:@"vaso/"];
    }

    NSLog(@"mode %d",_mode);
}

-(void)setup
{
    self.container = [SPSprite sprite];
    
    NSString * path = [NSString stringWithFormat:@"%@.xml", self.assestName];
    
    // initialize player atlas
    _atlas = [SPTextureAtlas atlasWithContentsOfFile:path];
    
    [self showAssetAnimation:@"vaso/"];
    
    _mode = PQPlantModeIdle;
}

-(void)showAssetAnimation :(NSString * )label
{
    _asset_textures = [_atlas texturesStartingWith:label];
    
    _assetView = [[SPMovieClip alloc] initWithFrames:_asset_textures fps:31];
    _assetView.loop = YES;
    [Sparrow.juggler addObject:_assetView];
    [_assetView play];
    
    [self.container addChild:_assetView];
}

-(void)showShadowAnimation :(NSString * )label
{
    _shadow_textures = [_atlas texturesStartingWith:label];
    
    _shadowView = [[SPMovieClip alloc] initWithFrames:_shadow_textures fps:31];
    _shadowView.loop = YES;
    
    _shadowView.scaleX = _shadowView.scaleY = 1.5;
    _shadowView.x = 10;
    _shadowView.y = -140;
    
    [Sparrow.juggler addObject:_shadowView];
    [_shadowView play];
    
    [self.container addChild:_shadowView];
}

-(void)clearAnimations
{
    if(_assetView)
    {
        [Sparrow.juggler removeObject:_assetView];
        [self.container removeChild:_assetView];
    }
    
    if(_shadowView)
    {
        [Sparrow.juggler removeObject:_shadowView];
        [self.container removeChild:_shadowView];
    }
}

-(BOOL)checkColisionWithPlayer:(PQPlayerController *)player
{
    if(_mode == PQPlantModeIdle)
        return NO;
    
    if(_mode == PQPLantModeShadow)
    {
        NSLog(@"%f %f %f",self.container.x,self.container.width/2, player.getBody.x);
        if(self.container.x + 70 < player.getBody.x)
            return NO;
        
        if((player.getBody.x + player.getShadow.width) - 45 > self.container.bounds.x)
        {
            return YES;
        }
    }
    
    return NO;
}

@end
