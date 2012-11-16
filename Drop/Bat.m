//
//  Bat.m
//  Drop
//
//  Created by Aaron on 12-10-18.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "Bat.h"
#import "StandardShootComponent.h"


@implementation Bat

-(id) initWithAnimation
{
    if(self = [super initWithSpriteFrameName:@"bat.png"])
    {
        initialHitPoints = 50;
        hitPoints = initialHitPoints;
        
        //添加设计与子弹类型
        shootFrequency = 4.0;
		
		shootComponent = [StandardShootComponent instanceWithStartPosition:self.position bulletFrameName:@"bullet2.png"];
        
        self.visible = NO;
        
    }
    return self;
}

@end
