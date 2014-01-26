//
//  PQCredits.m
//  PeeQuest
//
//  Created by Gabriel Laet on 1/26/14.
//  Copyright (c) 2014 Doubleleft. All rights reserved.
//

#import "PQCredits.h"

@implementation PQCredits
{
    NSMutableArray *steps;
}

-(void)build
{
    if(steps == NULL){
        steps = [[NSMutableArray alloc] init];
        [steps addObject:[[SPImage alloc] initWithContentsOfFile:@"credits1.png"]];
        [steps addObject:[[SPImage alloc] initWithContentsOfFile:@"credits2.png"]];
        [steps addObject:[[SPImage alloc] initWithContentsOfFile:@"credits3.png"]];
        [steps addObject:[[SPImage alloc] initWithContentsOfFile:@"credits4.png"]];
        [steps addObject:[[SPImage alloc] initWithContentsOfFile:@"credits5.png"]];
        [steps addObject:[[SPImage alloc] initWithContentsOfFile:@"credits6.png"]];
        [steps addObject:[[SPImage alloc] initWithContentsOfFile:@"credits7.png"]];
    }
}
@end
