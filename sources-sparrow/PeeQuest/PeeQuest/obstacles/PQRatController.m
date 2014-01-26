//
//  PQRatController.m
//  PeeQuest
//
//  Created by Gabriel Pacheco on 1/26/14.
//  Copyright (c) 2014 Doubleleft. All rights reserved.
//

#import "PQRatController.h"

@interface PQRatController ()

@property (nonatomic, strong) SPImage *rat;
@property (nonatomic, strong) SPQuad *shadow;
@property (nonatomic, assign) PQRatAnimationType currentAnimation;

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
    if (currentAnimation == PQRatAnimationTypeIdle) {
        return [player.getBody intersectsRectangle:rat.bounds];
    } else if (currentAnimation == PQRatAnimationTypeShadow) {
        return [player.getShadow intersectsRectangle:shadow.bounds];
    }
    
    return NO;
}

- (void)switchAnimation {
    switch (currentAnimation) {
        case PQRatAnimationTypeIdle:
            currentAnimation = PQRatAnimationTypeShadow;
            break;
        case PQRatAnimationTypeShadow:
            if ((rand() % 1000) % 2 == 0) {
                currentAnimation = PQRatAnimationTypeGoing;
            } else {
                currentAnimation = PQRatAnimationTypeIdle;
            }
            break;
        default:
            break;
    }
}

- (void)showRain {
    if ([[[self container] bounds] x] > (Sparrow.stage.width - 30)) {
        return;
    }
    [self switchAnimation];
}

- (void)setup {
    
}

@end
