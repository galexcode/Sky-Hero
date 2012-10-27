//
//  BasicMoveComponent.m
//  Drop
//
//  Created by Aaron on 12-10-22.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "BasicMoveComponent.h"


@implementation BasicMoveComponent
@synthesize velocity,acceleration;
@synthesize duration;
@synthesize action;

-(CCAction*)move
{
    return nil;
}

-(id) copyWithZone:(NSZone *)zone
{
    BasicMoveComponent *moveCopy;
    moveCopy = [[[self class] allocWithZone:zone] init];
    moveCopy = [self copyWithCommonVars:moveCopy];
    return moveCopy;
}

-(id) copyWithCommonVars:(BasicMoveComponent*)moveCopy
{
    moveCopy->acceleration = acceleration;
    moveCopy->velocity = velocity;
    moveCopy->duration = duration;
    return moveCopy;
}
@end
