//
//  Entity.m
//  Drop
//
//  Created by Aaron on 12-10-14.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "Entity.h"
#import "GameScene.h"

@implementation Entity
@synthesize hitPoints,initialHitPoints;
-(void) setPosition:(CGPoint)pos
{
    if ([self isInsideScreenArea]) {
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
		float halfWidth = self.contentSize.width * 0.5f;
		float halfHeight = self.contentSize.height * 0.5f;
		
		// Cap the position so the Ship's sprite stays on the screen
		if (pos.x < halfWidth)
		{
			pos.x = halfWidth;
		}
		else if (pos.x > (screenSize.width - halfWidth))
		{
			pos.x = screenSize.width - halfWidth;
		}
		
		if (pos.y < halfHeight)
		{
			pos.y = halfHeight;
		}
		else if (pos.y > (screenSize.height - halfHeight))
		{
			pos.y = screenSize.height - halfHeight;
		}
    }
    [super setPosition:pos];
}
-(BOOL) isInsideScreenArea
{
    return CGRectContainsRect([GameScene screenRect], [self boundingBox]);
}
@end
