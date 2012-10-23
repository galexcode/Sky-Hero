//
//  EnemyCache.m
//  Drop
//
//  Created by Aaron on 12-10-14.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "EnemyCache.h"
#import "Bullet.h"
#import "GameScene.h"
#import "EnemyFactory.h"

@interface EnemyCache (PrivateMethods)
-(void) initEnemies;
@end

@implementation EnemyCache
-(id) init
{
    if(self = [super init])
    {
        CCSpriteFrame* frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"enemy1.png"];
        batch = [CCSpriteBatchNode batchNodeWithTexture:frame.texture];
        [self addChild:batch];
        
        [self initEnemies];
        [self scheduleUpdate];
    }
    return self;
}

-(void) initEnemies
{
    //must 'alloc' the memeory or it will be freed after leaving the initEnemies method
    enemies = [[CCArray alloc] initWithCapacity:EnemyType_MAX];
    
    for(int i=0;i<EnemyType_MAX;i++)
    {
        int capacity;
        switch (i) {
            case UFOType:
                capacity = 6;
                break;
            case CruiserType:
                capacity = 3;
                break;
            case BossType:
                capacity = 1;
                break;
            default:
                [NSException exceptionWithName:@"EnemyCache Exception" reason:@"unhandled enemy type" userInfo:nil];
                break;
        }
        CCArray* enemiesOfType = [CCArray arrayWithCapacity:capacity];
        [enemies addObject:enemiesOfType];
    }
    
    //生成enemy对象做cache
    for (int i = 0; i < EnemyType_MAX; i++)
	{
		CCArray* enemiesOfType = [enemies objectAtIndex:i];
		int numEnemiesOfType = [enemiesOfType capacity];
		
		for (int j = 0; j < numEnemiesOfType; j++)
		{
			Enemy* enemy = [EnemyFactory enemyWithType:i];
			[batch addChild:enemy z:0 tag:i];
			[enemiesOfType addObject:enemy];
		}
	}
}

-(void) spawnEnemyOfType:(EnemyTypes)enemyType
{
	CCArray* enemiesOfType = [enemies objectAtIndex:enemyType];
	
	Enemy* enemy;
	CCARRAY_FOREACH(enemiesOfType, enemy)
	{
		// find the first free enemy and respawn it
		if (enemy.visible == NO)
		{
			//CCLOG(@"spawn enemy type %i", enemyType);
			[enemy spawn];
			break;
		}
	}
}

//生产enemy的算法，这里是隔一固定时间就产生
//TODO 改算法
-(void) update:(ccTime)delta
{
	updateCount++;
    
	for (int i = EnemyType_MAX - 1; i >= 0; i--)
	{
		int spawnFrequency = [Enemy getSpawnFrequencyForEnemyType:i];
		
		if (updateCount % spawnFrequency == 0)
		{
			[self spawnEnemyOfType:i];
			break;
		}
	}
    [self checkForBulletCollisions];
}

-(void) checkForBulletCollisions
{
	Enemy* enemy;
	CCARRAY_FOREACH([batch children], enemy)
	{
		if (enemy.visible)
		{
			BulletCache* bulletCache = [[GameScene sharedGameScene] bulletCache];
			CGRect bbox = [enemy boundingBox];
			if ([bulletCache isPlayerBulletCollidingWithRect:bbox])
			{
				// This enemy got hit ...
				[enemy gotHit];
			}
		}
	}
}

-(void) dealloc
{
    [enemies release];
    [super dealloc];
}
@end
