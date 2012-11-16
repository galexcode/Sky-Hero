//
//  Striker.m
//  Drop
//
//  Created by Aaron on 12-11-1.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "Striker.h"
#import "StandardShootComponent.h"


@implementation Striker
-(id) initWithAnimation
{
    if(self = [super initWithSpriteFrameName:@"striker.png"])
    {
        initialHitPoints = 40;
        hitPoints = initialHitPoints;
        
        //添加设计与子弹类型
        shootFrequency = 1.0;
		
		shootComponent = [StandardShootComponent instanceWithStartPosition:self.position bulletFrameName:@"bullet1.png"];
        
        self.visible = NO;
    }
    return self;
}
@end
