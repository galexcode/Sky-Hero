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
        
        // Create the game logic components
        moveComponent = [StandardMoveComponent instanceWithEndPosition:ccp(0,0)];
		[self addChild:moveComponent];
        
        //添加设计与子弹类型
        shootFrequency = 1.0;
		
		StandardShootComponent* shootComponent = [StandardShootComponent node];
		shootComponent.shootFrequency = shootFrequency;
		shootComponent.bulletFrameName = @"bullet1.png";
		[self addChild:shootComponent];
        
        self.visible = NO;
        
		[self initSpawnFrequency];
    }
    return self;
}

-(void) spawn
{
    CGRect screenRect = [GameScene screenRect];
	CGSize spriteSize = [self contentSize];
	float xPos = CCRANDOM_0_1() * (screenRect.size.width - spriteSize.width) + spriteSize.width * 0.5f;
	float yPos = screenRect.size.height + spriteSize.height * 0.5f;
    
	self.position = CGPointMake(xPos, yPos);
    
    [super spawn];
    
}
@end
