//
//  ScriptAction.m
//  Drop
//
//  Created by Aaron on 12-10-24.
//
//

#import "ScriptAction.h"

@implementation ScriptAction
@synthesize type;
@synthesize startPosition;
@synthesize moveComponent;
@synthesize num;
@synthesize interval;
@synthesize nextActionInterval;
@synthesize actionType;
@synthesize status;
+(id)scriptActionWithEnemyType:(EnemyTypes)theType startPosition:(CGPoint)theStartPosition moveComponent:(BasicMoveComponent*)theMoveComponent num:(int)theNum interval:(float)theInterval nextActionInterval:(float)theNextActionInterval actionType:(ScriptActionType)theActionType
{
    return [[[self alloc] initWithEnemyType:theType startPosition:theStartPosition moveComponent:theMoveComponent num:theNum interval:theInterval nextActionInterval:theNextActionInterval actionType:theActionType] autorelease];
}

-(id)initWithEnemyType:(EnemyTypes)theType startPosition:(CGPoint)theStartPosition moveComponent:(BasicMoveComponent*)theMoveComponent num:(int)theNum interval:(float)theInterval nextActionInterval:(float)theNextActionInterval actionType:(ScriptActionType)theActionType
{
    if (self = [super init]) {
        type = theType;
        startPosition = theStartPosition;
        self.moveComponent = theMoveComponent;
        num = theNum;
        interval = theInterval;
        nextActionInterval = theNextActionInterval;
        actionType = theActionType;
    }
    return self;
}
@end
