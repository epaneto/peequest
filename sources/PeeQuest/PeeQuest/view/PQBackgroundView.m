//
//  BackgroundView.m
//  PeeQuest
//
//  Created by Epaminondas Neto on 1/25/14.
//  Copyright (c) 2014 Doubleleft. All rights reserved.
//

#import "PQBackgroundView.h"

@implementation PQBackgroundView
-(void)setup
{
    self.texture = [SKTexture textureWithImageNamed:@"bg.png"];
    [self setTexture:self.texture];
}
@end
