//
//  PQBaseObstacle.m
//  PeeQuest
//
//  Created by Epaminondas Neto on 1/25/14.
//  Copyright (c) 2014 Doubleleft. All rights reserved.
//

#import "PQBaseObstacle.h"

@implementation PQBaseObstacle

@synthesize assestName = _assestName;
@synthesize container = _container;
@synthesize bounds = _bounds;
@synthesize offset = _offset;
@synthesize scale = _scale;
@synthesize zIndex = _zIndex;
@synthesize type = _type;

- (id)initWithDict:(NSDictionary *)dict {
    self = [super init];
    
    if (nil != self) {
        self.assestName = [dict objectForKey:@"name"];
        self.bounds = CGRectMake([[[dict objectForKey:@"bounds"] objectForKey:@"x"] floatValue]/2,
                                 [[[dict objectForKey:@"bounds"] objectForKey:@"y"] floatValue]/2,
                                 [[[dict objectForKey:@"bounds"] objectForKey:@"w"] floatValue]/2,
                                 [[[dict objectForKey:@"bounds"] objectForKey:@"h"] floatValue]/2);
        self.offset = CGPointMake([[[dict objectForKey:@"bounds"] objectForKey:@"x"] floatValue]/2,
                                  [[[dict objectForKey:@"bounds"] objectForKey:@"y"] floatValue]/2);
        self.scale = CGSizeMake([[[dict objectForKey:@"scale"] objectForKey:@"x"] floatValue],
                                [[[dict objectForKey:@"scale"] objectForKey:@"y"] floatValue]);
        self.zIndex = [[dict objectForKey:@"zIndex"] floatValue];
        self.type = [[dict objectForKey:@"tag"] floatValue];
    }
    
    return  self;
}

- (BOOL)checkColisionWithPlayer:(PQPlayerController *)player {
    return NO;
}

-(void)showRain
{
    
}

-(void)setup
{
    
}

-(void)dispose
{
    
}

@end