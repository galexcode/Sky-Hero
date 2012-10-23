//
//  CurveMoveComponent.m
//  Drop
//
//  Created by Aaron on 12-10-23.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "CurveMoveComponent.h"
#import "Entity.h"
#import "GameScene.h"


@implementation CurveMoveComponent
+(id)curveMoveComponent:(ccBezierConfig)theBezierConfig
{
    return [[[self alloc]initWithBezierConfig:theBezierConfig] autorelease];
}

-(id)initWithBezierConfig:(ccBezierConfig)theBezierConfig
{
    if(self = [super init])
    {
        bezierConfig = theBezierConfig;
    }
    return self;
}

-(void)move
{
    CCBezierTo *move = [CCBezierTo actionWithDuration:3 bezier:bezierConfig];
    [self.parent runAction:move];
}

@end
