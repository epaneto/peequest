//
//  SHAnimatableColor.h
//  Sparrow
//
//  Created by Shilo White on 7/15/11.
//  Copyright 2011 Shilocity Productions. All rights reserved.
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the Simplified BSD License.
//

#import <Foundation/Foundation.h>
#import "SPTween.h"
#import "SPStage.h"
#import "SPQuad.h"
#import "SPTextField.h"
#import "SPButton.h"

@interface SPTween (AnimatableColor)
- (void)animateColorWithTargetValue:(uint)value;
- (void)animateFontColorWithTargetValue:(uint)value;
- (void)animateTopLeftColorWithTargetValue:(uint)value;
- (void)animateTopRightColorWithTargetValue:(uint)value;
- (void)animateBottomLeftColorWithTargetValue:(uint)value;
- (void)animateBottomRightColorWithTargetValue:(uint)value;
- (void)animateCornersWithCArray:(uint[4])array;
- (void)animateCornersWithTopLeft:(uint)topLeft topRight:(uint)topRight bottomLeft:(uint)bottomLeft bottomRight:(uint)bottomRight;
@end

@interface SPStage (ColorComponents)
@property (nonatomic, assign) uint redColor;
@property (nonatomic, assign) uint greenColor;
@property (nonatomic, assign) uint blueColor;
@end

@interface SPQuad (ColorComponents)
@property (nonatomic, assign) uint redColor;
@property (nonatomic, assign) uint greenColor;
@property (nonatomic, assign) uint blueColor;
@property (nonatomic, assign) uint topLeftRedColor;
@property (nonatomic, assign) uint topLeftGreenColor;
@property (nonatomic, assign) uint topLeftBlueColor;
@property (nonatomic, assign) uint topRightRedColor;
@property (nonatomic, assign) uint topRightGreenColor;
@property (nonatomic, assign) uint topRightBlueColor;
@property (nonatomic, assign) uint bottomLeftRedColor;
@property (nonatomic, assign) uint bottomLeftGreenColor;
@property (nonatomic, assign) uint bottomLeftBlueColor;
@property (nonatomic, assign) uint bottomRightRedColor;
@property (nonatomic, assign) uint bottomRightGreenColor;
@property (nonatomic, assign) uint bottomRightBlueColor;
@end

@interface SPTextField (ColorComponents)
@property (nonatomic, assign) uint redColor;
@property (nonatomic, assign) uint greenColor;
@property (nonatomic, assign) uint blueColor;
@end

@interface SPButton (ColorComponents)
@property (nonatomic, assign) uint fontRedColor;
@property (nonatomic, assign) uint fontGreenColor;
@property (nonatomic, assign) uint fontBlueColor;
@end