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
#import "UFO.h"



@implementation Enemy

static CCArray* spawnFrequency;
+(Enemy*) enemy
{
    return [[[self alloc] initWithAnimation] autorelease];
}
-(id) initWithSpriteFrameName:(NSString*)spriteFrameName
{
    if (self = [super initWithSpriteFrameName:spriteFrameName]) {
        [self scheduleUpdate];
    }
    return self;
}

-(void) update:(ccTime)delta
{
    //TODO 改变飞机的飞行动画，左、右，前进
    //改变飞机的朝向，保持与velocity一致
    CGPoint nowPosition = self.position;
    //当位置改变时改变角度信息
    if (nowPosition.x != lastPosition.x || nowPosition.y != lastPosition.y) {
        float degree = CC_RADIANS_TO_DEGREES(atan2f(nowPosition.x - lastPosition.x,nowPosition.y - lastPosition.y));
        self.rotation = degree + 180;
        lastPosition = nowPosition;
    }
}

-(void) spawn
{
    //两步操作：1,visible设为yes;2,开始动move;【先执行子类的spawn再调用父类】
	// Finally set yourself to be visible
	self.visible = YES;
    
    [moveComponent move];
}

-(void) gotHit
{
    //    CCLOG(@"enemy got hit!");
	self.visible = NO;
    
    // Play a particle effect when the enemy was destroyed
    CCParticleSystem* system;
    system = [CCParticleSystemQuad particleWithFile:@"explosion.plist"];
    /*
     From stackoverflow.com:
     Effect: the sound file in your bundle you want to play.
     
     Pitch: [0.5 to 2.0] think of it as the "note" of the sound. Giving a higher pitch number makes the sound play at a "higher note". A lower value will make the sound lower or "deeper". 1.0 is pitch of original file.
     
     Pan: [-1.0 to 1.0] stereo affect. Below zero plays your sound more on the left side. Above 0 plays to the right. 0.0 is dead-center. (see note below)
     
     Gain: [0.0 and up] volume. 1.0 is the volume of the original file.
     
     There is a lot more in there to know. Best thing is get a simple file and play around.
     
     [edit] Note on Panning: If you feed in a stereo (2-channel) audio file and attempt to pan you will not hear any affect. Use a 1-channel file (mono) to enable panning.
     */
    [[SimpleAudioEngine sharedEngine] playEffect:@"explosion.wav" pitch:1.0f pan:0.0f gain:1.0f];
    
    
    // Set some parameters that can't be set in Particle Designer
    system.positionType = kCCPositionTypeFree;
    system.autoRemoveOnFinish = YES;
    system.position = self.position;
    
    // Add the particle effect to the GameScene, for these reasons:
    // - self is a sprite added to a spritebatch and will only allow CCSprite nodes (it crashes if you try)
    // - self is now invisible which might affect rendering of the particle effect
    // - since the particle effects are short lived, there is no harm done by adding them directly to the GameScene
    [[GameScene sharedGameScene] addChild:system];
}

//leave to children
-(id) initWithAnimation
{
    return nil;
}

-(void) initSpawnFrequency
{
    // initialize how frequent the enemies will spawn
	if (spawnFrequency == nil)
	{
		spawnFrequency = [[CCArray alloc] initWithCapacity:EnemyType_MAX];
		[spawnFrequency insertObject:[NSNumber numberWithInt:80] atIndex:UFOType];
		[spawnFrequency insertObject:[NSNumber numberWithInt:260] atIndex:CruiserType];
		[spawnFrequency insertObject:[NSNumber numberWithInt:400] atIndex:BossType];
		
		// spawn one enemy immediately
//		[self spawn];
	}
}

+(int) getSpawnFrequencyForEnemyType:(EnemyTypes)enemyType
{
	NSAssert(enemyType < EnemyType_MAX, @"invalid enemy type");
	NSNumber* number = [spawnFrequency objectAtIndex:enemyType];
	return [number intValue];
}

-(void) dealloc
{
    [spawnFrequency release];
    spawnFrequency = nil;
    
    [super dealloc];
}
@end
