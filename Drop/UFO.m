//
//  UFO.m
//  Drop
//
//  Created by Aaron on 12-10-18.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "UFO.h"
#import "CCAnimation+Helper.h"
#import "HoverMoveComponent.h"
#import "StandardShootComponent.h"
#import "GameScene.h"

@implementation UFO

-(id) initWithAnimation
{
    if(self = [super initWithSpriteFrameName:@"enemy2_1.png"])
    {
//        shipInstance = self;
        
        initialHitPoints = 100;
        hitPoints = initialHitPoints;
        
        //表现形态
        CCAnimation* anim = [CCAnimation animationWithFrame:@"enemy2_" frameCount:4 delay:0.1f];
        CCAnimate* animate = [CCAnimate actionWithAnimation:anim];
        CCRepeatForever *repeat = [CCRepeatForever actionWithAction:animate];
        
        [self runAction:repeat];
        
        // Create the game logic components
        
        //添加设计与子弹类型
        shootFrequency = 3.0;
		
		shootComponent = [StandardShootComponent instanceWithStartPosition:self.position bulletFrameName:@"bullet1.png"];
        
        self.visible = NO;
        
//		[self initSpawnFrequency];
    }
    return self;
}

@end
