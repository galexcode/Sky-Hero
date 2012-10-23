//
//  Ship.m
//  Drop
//
//  Created by Aaron on 12-10-11.
//
//
#import "CCAnimation+Helper.h"
#import "Ship.h"
#import "BulletCache.h"
#import "GameScene.h"
#import "SimpleAudioEngine.h"
#import "GameOverLayer.h"

@interface Ship(PrivateMethods)
-(id) initWithShipImage;
@end

@implementation Ship
@synthesize playerVelocity;
static Ship* shipInstance;
+(Ship*) ship
{
    return [[[self alloc] initWithShipImage] autorelease];
}
+(Ship*) sharedShip
{
	NSAssert(shipInstance != nil, @"shipInstance not yet initialized!");
	return shipInstance;
}
-(id) initWithShipImage
{
    if(self = [super initWithSpriteFrameName:@"plane.png"])
    {
        shipInstance = self;
        
        [self reset];
        //表现形态
        CCAnimation* anim = [CCAnimation animationWithFrame:@"plane" frameCount:2 delay:0.08f];
        CCAnimate* animate = [CCAnimate actionWithAnimation:anim];
        CCRepeatForever *repeat = [CCRepeatForever actionWithAction:animate];
        
        [self runAction:repeat];
        [self scheduleUpdate];
    }
    return self;
}

-(void) reset
{
    initialHitPoints = 100;
    hitPoints = initialHitPoints;
    self.visible = true;
}

-(void)update:(ccTime)delta
{
    //更新player位置
    CGPoint pos = self.position;
    pos.x += playerVelocity.x * 2;
    
    float imageWidthHalved = [self textureRect].size.width * 0.5f;
    float leftBorderLimit = imageWidthHalved;
    float rightBorderLimit = [GameScene screenRect].size.width - imageWidthHalved;
    if (pos.x < leftBorderLimit) {
        pos.x = leftBorderLimit;
    }else if (pos.x >rightBorderLimit)
    {
        pos.x = rightBorderLimit;
        playerVelocity = CGPointZero;
    }
    self.position = pos;
    
    //发射子弹
    totalTime += delta;
    if(totalTime > nextShotTime)
    {
        nextShotTime = totalTime + 0.4f;
        CGPoint shotPos = ccp(self.position.x, self.position.y);
        CGPoint velocity = ccp(0,200);
        [[GameScene sharedGameScene].bulletCache shootBulletAt:shotPos velocity:velocity frameName:@"bullet.png" isPlayerBullet:YES];
    }
    
    [self checkForBulletCollisions];
}

-(void) checkForBulletCollisions
{
    BulletCache* bulletCache = [[GameScene sharedGameScene] bulletCache];
    CGRect bbox = [self boundingBox];
    if([bulletCache isEnemyBulletCollidingWithRect:bbox])
    {
        [self gotHit];
    }
}

-(void) gotHit
{
    hitPoints -= 10;
    if(hitPoints <= 0){
        //Game Over
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
        
        //调用Game Over层
        [GameOverLayer layerWithDelegate:[GameScene sharedGameScene]];
        
    }
}
@end