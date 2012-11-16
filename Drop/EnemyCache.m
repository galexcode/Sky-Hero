//
//  EnemyCache.m
//  Drop
//
//  Created by Aaron on 12-10-14.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "EnemyCache.h"

@interface EnemyCache (PrivateMethods)
-(void) initEnemies;
@end

@implementation EnemyCache
@synthesize batch;
-(id) init
{
    if(self = [super init])
    {
        CCSpriteFrame* frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"fighter.png"];
        batch = [CCSpriteBatchNode batchNodeWithTexture:frame.texture];
        [self addChild:batch];
        
        [self initEnemies];
//        [self scheduleUpdate];
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
                capacity = 4;
                break;
            case BatType:
                capacity = 4;
                break;
            case BattleshipType:
                capacity = 4;
                break;
            case FighterType:
                capacity = 20;
            case StrikerType:
                capacity = 20;
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

-(void) spawnEnemyOfType:(EnemyTypes)enemyType startPosition:(CGPoint)theStartPosition  moveComponent:(BasicMoveComponent*)theMoveComponent
{
	CCArray* enemiesOfType = [enemies objectAtIndex:enemyType];
	
	Enemy* enemy;
	CCARRAY_FOREACH(enemiesOfType, enemy)
	{
		// find the first free enemy and respawn it
		if (enemy.visible == NO)
		{
			NSAssert(theMoveComponent != nil, @"Movement is nil when spawn enemy");
            enemy.startPosition = theStartPosition;
            enemy.moveComponent = theMoveComponent;
			[enemy spawn];
            CCLOG(@"enemy spawned,start position=(%lf,%lf)",enemy.startPosition.x,enemy.startPosition.y);
			break;
		}
	}
}

//生产enemy的算法，这里是隔一固定时间就产生
//TODO 改算法
//-(void) update:(ccTime)delta
//{
//	updateCount++;
//    
//	for (int i = EnemyType_MAX - 1; i >= 0; i--)
//	{
//		int spawnFrequency = [Enemy getSpawnFrequencyForEnemyType:i];
//		
//		if (updateCount % spawnFrequency == 0)
//		{
//			[self spawnEnemyOfType:i];
//			break;
//		}
//	}
//    [self checkForBulletCollisions];
//}



-(void) dealloc
{
    [enemies release];
    [super dealloc];
}
@end
