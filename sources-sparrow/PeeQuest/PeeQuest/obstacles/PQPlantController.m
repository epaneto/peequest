//
//  PQPlantController.m
//  PeeQuest
//
//  Created by Epaminondas Neto on 1/26/14.
//  Copyright (c) 2014 Doubleleft. All rights reserved.
//

#import "PQPlantController.h"
@interface PQPlantController()
@property BOOL isHide;
@property SPMovieClip * assetView;
@property SPMovieClip * shadowView;
@property SPTextureAtlas * atlas;
@property (nonatomic,strong) NSArray *asset_textures;
@property (nonatomic,strong) NSArray *shadow_textures;
@end

@implementation PQPlantController
- (id)initWithDict:(NSDictionary *)dict {
    self = [super initWithDict:dict];
    return self;
}

-(void)showRain
{
    _isHide = !_isHide;
    
    [self clearAnimations];
    
    if(_isHide)
    {
        [self showAssetAnimation:@"vaso/idle_"];
    }else{
        
    }
}

-(void)setup
{
    NSString * path = [NSString stringWithFormat:@"%@.xml", self.assestName];
    
    // initialize player atlas
    _atlas = [SPTextureAtlas atlasWithContentsOfFile:path];
    
    [self showAssetAnimation:@"vaso/idle_"];

}

-(void)showAssetAnimation :(NSString * )label
{
    _asset_textures = [_atlas texturesStartingWith:label];
    
    _assetView = [[SPMovieClip alloc] initWithFrames:_asset_textures fps:30];
    _assetView.loop = YES;
    [Sparrow.juggler addObject:_assetView];
    [_assetView play];
    
    [self.container addChild:_assetView];
}

-(void)showShadowAnimation :(NSString * )label
{
    _shadow_textures = [_atlas texturesStartingWith:label];
    
    _shadowView = [[SPMovieClip alloc] initWithFrames:_shadow_textures fps:30];
    _shadowView.loop = YES;
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

@end
