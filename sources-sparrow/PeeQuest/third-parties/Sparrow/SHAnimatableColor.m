//
//  SHAnimatableColor.m
//  Sparrow
//
//  Created by Shilo White on 7/15/11.
//  Copyright 2011 Shilocity Productions. All rights reserved.
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the Simplified BSD License.
//

#import "SHAnimatableColor.h"
#import "SPMacros.h"

@implementation SPTween (AnimatableColor)
- (void)animateColorWithTargetValue:(uint)value {
    [self animateProperty:@"redColor" targetValue:SP_COLOR_PART_RED(value)];
    [self animateProperty:@"greenColor" targetValue:SP_COLOR_PART_GREEN(value)];
    [self animateProperty:@"blueColor" targetValue:SP_COLOR_PART_BLUE(value)];
}

- (void)animateFontColorWithTargetValue:(uint)value {
    [self animateProperty:@"fontRedColor" targetValue:SP_COLOR_PART_RED(value)];
    [self animateProperty:@"fontGreenColor" targetValue:SP_COLOR_PART_GREEN(value)];
    [self animateProperty:@"fontBlueColor" targetValue:SP_COLOR_PART_BLUE(value)];
}

- (void)animateTopLeftColorWithTargetValue:(uint)value {
    [self animateProperty:@"topLeftRedColor" targetValue:SP_COLOR_PART_RED(value)];
    [self animateProperty:@"topLeftGreenColor" targetValue:SP_COLOR_PART_GREEN(value)];
    [self animateProperty:@"topLeftBlueColor" targetValue:SP_COLOR_PART_BLUE(value)];
}

- (void)animateTopRightColorWithTargetValue:(uint)value {
    [self animateProperty:@"topRightRedColor" targetValue:SP_COLOR_PART_RED(value)];
    [self animateProperty:@"topRightGreenColor" targetValue:SP_COLOR_PART_GREEN(value)];
    [self animateProperty:@"topRightBlueColor" targetValue:SP_COLOR_PART_BLUE(value)];
}

- (void)animateBottomLeftColorWithTargetValue:(uint)value {
    [self animateProperty:@"bottomLeftRedColor" targetValue:SP_COLOR_PART_RED(value)];
    [self animateProperty:@"bottomLeftGreenColor" targetValue:SP_COLOR_PART_GREEN(value)];
    [self animateProperty:@"bottomLeftBlueColor" targetValue:SP_COLOR_PART_BLUE(value)];
}

- (void)animateBottomRightColorWithTargetValue:(uint)value {
    [self animateProperty:@"bottomRightRedColor" targetValue:SP_COLOR_PART_RED(value)];
    [self animateProperty:@"bottomRightGreenColor" targetValue:SP_COLOR_PART_GREEN(value)];
    [self animateProperty:@"bottomRightBlueColor" targetValue:SP_COLOR_PART_BLUE(value)];
}

- (void)animateCornersWithCArray:(uint[4])array {
    [self animateTopLeftColorWithTargetValue:array[0]];
    [self animateTopRightColorWithTargetValue:array[1]];
    [self animateBottomLeftColorWithTargetValue:array[2]];
    [self animateBottomRightColorWithTargetValue:array[3]];
}

- (void)animateCornersWithTopLeft:(uint)topLeft topRight:(uint)topRight bottomLeft:(uint)bottomLeft bottomRight:(uint)bottomRight {
    [self animateTopLeftColorWithTargetValue:topLeft];
    [self animateTopRightColorWithTargetValue:topRight];
    [self animateBottomLeftColorWithTargetValue:bottomLeft];
    [self animateBottomRightColorWithTargetValue:bottomRight];
}
@end

@implementation SPStage (ColorComponents)
- (void)setRedColor:(uint)redColor {
    uint greenColor = SP_COLOR_PART_GREEN(self.color);
    uint blueColor = SP_COLOR_PART_BLUE(self.color);
    self.color = SP_COLOR(redColor, greenColor, blueColor);
}

- (uint)redColor {
    return SP_COLOR_PART_RED(self.color);
}

- (void)setGreenColor:(uint)greenColor {
    uint redColor = SP_COLOR_PART_RED(self.color);
    uint blueColor = SP_COLOR_PART_BLUE(self.color);
    self.color = SP_COLOR(redColor, greenColor, blueColor);
}

- (uint)greenColor {
    return SP_COLOR_PART_GREEN(self.color);
}

- (void)setBlueColor:(uint)blueColor {
    uint redColor = SP_COLOR_PART_RED(self.color);
    uint greenColor = SP_COLOR_PART_GREEN(self.color);
    self.color = SP_COLOR(redColor, greenColor, blueColor);
}

- (uint)blueColor {
    return SP_COLOR_PART_BLUE(self.color);
}
@end

@implementation SPQuad (ColorComponents)
- (void)setRedColor:(uint)redColor {
    uint greenColor = SP_COLOR_PART_GREEN(self.color);
    uint blueColor = SP_COLOR_PART_BLUE(self.color);
    self.color = SP_COLOR(redColor, greenColor, blueColor);
}

- (uint)redColor {
    return SP_COLOR_PART_RED(self.color);
}

- (void)setGreenColor:(uint)greenColor {
    uint redColor = SP_COLOR_PART_RED(self.color);
    uint blueColor = SP_COLOR_PART_BLUE(self.color);
    self.color = SP_COLOR(redColor, greenColor, blueColor);
}

- (uint)greenColor {
    return SP_COLOR_PART_GREEN(self.color);
}

- (void)setBlueColor:(uint)blueColor {
    uint redColor = SP_COLOR_PART_RED(self.color);
    uint greenColor = SP_COLOR_PART_GREEN(self.color);
    self.color = SP_COLOR(redColor, greenColor, blueColor);
}

- (uint)blueColor {
    return SP_COLOR_PART_BLUE(self.color);
}

//top left
- (void)setTopLeftRedColor:(uint)redColor {
    uint greenColor = SP_COLOR_PART_GREEN([self colorOfVertex:0]);
    uint blueColor = SP_COLOR_PART_BLUE([self colorOfVertex:0]);
    [self setColor:SP_COLOR(redColor, greenColor, blueColor) ofVertex:0];
}

- (uint)topLeftRedColor {
    return SP_COLOR_PART_RED([self colorOfVertex:0]);
}

- (void)setTopLeftGreenColor:(uint)greenColor {
    uint redColor = SP_COLOR_PART_RED([self colorOfVertex:0]);
    uint blueColor = SP_COLOR_PART_BLUE([self colorOfVertex:0]);
    [self setColor:SP_COLOR(redColor, greenColor, blueColor) ofVertex:0];
}

- (uint)topLeftGreenColor {
    return SP_COLOR_PART_GREEN([self colorOfVertex:0]);
}

- (void)setTopLeftBlueColor:(uint)blueColor {
    uint redColor = SP_COLOR_PART_RED([self colorOfVertex:0]);
    uint greenColor = SP_COLOR_PART_GREEN([self colorOfVertex:0]);
    [self setColor:SP_COLOR(redColor, greenColor, blueColor) ofVertex:0];
}

- (uint)topLeftBlueColor {
    return SP_COLOR_PART_BLUE([self colorOfVertex:0]);
}

//top right
- (void)setTopRightRedColor:(uint)redColor {
    uint greenColor = SP_COLOR_PART_GREEN([self colorOfVertex:1]);
    uint blueColor = SP_COLOR_PART_BLUE([self colorOfVertex:1]);
    [self setColor:SP_COLOR(redColor, greenColor, blueColor) ofVertex:1];
}

- (uint)topRightRedColor {
    return SP_COLOR_PART_RED([self colorOfVertex:1]);
}

- (void)setTopRightGreenColor:(uint)greenColor {
    uint redColor = SP_COLOR_PART_RED([self colorOfVertex:1]);
    uint blueColor = SP_COLOR_PART_BLUE([self colorOfVertex:1]);
    [self setColor:SP_COLOR(redColor, greenColor, blueColor) ofVertex:1];
}

- (uint)topRightGreenColor {
    return SP_COLOR_PART_GREEN([self colorOfVertex:1]);
}

- (void)setTopRightBlueColor:(uint)blueColor {
    uint redColor = SP_COLOR_PART_RED([self colorOfVertex:1]);
    uint greenColor = SP_COLOR_PART_GREEN([self colorOfVertex:1]);
    [self setColor:SP_COLOR(redColor, greenColor, blueColor) ofVertex:1];
}

- (uint)topRightBlueColor {
    return SP_COLOR_PART_BLUE([self colorOfVertex:1]);
}






//bottom left
- (void)setBottomLeftRedColor:(uint)redColor {
    uint greenColor = SP_COLOR_PART_GREEN([self colorOfVertex:2]);
    uint blueColor = SP_COLOR_PART_BLUE([self colorOfVertex:2]);
    [self setColor:SP_COLOR(redColor, greenColor, blueColor) ofVertex:2];
}

- (uint)bottomLeftRedColor {
    return SP_COLOR_PART_RED([self colorOfVertex:2]);
}

- (void)setBottomLeftGreenColor:(uint)greenColor {
    uint redColor = SP_COLOR_PART_RED([self colorOfVertex:2]);
    uint blueColor = SP_COLOR_PART_BLUE([self colorOfVertex:2]);
    [self setColor:SP_COLOR(redColor, greenColor, blueColor) ofVertex:2];
}

- (uint)bottomLeftGreenColor {
    return SP_COLOR_PART_GREEN([self colorOfVertex:2]);
}

- (void)setBottomLeftBlueColor:(uint)blueColor {
    uint redColor = SP_COLOR_PART_RED([self colorOfVertex:2]);
    uint greenColor = SP_COLOR_PART_GREEN([self colorOfVertex:2]);
    [self setColor:SP_COLOR(redColor, greenColor, blueColor) ofVertex:2];
}

- (uint)bottomLeftBlueColor {
    return SP_COLOR_PART_BLUE([self colorOfVertex:2]);
}

//bottom right
- (void)setBottomRightRedColor:(uint)redColor {
    uint greenColor = SP_COLOR_PART_GREEN([self colorOfVertex:3]);
    uint blueColor = SP_COLOR_PART_BLUE([self colorOfVertex:3]);
    [self setColor:SP_COLOR(redColor, greenColor, blueColor) ofVertex:3];
}

- (uint)bottomRightRedColor {
    return SP_COLOR_PART_RED([self colorOfVertex:3]);
}

- (void)setBottomRightGreenColor:(uint)greenColor {
    uint redColor = SP_COLOR_PART_RED([self colorOfVertex:3]);
    uint blueColor = SP_COLOR_PART_BLUE([self colorOfVertex:3]);
    [self setColor:SP_COLOR(redColor, greenColor, blueColor) ofVertex:3];
}

- (uint)bottomRightGreenColor {
    return SP_COLOR_PART_GREEN([self colorOfVertex:3]);
}

- (void)setBottomRightBlueColor:(uint)blueColor {
    uint redColor = SP_COLOR_PART_RED([self colorOfVertex:3]);
    uint greenColor = SP_COLOR_PART_GREEN([self colorOfVertex:3]);
    [self setColor:SP_COLOR(redColor, greenColor, blueColor) ofVertex:3];
}

- (uint)bottomRightBlueColor {
    return SP_COLOR_PART_BLUE([self colorOfVertex:3]);
}
@end

@implementation SPTextField (ColorComponents)
- (void)setRedColor:(uint)redColor {
    uint greenColor = SP_COLOR_PART_GREEN(self.color);
    uint blueColor = SP_COLOR_PART_BLUE(self.color);
    self.color = SP_COLOR(redColor, greenColor, blueColor);
}

- (uint)redColor {
    return SP_COLOR_PART_RED(self.color);
}

- (void)setGreenColor:(uint)greenColor {
    uint redColor = SP_COLOR_PART_RED(self.color);
    uint blueColor = SP_COLOR_PART_BLUE(self.color);
    self.color = SP_COLOR(redColor, greenColor, blueColor);
}

- (uint)greenColor {
    return SP_COLOR_PART_GREEN(self.color);
}

- (void)setBlueColor:(uint)blueColor {
    uint redColor = SP_COLOR_PART_RED(self.color);
    uint greenColor = SP_COLOR_PART_GREEN(self.color);
    self.color = SP_COLOR(redColor, greenColor, blueColor);
}

- (uint)blueColor {
    return SP_COLOR_PART_BLUE(self.color);
}
@end

@implementation SPButton (ColorComponents)
- (void)setFontRedColor:(uint)redColor {
    uint greenColor = SP_COLOR_PART_GREEN(self.fontColor);
    uint blueColor = SP_COLOR_PART_BLUE(self.fontColor);
    self.fontColor = SP_COLOR(redColor, greenColor, blueColor);
}

- (uint)fontRedColor {
    return SP_COLOR_PART_RED(self.fontColor);
}

- (void)setFontGreenColor:(uint)greenColor {
    uint redColor = SP_COLOR_PART_RED(self.fontColor);
    uint blueColor = SP_COLOR_PART_BLUE(self.fontColor);
    self.fontColor = SP_COLOR(redColor, greenColor, blueColor);
}

- (uint)fontGreenColor {
    return SP_COLOR_PART_GREEN(self.fontColor);
}

- (void)setFontBlueColor:(uint)blueColor {
    uint redColor = SP_COLOR_PART_RED(self.fontColor);
    uint greenColor = SP_COLOR_PART_GREEN(self.fontColor);
    self.fontColor = SP_COLOR(redColor, greenColor, blueColor);
}

- (uint)fontBlueColor {
    return SP_COLOR_PART_BLUE(self.fontColor);
}
@end