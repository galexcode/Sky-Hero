//
//  Bullet.m
//  Drop
//
//  Created by Aaron on 12-10-13.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "Bullet.h"
#import "GameScene.h"
@interface Bullet (PrivateMethods)
-(id) initWithBulletImage;
@end

@implementation Bullet
@synthesize velocity;
@synthesize isPlayerBullet;
+(id) bullet
{
    return [[[self alloc] initWithBulletImage] autorelease];
}
-(id) initWithBulletImage
{
    // Uses the Texture Atlas now.
	if ((self = [super initWithSpriteFrameName:@"bullet0.png"]))
	{
	}
	
	return self;
}
-(void) shootBulletAt:(CGPoint)startPosition velocity:(CGPoint)vel frameName:(NSString*)frameName isPlayerBullet:(bool) playerBullet
{
    self.velocity = vel;
    self.position = startPosition;
    self.visible = YES;
    self.isPlayerBullet = playerBullet;
    
    CCSpriteFrame* frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:frameName];
    [self setDisplayFrame:frame];
    [self unscheduleUpdate];
    [self scheduleUpdate];
}
-(void) update:(ccTime)delta
{
    self.position = ccpAdd(self.position, ccpMult(self.velocity, delta));
    
    CGPoint nowPosition = self.position;
    
    if (nowPosition.x != lastPosition.x || nowPosition.y != lastPosition.y) {
        float degree = CC_RADIANS_TO_DEGREES(atan2f(nowPosition.x - lastPosition.x,nowPosition.y - lastPosition.y));
        self.rotation = degree + 180;
        lastPosition = nowPosition;
    }
    
    if(CGRectContainsRect([self boundingBox], [GameScene screenRect]))
    {
        self.visible = NO;
        [self unscheduleUpdate];
    }
}
@end
