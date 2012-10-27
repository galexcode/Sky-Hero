//
//  CurveMoveComponent.m
//  Drop
//
//  Created by Aaron on 12-10-23.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "CurveMoveComponent.h"

@implementation CurveMoveComponent
+(id)instanceWithBezierConfig:(ccBezierConfig)theBezierConfig
{
    return [[[self alloc]initWithBezierConfig:theBezierConfig] autorelease];
}

-(id)initWithBezierConfig:(ccBezierConfig)theBezierConfig
{
    if(self = [super init])
    {
        bezierConfig = theBezierConfig;
        duration = 10;
    }
    return self;
}


-(CCAction*)move
{
    CCBezierTo *move = [CCBezierTo actionWithDuration:duration bezier:bezierConfig];
    return move;
}

-(id) copyWithZone:(NSZone *)zone
{
    CurveMoveComponent * moveCopy;
    moveCopy = [super copyWithZone:zone];
    moveCopy->bezierConfig = bezierConfig;
    return moveCopy;
}

@end
