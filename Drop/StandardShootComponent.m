//
//  StandardShootComponent.m
//  Drop
//
//  Created by Aaron on 12-10-14.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "StandardShootComponent.h"
#import "GameScene.h"

@implementation StandardShootComponent
-(id) init
{
    if(self = [super init])
    {
        [self scheduleUpdate];
    }
    return self;
}

-(void) dealloc
{
    //需要手动释放bulletFrameName的计数值
    [bulletFrameName release];
    [super dealloc];
}

-(void) update:(ccTime)delta
{
    if(self.parent.visible)
    {
        updateCount += delta;
        if(updateCount >= shootFrequency)
        {
            updateCount = 0;
            
            GameScene* game = [GameScene sharedGameScene];
            CGPoint startPos = ccpSub(self.parent.position, ccp(0, self.parent.contentSize.width));
            [game.bulletCache shootBulletAt:startPos velocity:ccp(0,-200) frameName:bulletFrameName isPlayerBullet:NO];
        }
    }
}
@end
