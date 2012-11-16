//
//  Episode1.m
//  Drop
//
//  Created by Aaron on 12-10-24.
//
//

#import "Episode1.h"

@implementation Episode1
-(id) init
{
    if (self = [super init]) {
        //初始化scriptActions
        scriptActions = [[NSMutableArray alloc] init];
        //create game script here
        CGRect screenRect = [GameScene screenRect];
        CGPoint startPosition;
        CGPoint endPosition;
        ccBezierConfig c;
        BasicMoveComponent* move;
        ScriptAction *scriptAction;
        //.1
//        startPosition = ccp(screenRect.size.width,screenRect.size.height);
//        c.controlPoint_1 = ccp(0,20);
//        c.controlPoint_2 = ccp(10,10);
//        c.endPosition = ccp(360,240);
//        move = [CurveMoveComponent instanceWithBezierConfig:c];
//        scriptAction = [ScriptAction scriptActionWithEnemyType:FighterType startPosition:startPosition moveComponent:move num:5 interval:0.3 nextActionInterval:3 actionType:ColumnType];
//        [scriptActions addObject:scriptAction];
//        //.2
//        startPosition = ccp(0,screenRect.size.height);
//        c.controlPoint_1 = ccp(320,20);
//        c.controlPoint_2 = ccp(310,10);
//        c.endPosition = ccp(-40,240);
//        move = [CurveMoveComponent instanceWithBezierConfig:c];
//        scriptAction = [ScriptAction scriptActionWithEnemyType:FighterType startPosition:startPosition moveComponent:move num:5 interval:0.3 nextActionInterval:4 actionType:ColumnType];
//        [scriptActions addObject:scriptAction];
        //.3
        startPosition = ccp(screenRect.size.width * 0.8,screenRect.size.height);
        endPosition = ccp(startPosition.x,-200);
        move = [StandardMoveComponent instanceWithEndPosition:endPosition];
        scriptAction = [ScriptAction scriptActionWithEnemyType:BattleshipType startPosition:startPosition moveComponent:move num:1 interval:0.5 nextActionInterval:10 actionType:ParallelType];
        [scriptActions addObject:scriptAction];
        //.1
        startPosition = ccp(screenRect.size.width,screenRect.size.height);
        c.controlPoint_1 = ccp(0,20);
        c.controlPoint_2 = ccp(10,10);
        c.endPosition = ccp(360,240);
        move = [CurveMoveComponent instanceWithBezierConfig:c];
        scriptAction = [ScriptAction scriptActionWithEnemyType:FighterType startPosition:startPosition moveComponent:move num:5 interval:0.3 nextActionInterval:3 actionType:ColumnType];
        [scriptActions addObject:scriptAction];
        
        
    }
    return self;
}

-(void) dealloc
{
    [scriptActions release];
    [super dealloc];
}
@end
