//
//  PQBaseObstacle.m
//  PeeQuest
//
//  Created by Epaminondas Neto on 1/25/14.
//  Copyright (c) 2014 Doubleleft. All rights reserved.
//

#import "PQBaseObstacle.h"
#import "SHAnimatableColor.h"

@interface PQBaseObstacle ()
@property uint idleColor;
@property uint darkColor;
@end

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
    if ([_container numChildren] > 0) {
        SPImage * image = (SPImage *)[_container childAtIndex:0];
        
        if(image){
            SPTween * tween = [SPTween tweenWithTarget:image time:0.4 transition:SP_TRANSITION_EASE_OUT_BOUNCE];
            [tween animateColorWithTargetValue:_idleColor];
            tween.repeatCount = 2;
            tween.reverse = YES;
            [Sparrow.juggler addObject:tween];
        }
    }
}

-(void)setup
{
    if ([_container numChildren] > 0) {
        SPImage * image = (SPImage *)[_container childAtIndex:0];
        
        if(image)
        {
            _idleColor = image.color;
            _darkColor = 0xb49c9c;
            image.color = _darkColor;
        }
    }
    
}

-(void)dispose
{
    
}

@end