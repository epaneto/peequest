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
@end

@implementation PQPlantController
- (id)initWithDict:(NSDictionary *)dict {
    self = [super initWithDict:dict];
    return self;
}

-(void)showRain
{
    _isHide = !_isHide;
    
    if(_isHide)
    {
        
    }else{
        
    }
}

-(void)showAssetAnimation :(NSString * )
{
    [self.container removeAllChildren];
    
}

@end
