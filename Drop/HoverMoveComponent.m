//
//  HoverMoveComponent.m
//  Drop
//
//  Created by Aaron on 12-10-23.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "HoverMoveComponent.h"
#import "GameScene.h"


@implementation HoverMoveComponent
@synthesize delayTime;
+(id)instanceWithHoverPosition:(CGPoint)theHoverPosition
{
    return [[[self alloc]initWithHoverPosition:theHoverPosition] autorelease];
}

-(id)initWithHoverPosition:(CGPoint)theHoverPosition
{
    if(self = [super init])
    {
        hoverPosition = theHoverPosition;
        duration = 10;
        hoverTime = 6;
    }
    return self;
}

-(CCAction*)move
{
    ccTime moveTime = 0.8;
    if (duration > hoverTime) {
        moveTime = (duration - hoverTime) * 0.5;
    }
    CCMoveTo *moveIn = [CCMoveTo actionWithDuration:moveTime position:hoverPosition];
    CCDelayTime *hover = [CCDelayTime actionWithDuration:hoverTime];
    CGRect screenRect = [GameScene screenRect];
    //返回屏幕上方+100Points处
    CCMoveTo *moveOut = [CCMoveTo actionWithDuration:moveTime position:ccp(hoverPosition.x,screenRect.size.height + 100)];
    CCSequence *sequence = [CCSequence actions:moveIn,hover,moveOut, nil];
    
    return sequence;
}

-(id) copyWithZone:(NSZone *)zone
{
    HoverMoveComponent * moveCopy;
    moveCopy = [super copyWithZone:zone];
    moveCopy->hoverPosition = hoverPosition;
    moveCopy->hoverTime = hoverTime;
    return moveCopy;
}
@end
