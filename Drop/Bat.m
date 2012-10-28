//
//  Bat.m
//  Drop
//
//  Created by Aaron on 12-10-18.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "Bat.h"
#import "CCAnimation+Helper.h"
#import "StandardMoveComponent.h"
#import "StandardShootComponent.h"
#import "GameScene.h"


@implementation Bat

-(id) initWithAnimation
{
    if(self = [super initWithSpriteFrameName:@"enemy3_0.png"])
    {
        //        shipInstance = self;
        
        initialHitPoints = 50;
        hitPoints = initialHitPoints;
        //表现形态
        CCAnimation* anim = [CCAnimation animationWithFrame:@"enemy3_" frameCount:2 delay:0.3f];
        CCAnimate* animate = [CCAnimate actionWithAnimation:anim];
        CCRepeatForever *repeat = [CCRepeatForever actionWithAction:animate];
        
        [self runAction:repeat];
        
        //添加设计与子弹类型
        shootFrequency = 4.0;
		
		shootComponent = [StandardShootComponent instanceWithStartPosition:self.position bulletFrameName:@"bullet1.png"];
        
        self.visible = NO;
        
//		[self initSpawnFrequency];
    }
    return self;
}

@end
