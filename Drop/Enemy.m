//
//  Enemy.m
//  Drop
//
//  Created by Aaron on 12-10-14.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "Enemy.h"
#import "GameScene.h"
#import "SimpleAudioEngine.h"

@implementation Enemy
@synthesize moveComponent;
@synthesize startPosition;
@synthesize score;

//static CCArray* spawnFrequency;
+(Enemy*) enemy
{
    return [[[self alloc] initWithAnimation] autorelease];
}
//-(id) initWithSpriteFrameName:(NSString*)spriteFrameName
//{
//    if (self = [super initWithSpriteFrameName:spriteFrameName]) {
////        [self scheduleUpdate];
//    }
//    return self;
//}

-(void) update:(ccTime)delta
{
    //判断飞机是否飞出屏幕，收回资源
    CGSize size = self.textureRect.size;
    CGRect screenRect = [GameScene screenRect];
    float screenWidth = screenRect.size.width;
    float screenHeight = screenRect.size.height;
    float halfWidth = size.width * 0.5;
    float halfHeight = size.height * 0.5;
    if (!isOnScreen && CGRectContainsRect(screenRect, [self boundingBox])) {
        isOnScreen = YES;
    }
    if (isOnScreen && (self.position.x - halfWidth > screenWidth || self.position.x + halfWidth < 0 || self.position.y - halfHeight > screenHeight || self.position.y + halfHeight < 0)) {
        //out of boundary
        self.visible = NO;
        //不在屏幕上
        isOnScreen = NO;
        //stop actions to prevent wrong moves
//        [self stopAllActions];
        //停止监听
        [self unscheduleUpdate];
        return;
    }
    //TODO 改变飞机的飞行动画，左、右，前进
    
    //改变飞机的朝向，保持与velocity一致
    CGPoint nowPosition = self.position;
    //当位置改变时改变角度信息
    if (nowPosition.x != lastPosition.x || nowPosition.y != lastPosition.y) {
        float degree = CC_RADIANS_TO_DEGREES(atan2f(nowPosition.x - lastPosition.x,nowPosition.y - lastPosition.y));
        self.rotation = degree + 180;
        lastPosition = nowPosition;
    }
    
    //飞机射击
    shootingTime += delta;
    if (shootingTime >= shootFrequency) {
        shootComponent.startPosition = self.position;
        shootingTime = 0;
        [shootComponent shoot];
    }
}
-(void) reset
{
    
}

-(void) spawn
{
    //两步操作：1,visible设为yes;2,开始动move;【先执行子类的spawn再调用父类】
	// Finally set yourself to be visible
    self.position = startPosition;
    
    shootComponent.startPosition = startPosition;
    
    //开始逐帧监听
    [self scheduleUpdate];
    
	self.visible = YES;
    
    [self runAction:[moveComponent move]];
}

-(void) gotHit
{
    hitPoints-=10;
    if (hitPoints <= 0) {
        //destroied
        hitPoints = initialHitPoints;
        self.visible = NO;
        //不在屏幕上
        isOnScreen = NO;
        
        //停止监听
        [self unscheduleUpdate];
        
        //sound effect
        [[SimpleAudioEngine sharedEngine] playEffect:@"explosion.wav" pitch:1.0f pan:0.0f gain:1.0f];
        
        // Play a particle effect when the enemy was destroyed
        CCParticleSystem* system;
        system = [CCParticleSystemQuad particleWithFile:@"explosion.plist"];
        // Set some parameters that can't be set in Particle Designer
        system.positionType = kCCPositionTypeFree;
        system.autoRemoveOnFinish = YES;
        system.position = self.position;
        
        GameScene *scene = [GameScene sharedGameScene];
        
        [scene updateScore:score];
        
        [scene addChild:system];
    }
    /*
     From stackoverflow.com:
     Effect: the sound file in your bundle you want to play.
     
     Pitch: [0.5 to 2.0] think of it as the "note" of the sound. Giving a higher pitch number makes the sound play at a "higher note". A lower value will make the sound lower or "deeper". 1.0 is pitch of original file.
     
     Pan: [-1.0 to 1.0] stereo affect. Below zero plays your sound more on the left side. Above 0 plays to the right. 0.0 is dead-center. (see note below)
     
     Gain: [0.0 and up] volume. 1.0 is the volume of the original file.
     
     There is a lot more in there to know. Best thing is get a simple file and play around.
     
     [edit] Note on Panning: If you feed in a stereo (2-channel) audio file and attempt to pan you will not hear any affect. Use a 1-channel file (mono) to enable panning.
     */
    
    // Add the particle effect to the GameScene, for these reasons:
    // - self is a sprite added to a spritebatch and will only allow CCSprite nodes (it crashes if you try)
    // - self is now invisible which might affect rendering of the particle effect
    // - since the particle effects are short lived, there is no harm done by adding them directly to the GameScene
}

//leave to children
-(id) initWithAnimation
{
    return nil;
}

-(void) dealloc
{
//    [spawnFrequency release];
//    spawnFrequency = nil;
    [moveComponent release];
    [shootComponent release];
    [super dealloc];
}
@end
