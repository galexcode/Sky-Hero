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

-(void) dealloc
{
    //需要手动释放bulletFrameName的计数值
    [bulletFrameName release];
    [super dealloc];
}

-(void)shoot
{
    GameScene* game = [GameScene sharedGameScene];
    [game.bulletCache shootBulletAt:startPosition velocity:ccp(0,-200) frameName:bulletFrameName isPlayerBullet:NO];
}
@end
