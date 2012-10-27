//
//  ScriptAction.h
//  Drop
//
//  Created by Aaron on 12-10-24.
//
//

#import <Foundation/Foundation.h>
#import "Enemy.h"
#import "BasicMoveComponent.h"
typedef enum
{
    ColumnType = 0,
    ParallelType,
}ScriptActionType;

typedef enum
{
    InactiveState = 0,
    ActiveState,
    FinishedState,
}ScriptActionStatus;

@interface ScriptAction : NSObject
{
    EnemyTypes type;
    CGPoint startPosition;
    BasicMoveComponent* moveComponent;
    int num;
    float interval;
    float nextActionInterval;
    ScriptActionType actionType;
    ScriptActionStatus status;
}
@property (readonly,nonatomic)EnemyTypes type;
@property (readonly,nonatomic)CGPoint startPosition;
@property (nonatomic,retain)BasicMoveComponent* moveComponent;
@property (readonly,nonatomic)int num;
@property (readonly,nonatomic)float interval;
@property (readonly,nonatomic)float nextActionInterval;
@property (readonly,nonatomic)ScriptActionType actionType;
@property (nonatomic)ScriptActionStatus status;
+(id)scriptActionWithEnemyType:(EnemyTypes)theType startPosition:(CGPoint)theStartPosition moveComponent:(BasicMoveComponent*)theMoveComponent num:(int)theNum interval:(float)theInterval nextActionInterval:(float)theNextActionInterval actionType:(ScriptActionType)theActionType;
@end
