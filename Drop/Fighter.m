//
//  Fighter.m
//  Drop
//
//  Created by Aaron on 12-10-18.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "Fighter.h"
#import "StandardShootComponent.h"


@implementation Fighter

-(id) initWithAnimation
{
    if(self = [super initWithSpriteFrameName:@"fighter.png"])
    {
        initialHitPoints = 40;
        hitPoints = initialHitPoints;
        score = 10;
        
        //添加设计与子弹类型
        shootFrequency = 1.0;
		
		shootComponent = [StandardShootComponent instanceWithStartPosition:self.position bulletFrameName:@"bullet1.png"];
        
        self.visible = NO;
    }
    return self;
}

@end
