//
//  BattleShip.m
//  Drop
//
//  Created by Aaron on 12-11-1.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "BattleShip.h"
#import "StandardShootComponent.h"
#import "Ship.h"


@implementation BattleShip
-(id) initWithAnimation
{
    if (self = [super initWithSpriteFrameName:@"battleship_body.png"]) {
        initialHitPoints = 200;
        hitPoints = initialHitPoints;
        
        cannon = [CCSprite spriteWithSpriteFrameName:@"battleship_cannon.png"];
        
        cannon.position = ccp([self textureRect].size.width * 0.5,[self textureRect].size.width * 0.5);
        [self addChild:cannon];
        
        //添加设计与子弹类型
        shootFrequency = 4.0;
        
        shootComponent = [StandardShootComponent instanceWithStartPosition:self.position bulletFrameName:@"bullet3.png"];
        
        self.visible = NO;
    }
    
    return self;
}

-(void) update:(ccTime)delta
{
    //cannon转动
    //TODO 角度正负
    CGPoint shipPos = [Ship sharedShip].position;
    CGPoint v = ccpSub(self.position, lastPosition);
    CGPoint d = ccpSub(shipPos, self.position);
    CGFloat cross = ccpCross(v, d);
    float angle = ccpAngle(v, d);
    float degree = CC_RADIANS_TO_DEGREES(angle);
    if (cross < 0) {
        cannon.rotation = degree;
    }else{
        cannon.rotation = -degree;
    }
    
    //父类update需要放在最好调用，因为会改变lastPosition值
    [super update:delta];
}
@end
