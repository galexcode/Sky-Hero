//
//  BulletCache.m
//  Drop
//
//  Created by Aaron on 12-10-12.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "BulletCache.h"
#import "Bullet.h"
@interface BulletCache (PrivateMethods)
-(bool) isBulletCollidingWithRect:(CGRect)rect usePlayerBullets:(bool)usePlayerBullets;
@end

@implementation BulletCache
-(id) init
{
    if(self = [super init])
    {
        CCSpriteFrame* bulletFrame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"bullet.png"];
        
        batch = [CCSpriteBatchNode batchNodeWithTexture:bulletFrame.texture];
        
        [self addChild:batch];
        
        for (int i=0;i<200;i++)
        {
            Bullet* bullet = [Bullet bullet];
            bullet.visible = NO;
            [batch addChild:bullet];
        }
        
    }
    return self;
}
-(void)shootBulletAt:(CGPoint)startPosition velocity:(CGPoint)velocity frameName:(NSString*)frameName isPlayerBullet:(bool) playerBullet
{
    CCArray* bullets = [batch children];
    CCNode* node = [bullets objectAtIndex:nextInactiveBullet];
    NSAssert([node isKindOfClass:[Bullet class]], @"not a bullet");
    Bullet* bullet = (Bullet*)node;
    [bullet shootBulletAt:startPosition velocity:velocity frameName:frameName isPlayerBullet:playerBullet];
    nextInactiveBullet++;
    if(nextInactiveBullet >= [bullets count])
    {
        nextInactiveBullet = 0;
    }
}

-(bool) isPlayerBulletCollidingWithRect:(CGRect)rect
{
	return [self isBulletCollidingWithRect:rect usePlayerBullets:YES];
}

-(bool) isEnemyBulletCollidingWithRect:(CGRect)rect
{
	return [self isBulletCollidingWithRect:rect usePlayerBullets:NO];
}

-(bool) isBulletCollidingWithRect:(CGRect)rect usePlayerBullets:(bool)usePlayerBullets
{
	bool isColliding = NO;
	
	Bullet* bullet;
	CCARRAY_FOREACH([batch children], bullet)
	{
		if (bullet.visible && usePlayerBullets == bullet.isPlayerBullet)
		{
			if (CGRectIntersectsRect([bullet boundingBox], rect))
			{
				isColliding = YES;
				
				// remove the bullet
				bullet.visible = NO;
				break;
			}
		}
	}
	
	return isColliding;
}
@end
