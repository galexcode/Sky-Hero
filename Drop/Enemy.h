//
//  Enemy.h
//  Drop
//
//  Created by Aaron on 12-10-14.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Entity.h"
#import "BasicMoveComponent.h"
#import "BasicShootComponent.h"

typedef enum
{
    UFOType = 0,
    CruiserType,
    BossType,
    EnemyType_MAX,
}EnemyTypes;
@interface Enemy : Entity {
    EnemyTypes type;
    float shootFrequency;
    
    BOOL isOnScreen;
    
    //上一帧的位置
    CGPoint lastPosition;
    
    CGPoint startPosition;
    
    //移动方式
    BasicMoveComponent* moveComponent;
    
    //设计方式
//    BasicShootComponent* shootComponent;
}
+(Enemy*) enemy;
+(int) getSpawnFrequencyForEnemyType:(EnemyTypes)enemyType;
-(void) initSpawnFrequency;
-(id) initWithAnimation;
-(void) spawn;
-(void) gotHit;
-(void) reset;
@end
