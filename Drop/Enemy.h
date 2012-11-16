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
    FighterType,
    StrikerType,
    BatType,
    BattleshipType,
    EnemyType_MAX,
}EnemyTypes;
@interface Enemy : Entity {
    EnemyTypes type;
    //射击频率
    float shootFrequency;
    float shootingTime;
    //击落后的得分
    int score;
    
    BOOL isOnScreen;
    
    //上一帧的位置
    CGPoint lastPosition;
    
    CGPoint startPosition;
    
    //移动方式
    BasicMoveComponent* moveComponent;
    
    //设计方式
    BasicShootComponent* shootComponent;
}
+(Enemy*) enemy;
-(id) initWithAnimation;
-(void) spawn;
-(void) gotHit;
-(void) reset;
-(void) update:(ccTime)delta;
@property (nonatomic,copy)BasicMoveComponent* moveComponent;
@property (nonatomic)CGPoint startPosition;
@property (nonatomic,readonly)int score;
@end
