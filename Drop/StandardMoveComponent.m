//
//  StandardMoveComponent.m
//  Drop
//
//  Created by Aaron on 12-10-14.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "StandardMoveComponent.h"
#import "Entity.h"
#import "GameScene.h"

@implementation StandardMoveComponent
-(void) initiation
{
	//继承自父类的初始化方法，无需self init
    velocity = ccp(10,-100);
    [self scheduleUpdate];
}

-(void) update:(ccTime)delta
{
	if (self.parent.visible)
	{
		NSAssert([self.parent isKindOfClass:[Entity class]], @"node is not a Entity");
		
		Entity* entity = (Entity*)self.parent;
		if (entity.position.y > [GameScene screenRect].size.height * 0.5f)
		{
			[entity setPosition:ccpAdd(entity.position, ccpMult(velocity,delta))];
		}
	}
}
@end
