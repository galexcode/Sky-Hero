//
//  Fighter.m
//  Drop
//
//  Created by Aaron on 12-10-18.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "Fighter.h"
#import "CCAnimation+Helper.h"
#import "StandardMoveComponent.h"
#import "StandardShootComponent.h"
#import "GameScene.h"


@implementation Fighter

-(id) initWithAnimation
{
    if(self = [super initWithSpriteFrameName:@"enemy1.png"])
    {
        //        shipInstance = self;
        
        initialHitPoints = 40;
        hitPoints = initialHitPoints;
        
        //添加设计与子弹类型
        shootFrequency = 1.0;
		
		shootComponent = [StandardShootComponent instanceWithStartPosition:self.position bulletFrameName:@"bullet1.png"];
        
        self.visible = NO;
        
//		[self initSpawnFrequency];
    }
    return self;
}

@end
